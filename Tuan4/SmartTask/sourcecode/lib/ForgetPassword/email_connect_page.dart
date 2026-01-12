import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class EmailConnectPage extends StatefulWidget {
  const EmailConnectPage({super.key});

  @override
  State<EmailConnectPage> createState() => _EmailConnectPageState();
}

class _EmailConnectPageState extends State<EmailConnectPage> {
  final _remoteConfig = FirebaseRemoteConfig.instance;
  final _auth = FirebaseAuth.instance;
  final _analytics = FirebaseAnalytics.instance;
  final _email = TextEditingController();

  String _buttonColorHex = "0xFF2196F3"; // Màu mặc định (Blue)
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchRemoteConfig();
  }

  // Lấy màu nút từ Remote Config
  Future<void> _fetchRemoteConfig() async {
    try {
      await _remoteConfig.fetchAndActivate();
      setState(() {
        // Lấy giá trị button_color từ Firebase Console
        _buttonColorHex = _remoteConfig.getString("button_color");
      });
    } on FirebaseAuthException catch (e) {
      print(
        "Mã lỗi Firebase: ${e.code}",
      ); // Thêm dòng này để xem mã lỗi chính xác trong console
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Lỗi: ${e.message}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Hàm gửi Email Reset Password của Firebase
  Future<void> _sendResetEmail(String email) async {
    final email = _email.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập Email của bạn")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _auth.sendPasswordResetEmail(email: email);
      await _analytics.logEvent(
        name: 'forgot_password_request',
        parameters: {'email': email},
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Link đặt lại mật khẩu đã được gửi! Kiểm tra Email của bạn.",
            ),
            backgroundColor: Colors.green,
          ),
        );
        // Sau khi gửi thành công, quay lại trang Login
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Lỗi: ${e.message}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage('assets/images/logo_uth.png'),
                  width: 100,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image, size: 100, color: Colors.grey),
                ),
                const Text(
                  'Smart Tasks',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Quên mật khẩu?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Nhập Email của bạn, chúng tôi sẽ gửi link để đặt lại mật khẩu mới.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email của bạn',
                    prefixIcon: const Icon(Icons.email_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () => _sendResetEmail(_email.text),
                    style: ElevatedButton.styleFrom(
                      // Sử dụng màu từ Remote Config
                      backgroundColor: Color(int.parse(_buttonColorHex)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Gửi Link Khôi Phục',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

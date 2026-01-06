import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nullable Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const NullableDemoPage(),
    );
  }
}

class NullableDemoPage extends StatefulWidget {
  const NullableDemoPage({super.key});

  @override
  State<NullableDemoPage> createState() => _NullableDemoPageState();
}

class _NullableDemoPageState extends State<NullableDemoPage> {
  String? nullableString;
  int? nullableNumber;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NULLABLE DEMO'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('1. Nullable (?)'),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('String? nullableString = null'),
                  const SizedBox(height: 8),
                  Text('Giá trị: ${nullableString ?? "null"}'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        nullableString = 'Hello World';
                      });
                    },
                    child: const Text('Gán giá trị'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        nullableString = null;
                      });
                    },
                    child: const Text('Set null'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            _buildSectionTitle('2. Nullable Conditional (?.)'),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Nhập chuỗi (có thể để trống)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Độ dài: ${_controller.text.isEmpty ? "null" : _controller.text.length}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sử dụng ?. : ${_controller.text.isEmpty ? null : _controller.text}?.length',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            _buildSectionTitle('3. Elvis Operator (?:)'),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('int? nullableNumber = $nullableNumber'),
                  const SizedBox(height: 8),
                  Text(
                    'Giá trị hiển thị: ${nullableNumber ?? 0}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Code: nullableNumber ?? 0',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            nullableNumber = 100;
                          });
                        },
                        child: const Text('Gán 100'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            nullableNumber = null;
                          });
                        },
                        child: const Text('Set null'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            _buildSectionTitle('4. Ví dụ thực tế'),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quản lý thông tin sản phẩm:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildProductInfo('Tên sản phẩm', 'Laptop Dell'),
                  _buildProductInfo('Giá', null, isPrice: true),
                  _buildProductInfo('Số lượng', null),
                  const SizedBox(height: 12),
                  const Text(
                    '→ Các trường null hiển thị "Chưa có dữ liệu" thay vì 0',
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            _buildSectionTitle('5. Tóm tắt'),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryItem('?', 'Khai báo biến nullable'),
                  _buildSummaryItem('?.', 'Truy cập an toàn (safe call)'),
                  _buildSummaryItem('??', 'Giá trị mặc định (Elvis)'),
                  _buildSummaryItem('??=', 'Gán nếu null'),
                  _buildSummaryItem('!', 'Ép kiểu non-null (nguy hiểm)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      elevation: 2,
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }

  Widget _buildProductInfo(
    String label,
    String? value, {
    bool isPrice = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value ?? 'Chưa có dữ liệu',
            style: TextStyle(
              color: value == null ? Colors.red : Colors.black,
              fontStyle: value == null ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String operator, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 40,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              operator,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(description)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

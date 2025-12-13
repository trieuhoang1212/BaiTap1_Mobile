import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CalculatePage(),
    );
  }
}

class CalculatePage extends StatefulWidget {
  const CalculatePage({super.key});
  final String title = 'THỰC HÀNH 03';
  @override
  State<CalculatePage> createState() => _CalculatePage();
}

class _CalculatePage extends State<CalculatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 60, 109),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                textAlign: TextAlign.left,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Nhập giá trị A',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 12,
                  ),
                ),
                style: TextStyle(
                  fontSize: 12,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text('+')),
          ],
        ),
      ),
    );
  }
}

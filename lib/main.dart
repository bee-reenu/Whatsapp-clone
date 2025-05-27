import 'package:clone/Login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp clone Team-5',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF111B21),
          title: const Text(
            'Bee WhatsApp',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: LoginPage(),
      ),
    );
  }
}

import 'package:clone/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final username = numberController.text;
    final password = passwordController.text;

    // Hardcoded credentials for simplicity
    if ((username == "9060807888" && password == "1234") ||
        (username == "8088829429" && password == "7899")) {
      await prefs.setString('loggedInUser', username);
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid credentials")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          color: const Color(0xFF005D4B),
          child: SizedBox(
            width: 500,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                      controller: numberController,
                      decoration: const InputDecoration(labelText: 'Username')),
                  TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () => login(context),
                      child: const Text("Login")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

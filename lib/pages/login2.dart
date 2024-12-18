import 'package:flutter/material.dart';
import '../db_helper.dart';
import '../services/shared_prefs.dart';
import 'homepage.dart';

class LoginPage2 extends StatelessWidget {
  const LoginPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final DatabaseHelper dbHelper = DatabaseHelper();

    void login() async {
      String email = emailController.text;
      String password = passwordController.text;

      var user = await dbHelper.getUser(email, password);
      if (user != null) {
        await SharedPrefs.saveLoginStatus(email);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email atau password salah')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 16),
            TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

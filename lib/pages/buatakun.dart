import 'package:flutter/material.dart';
import '../db_helper.dart';
import 'login.dart';

class BuatAkunPage extends StatefulWidget {
  const BuatAkunPage({Key? key}) : super(key: key);

  @override
  _BuatAkunPageState createState() => _BuatAkunPageState();
}

class _BuatAkunPageState extends State<BuatAkunPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper();

  void _register() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isNotEmpty && password.length >= 8) {
      await _dbHelper.registerUser(email, password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Akun berhasil dibuat!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password minimal 8 karakter')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Informasi Akun')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              child: const Text('Selanjutnya'),
            ),
          ],
        ),
      ),
    );
  }
}

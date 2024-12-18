import 'package:flutter/material.dart';
import 'login2.dart';
import 'buatakun.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              // Judul Halaman
              const Text(
                "Selamat datang di aplikasi lombaku",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Masuk atau daftar akun untuk melanjutkan",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Spacer(),
              // Tombol Login
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigasi ke halaman LoginPage2
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage2(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Masuk"),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Tombol Daftar Akun
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // Navigasi ke halaman BuatAkunPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BuatAkunPage(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Daftar akun"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

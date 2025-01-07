import 'package:flutter/material.dart';
import 'package:flutter_application_1/db_helper.dart';

class InfoLombaPage extends StatelessWidget {
  final String title;
  final String image;

  const InfoLombaPage({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  Future<void> _saveCompetition(String title, String image) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.saveCompetition(title, image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color.fromARGB(255, 255, 213, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(image, height: 150, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Deskripsi Lomba',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ini adalah deskripsi lomba...',
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 213, 0),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onPressed: () async {
                await _saveCompetition(title, image);

                // Tampilkan pesan sukses
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$title berhasil diikuti!'),
                    duration: const Duration(seconds: 2),
                  ),
                );

                // Kembali ke halaman sebelumnya
                Navigator.pop(context);
              },
              child: const Text(
                'Ikuti Lomba',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

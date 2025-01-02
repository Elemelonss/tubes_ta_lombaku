import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class InfoLombaPage extends StatelessWidget {
  final String title;
  final String image;

  const InfoLombaPage({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  Future<void> _saveCompetition(String title, String image) async {
    final prefs = await SharedPreferences.getInstance();
    final savedCompetitions = prefs.getString('myCompetitions');

    // Decode JSON ke List<Map<String, dynamic>>
    List<Map<String, dynamic>> competitions = savedCompetitions != null
        ? List<Map<String, dynamic>>.from(jsonDecode(savedCompetitions) as List)
        : [];

    // Konversi ke List<Map<String, String>>
    List<Map<String, String>> competitionList = competitions.map((competition) {
      return competition
          .map((key, value) => MapEntry(key.toString(), value.toString()));
    }).toList();

    // Tambahkan lomba baru jika belum ada
    if (!competitionList.any((competition) => competition['title'] == title)) {
      competitionList.add({'title': title, 'image': image});
      await prefs.setString('myCompetitions', jsonEncode(competitionList));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.amber[800],
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
                backgroundColor: Colors.amber[800],
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

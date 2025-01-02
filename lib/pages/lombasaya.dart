import 'package:flutter/material.dart';
import 'dart:convert'; // Untuk jsonEncode dan jsonDecode
import 'package:shared_preferences/shared_preferences.dart';

class LombaSayaPage extends StatefulWidget {
  const LombaSayaPage({Key? key}) : super(key: key);

  @override
  _LombaSayaPageState createState() => _LombaSayaPageState();
}

class _LombaSayaPageState extends State<LombaSayaPage> {
  List<Map<String, String>> myCompetitions = [];

  @override
  void initState() {
    super.initState();
    _loadMyCompetitions();
  }

  // Memuat daftar lomba yang diikuti dari SharedPreferences
  Future<void> _loadMyCompetitions() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCompetitions = prefs.getString('myCompetitions');
    if (savedCompetitions != null) {
      setState(() {
        myCompetitions = (jsonDecode(savedCompetitions) as List)
            .map((item) => Map<String, String>.from(item as Map))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lomba Saya'),
        backgroundColor: Colors.amber[800],
      ),
      body: myCompetitions.isEmpty
          ? const Center(
              child: Text(
                'Belum ada lomba yang diikuti',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: myCompetitions.length,
              itemBuilder: (context, index) {
                final item = myCompetitions[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 12.0),
                  child: ListTile(
                    leading: Image.asset(item['image']!,
                        width: 50, fit: BoxFit.cover),
                    title: Text(item['title']!),
                  ),
                );
              },
            ),
    );
  }
}

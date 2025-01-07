import 'package:flutter/material.dart';
import 'package:flutter_application_1/db_helper.dart';

class LombaSayaPage extends StatefulWidget {
  const LombaSayaPage({Key? key}) : super(key: key);

  @override
  _LombaSayaPageState createState() => _LombaSayaPageState();
}

class _LombaSayaPageState extends State<LombaSayaPage> {
  List<Map<String, dynamic>> myCompetitions = [];
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadMyCompetitions();
  }

  Future<void> _loadMyCompetitions() async {
    final competitions = await dbHelper.getAllCompetitions();
    setState(() {
      myCompetitions = competitions;
    });
  }

  Future<void> _deleteCompetition(int id) async {
    await dbHelper.deleteCompetition(id);
    _loadMyCompetitions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lomba Saya'),
        backgroundColor: const Color.fromARGB(255, 255, 213, 0),
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
                    leading: Image.asset(item['image'],
                        width: 50, fit: BoxFit.cover),
                    title: Text(item['title']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deleteCompetition(item['id']);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

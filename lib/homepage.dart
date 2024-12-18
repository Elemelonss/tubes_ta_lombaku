import 'package:flutter/material.dart';
import 'services/shared_prefs.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Fungsi untuk logout
  void _logout() async {
    await SharedPrefs.logout(); // Hapus status login dari Shared Preferences
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => const LoginPage()), // Kembali ke LoginPage
    );
  }

  // Fungsi untuk menavigasi antara halaman bottom navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Data rekomendasi lomba
  final List<Map<String, String>> recommendations = [
    {'title': 'Lomba Vlog Bela Negara', 'image': 'assets/vlog.png'},
    {
      'title': 'Youth Business Plan Competition',
      'image': 'assets/business.png'
    },
    {'title': 'Lomba Vlog Bela Negara', 'image': 'assets/vlog.png'},
    {
      'title': 'Youth Business Plan Competition',
      'image': 'assets/business.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halo, Ucup!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout, // Fungsi untuk logout
            tooltip: "Logout",
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Cari Lomba',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'Rekomendasi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // GridView untuk menampilkan rekomendasi lomba
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 3 / 2,
              ),
              itemCount: recommendations.length,
              itemBuilder: (context, index) {
                final item = recommendations[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        item['image']!,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assistant),
            label: 'Lomba Saya',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Akun',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

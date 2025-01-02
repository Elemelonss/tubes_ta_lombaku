import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'lombasaya.dart'; // Tambahkan import halaman LombaSaya
import 'infolomba.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredRecommendations = [];

  final List<Map<String, String>> recommendations = [
    {'title': 'Lomba Vlog Bela Negara', 'image': 'assets/vlog.png'},
    {
      'title': 'Youth Business Plan Competition',
      'image': 'assets/business.png'
    },
    {'title': 'Hackathon Nasional', 'image': 'assets/vlog.png'},
    {'title': 'Lomba Poster Digital', 'image': 'assets/business.png'},
  ];

  @override
  void initState() {
    super.initState();
    _filteredRecommendations = recommendations;
    _searchController.addListener(() {
      _filterRecommendations(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterRecommendations(String query) {
    setState(() {
      _filteredRecommendations = recommendations.where((item) {
        return item['title']!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      // Navigasi ke halaman Lomba Saya
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LombaSayaPage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _getBody() {
    switch (_selectedIndex) {
      case 0:
        return _homePageContent();
      case 2:
        return const ProfilePage();
      default:
        return _homePageContent();
    }
  }

  Widget _homePageContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: _searchController,
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 3 / 2,
            ),
            itemCount: _filteredRecommendations.length,
            itemBuilder: (context, index) {
              final item = _filteredRecommendations[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InfoLombaPage(
                        title: item['title']!,
                        image: item['image']!,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(item['image']!,
                          height: 60, fit: BoxFit.cover),
                      const SizedBox(height: 8),
                      Text(
                        item['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assistant), label: 'Lomba Saya'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Akun'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

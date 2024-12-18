import 'package:flutter/material.dart';
import 'services/shared_prefs.dart';
import 'pages/login.dart';
import 'pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool loggedIn = await SharedPrefs.isLoggedIn();

  runApp(MyApp(initialRoute: loggedIn ? const HomePage() : const LoginPage()));
}

class MyApp extends StatelessWidget {
  final Widget initialRoute;

  const MyApp({required this.initialRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: initialRoute,
    );
  }
}

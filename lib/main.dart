import 'package:flutter/material.dart';
import 'services/shared_prefs.dart';
import 'services/login.dart';
import 'services/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool loggedIn = await SharedPrefs.isLoggedIn();

  runApp(MyApp(initialRoute: loggedIn ? const HomePage() : const LoginPage()));
}

class MyApp extends StatelessWidget {
  final Widget initialRoute;

  const MyApp({required this.initialRoute, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: initialRoute,
    );
  }
}

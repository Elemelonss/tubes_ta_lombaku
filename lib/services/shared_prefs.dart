import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String _loginStatusKey = 'isLoggedIn';
  static const String _emailKey = 'email';

  /// Menyimpan status login dan email pengguna
  static Future<void> saveLoginStatus(String email) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_loginStatusKey, true);
      await prefs.setString(_emailKey, email);
    } catch (e) {
      print('Error saving login status: $e');
    }
  }

  /// Mengecek apakah pengguna sudah login
  static Future<bool> isLoggedIn() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_loginStatusKey) ?? false;
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  /// Mendapatkan email pengguna yang disimpan
  static Future<String?> getEmail() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_emailKey);
    } catch (e) {
      print('Error getting email: $e');
      return null;
    }
  }

  /// Logout pengguna dan hapus semua data dari SharedPreferences
  static Future<void> logout() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}

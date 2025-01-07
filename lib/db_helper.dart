import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton pattern
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  // Getter untuk database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inisialisasi database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Membuat tabel users
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL
          )
        ''');
        // Membuat tabel competitions
        await db.execute('''
          CREATE TABLE competitions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            image TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // Fungsi untuk registrasi pengguna baru
  Future<int> registerUser(String email, String password) async {
    final db = await database;
    return await db.insert(
      'users',
      {'email': email, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fungsi untuk mendapatkan pengguna berdasarkan email dan password
  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  // Fungsi untuk memeriksa apakah email sudah terdaftar
  Future<bool> isEmailRegistered(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  // Fungsi untuk menyimpan data lomba yang diikuti
  Future<int> saveCompetition(String title, String image) async {
    final db = await database;
    return await db.insert(
      'competitions',
      {'title': title, 'image': image},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  // Fungsi untuk mendapatkan semua lomba yang diikuti
  Future<List<Map<String, dynamic>>> getCompetitions() async {
    final db = await database;
    return await db.query('competitions');
  }

  // Fungsi untuk menghapus lomba dari daftar yang diikuti
  Future<int> deleteCompetition(int id) async {
    final db = await database;
    return await db.delete(
      'competitions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Fungsi untuk menghapus semua data (Opsional untuk pengujian)
  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('users');
    await db.delete('competitions');
  }
}

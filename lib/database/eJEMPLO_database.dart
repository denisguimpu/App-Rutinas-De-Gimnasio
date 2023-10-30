import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'rutinas.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE rutinas (
        id INTEGER PRIMARY KEY,
        nombre TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE ejercicios (
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        muscle TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE rutina_ejercicio (
        rutina_id INTEGER,
        ejercicio_id INTEGER
      )
    ''');
  }

// Implementa métodos para insertar, consultar y actualizar rutinas y ejercicios.
}

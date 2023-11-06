import 'package:flutter_app/database/rutina_db.dart';
import 'package:flutter_app/database/userData.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'ejercicios_db.dart';

class DB {
  static Future<Database> openDB() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'ejercicios.db'),
      onCreate: (db, version) {
        print(getDatabasesPath());
        // Crear la tabla de ejercicios
        db.execute(
          'CREATE TABLE ejercicios (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT ,muscle TEXT,description TEXT, titulo TEXT);',
        );

        // Crear la tabla de user_data
        db.execute(
          'CREATE TABLE user_data (id INTEGER PRIMARY KEY AUTOINCREMENT, weight REAL, height REAL, waist REAL, neck REAL, hip REAL);',
        );

        // Crear la tabla de rutinas
        db.execute(
          'CREATE TABLE rutinas (id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, FOREIGN KEY (nombre) REFERENCES ejercicios(titulo));',
        );


      },
      version: 1,
    );

    return database;
  }

  static Future<void> saveUserData(UserData userData) async {
    Database database = await openDB();
    final count = Sqflite.firstIntValue(
        await database.rawQuery('SELECT COUNT(*) FROM user_data'));
    if (count == 0) {
      // No hay datos existentes, inserta una nueva fila
      await database.insert('user_data', userData.toMap());
    } else {
      // Ya existe una fila, actualiza los datos
      await database.update('user_data', userData.toMap());
    }
  }

  static Future<UserData?> getUserData() async {
    Database database = await openDB();
    final list = await database.query('user_data');
    if (list.isNotEmpty) {
      return UserData.fromMap(list.first);
    }
    return null;
  }

  static Future<int> insert(Ejercicio ejercicio) async {
    Database database = await openDB();

    return database.insert("ejercicios", ejercicio.toMap());
  }

  static Future<int> insertTitulo(Rutina rutina) async {
    Database database = await openDB();

    return database.insert("rutinas", rutina.toMap());
  }

  static Future<int> delete(Ejercicio ejercicio) async {
    Database database = await openDB();

    return database
        .delete("ejercicios", where: "name = ?", whereArgs: [ejercicio.name]);
  }

  static Future<int> insertQuery(String query) async {
    Database database = await openDB();
    return database.rawInsert(query);
  }

  static Future<int> update(Ejercicio ejercicio) async {
    Database database = await openDB();

    return database.update("ejercicios", ejercicio.toMap(),
        where: "name = ?", whereArgs: [ejercicio.name]);
  }

  static Future<List<Ejercicio>> getAll() async {
    Database database = await openDB();
    final List<Map<String, dynamic>> ejerciciosMap =
        await database.query("ejercicios");
    return List.generate(
        ejerciciosMap.length,
        (i) => Ejercicio(
              name: ejerciciosMap[i]['name'],
              muscle: ejerciciosMap[i]['muscle'],
              description: ejerciciosMap[i]['description'],
              titulo: ejerciciosMap[i]['titulo'],
            ));
  }

  static Future<List<Rutina>> getAllTitles() async {
    Database database = await openDB();
    final List<Map<String, dynamic>> rutinasMap =
        await database.query("rutinas");
    return List.generate(rutinasMap.length,
        (i) => Rutina(nombre: rutinasMap[i]['nombre'], ejercicios: []));
  }
}

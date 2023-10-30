import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'ejercicios_db.dart';

class DB {

  /*
  static Future<Database> _openDB() async {

    return openDatabase(join(await getDatabasesPath(), 'ejercicios.db'),
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE ejercicios (id INTEGER PRIMARY KEY, name TEXT ,muscle TEXT,description TEXT);',
          );
        }, version: 1);
  }
  */

   static Future<Database> _openDB() async {
      final database = await openDatabase(
        join(await getDatabasesPath(), 'ejercicios.db'),
        onCreate: (db, version) {
          // Crear la tabla de ejercicios
          db.execute(
            'CREATE TABLE ejercicios (id INTEGER PRIMARY KEY, name TEXT, muscle TEXT, description TEXT);',
          );

          // Crear la tabla de rutinas
          db.execute(
            'CREATE TABLE rutinas (id INTEGER PRIMARY KEY, nombre TEXT, descripcion TEXT);',
          );

          // Crear la tabla de relación entre rutinas y ejercicios
          db.execute(
            'CREATE TABLE rutina_ejercicio (id INTEGER PRIMARY KEY, rutina_id INTEGER, ejercicio_id INTEGER, FOREIGN KEY (rutina_id) REFERENCES rutinas (id), FOREIGN KEY (ejercicio_id) REFERENCES ejercicios (id));',
          );
        },
        version: 1,
      );

      return database;
    }

  static Future<int> insert(Ejercicio ejercicio) async {
    Database database = await _openDB();

    return database.insert("ejercicios", ejercicio.toMap());
  }

  static Future<int> delete(Ejercicio ejercicio) async {
    Database database = await _openDB();

    return database.delete("ejercicios", where: "name = ?", whereArgs: [ejercicio.name]);
  }

  static Future<int> update(Ejercicio ejercicio) async {
    Database database = await _openDB();

    return database.update("ejercicios", ejercicio.toMap(), where: "name = ?", whereArgs: [ejercicio.name]);
  }

  static Future<List> getAll() async {
    Database database = await _openDB();
    final List<Map<String,dynamic>> ejerciciosMap = await database.query("ejercicios");
    return List.generate(ejerciciosMap.length, (i) => Ejercicio(
        name: ejerciciosMap[i]['name'],
        muscle: ejerciciosMap[i]['muscle'],
        description: ejerciciosMap[i]['description'],
        id: ejerciciosMap[i]['id'],
    ));
  }


}

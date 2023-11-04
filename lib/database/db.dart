import 'package:flutter_app/database/rutina_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'ejercicios_db.dart';

class DB {

  /*
  static Future<Database> _openDB() async {

    return openDatabase(join(await getDatabasesPath(), 'ejercicios.db'),
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE ejercicios (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT ,muscle TEXT,description TEXT, titulo TEXT);',
          );
        }, version: 1);
  }
  */

   static Future<Database> openDB() async {
      final database = await openDatabase(
        join(await getDatabasesPath(), 'ejercicios.db'),
        onCreate: (db, version) {
          
          // Crear la tabla de ejercicios
          db.execute(
            'CREATE TABLE ejercicios (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT ,muscle TEXT,description TEXT, titulo TEXT);',
          );

          // Crear la tabla de rutinas
          db.execute(
            'CREATE TABLE rutinas (id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, FOREIGN KEY (nombre) REFERENCES ejercicios(titulo));',
          );
          db.execute( '''
                      INSERT INTO ejercicios (name, muscle, description, titulo)
                      VALUES
                        ('Sentadilla', 'Cuadriceps', 'Descripción de la sentadilla', 'Rutina A'),
                        ('Press banca', 'Pecho', 'Descripción del press banca', 'Rutina A'),
                        ('Peso muerto', 'Isquiotibiales', 'Descripción del peso muerto', 'Rutina B');
                    ''');
          db.execute('''
                      INSERT INTO rutinas (nombre)
                      VALUES
                        ('Rutina A'),
                        ('Rutina B');
                    ''');
          
        },
        version: 1,
      );

      return database;
    }


  static Future<int> insert(Ejercicio ejercicio) async {
    Database database = await openDB();

    return database.insert("ejercicios", ejercicio.toMap());
  }

   static Future<int> insertTitulo(Rutina rutina) async {
     Database database = await openDB();
     /*
     var resultado = await database.rawInsert("INSERT INTO rutinas (nombre)"
         "VALUES (${titulo})");

      */

     return database.insert("rutinas", rutina.toMap());
   }

  static Future<int> delete(Ejercicio ejercicio) async {
    Database database = await openDB();

    return database.delete("ejercicios", where: "name = ?", whereArgs: [ejercicio.name]);
  }

  static Future<int> insertQuery(String query)  async {
    Database database = await openDB();
    return database.rawInsert(query);
  }

  static Future<int> update(Ejercicio ejercicio) async {
    Database database = await openDB();

    return database.update("ejercicios", ejercicio.toMap(), where: "name = ?", whereArgs: [ejercicio.name]);
  }

  static Future<List<Ejercicio>> getAll() async {
    Database database = await openDB();
    final List<Map<String,dynamic>> ejerciciosMap = await database.query("ejercicios");
    return List.generate(ejerciciosMap.length, (i) => Ejercicio(
        name: ejerciciosMap[i]['name'],
        muscle: ejerciciosMap[i]['muscle'],
        description: ejerciciosMap[i]['description'],
        titulo: ejerciciosMap[i]['titulo'],
    ));
  }

   static Future<List<Rutina>> getAllTitles() async {
     Database database = await openDB();
     final List<Map<String,dynamic>> rutinasMap = await database.query("rutinas");
     return List.generate(rutinasMap.length, (i) => Rutina(
       nombre: rutinasMap[i]['nombre'], ejercicios: []
     ));
   }


}

import 'dart:async';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/database/ejercicios_db.dart';
import 'package:sqflite/sqflite.dart';
import '../database/db.dart';
import '../database/rutina_db.dart';
import 'exercisescreen.dart';
import 'package:path/path.dart';
import 'package:flutter_app/model/exercise.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  /* ESTA MAL
  Future<List<Rutina>> obtenerRutinasConEjercicios() async {

    List<Rutina> rutinas = [];
    List<Ejercicio> ejercicios = await DB.getAll();
    List<Ejercicio> ejerciciosLista = [];
    List<Rutina> numRutinas = await DB.getAllTitles();
    Rutina rutina = new Rutina(nombre: "", ejercicios: []);

    numRutinas.forEach((rutinaFor) {
      ejercicios.forEach((ejercicioFor) {
        if(rutinaFor.nombre == ejercicioFor.titulo){
          ejerciciosLista.add(ejercicioFor);
          rutina = new Rutina(nombre: rutinaFor.nombre, ejercicios: ejerciciosLista);
        }
      });
      rutinas.add(rutina);
    });



    return rutinas;
  }

   */

  Future<List<Rutina>> obtenerRutinasConEjercicios() async {
    List<Rutina> rutinas = [];
    List<Ejercicio> ejercicios = await DB.getAll();
    List<Rutina> numRutinas = await DB.getAllTitles();

    Map<String, List<Ejercicio>> ejerciciosPorRutina = {};

    ejercicios.forEach((ejercicioFor) {
      final rutinaNombre = ejercicioFor.titulo;
      if (!ejerciciosPorRutina.containsKey(rutinaNombre)) {
        ejerciciosPorRutina[rutinaNombre] = [];
      }
      ejerciciosPorRutina[rutinaNombre]!.add(ejercicioFor); // Añadir "!" para indicar que no puede ser nulo
    });

    numRutinas.forEach((rutinaFor) {
      final rutinaNombre = rutinaFor.nombre;
      if (ejerciciosPorRutina.containsKey(rutinaNombre)) {
        final ejerciciosLista = ejerciciosPorRutina[rutinaNombre]!; // Añadir "!" para indicar que no puede ser nulo
        final rutina = Rutina(nombre: rutinaNombre, ejercicios: ejerciciosLista);
        rutinas.add(rutina);
      }
    });

    return rutinas;
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Inicio'),
          centerTitle: true,
          backgroundColor: Colors.cyan,
        ),
        body: FutureBuilder<List<Rutina>>(
          future: obtenerRutinasConEjercicios(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No hay rutinas almacenadas.');
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final rutinaLV = snapshot.data?[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${rutinaLV?.nombre}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: rutinaLV?.ejercicios.length,
                        itemBuilder: (context, ejercicioIndex) {
                          final ejercicioLV = rutinaLV?.ejercicios[ejercicioIndex];
                          return ListTile(
                            title: Text(ejercicioLV!.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Músculo: ${ejercicioLV?.muscle}'),
                                Text('Descripción: ${ejercicioLV?.description}'),
                              ],
                            ),
                          );
                        },
                      ),
                      Divider(), // Separador entre rutinas
                    ],
                  );
                },
              );
            }
          },
        ),
    );
  }

  Widget ExercisesItem(
      String name, String muscle, String description, int index) {
    return ListTile();
  }
}

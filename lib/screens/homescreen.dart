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


  Future<List<Rutina>> obtenerRutinasConEjercicios() async {

    List<Rutina> rutinas = [];
    List<Ejercicio> ejercicios = await DB.getAll();
    List<Ejercicio> ejerciciosLista = [];
    List<Rutina> numRutinas = await DB.getAllTitles();


    numRutinas.forEach((rutinaFor) {
      ejercicios.forEach((ejercicioFor) {
        if(rutinaFor.nombre == ejercicioFor.titulo){
          ejerciciosLista.add(ejercicioFor);
          Rutina rutina = new Rutina(nombre: rutinaFor.nombre, ejercicios: ejerciciosLista);
          rutinas.add(rutina);
        }
      });
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
                  final rutina = snapshot.data?[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${rutina?.nombre}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: rutina?.ejercicios.length,
                        itemBuilder: (context, ejercicioIndex) {
                          final ejercicio = rutina?.ejercicios[ejercicioIndex];
                          return ListTile(
                            title: Text(ejercicio!.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Músculo: ${ejercicio?.muscle}'),
                                Text('Descripción: ${ejercicio?.description}'),
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

  List<Exercise> exercises = [
    Exercise('Sentadilla', 'Cuadriceps', "description", false),
    Exercise('Press banca', 'Pecho', "description", false),
    Exercise('Peso muerto', 'Isquiotiviales', "description", false),
  ];
}

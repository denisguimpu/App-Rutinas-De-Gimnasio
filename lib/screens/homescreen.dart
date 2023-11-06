import 'package:flutter/material.dart';
import 'package:flutter_app/database/rutina_db.dart';
import 'package:flutter_app/database/db.dart';
import 'package:flutter_app/screens/rutinadetallescreen.dart';

import '../database/ejercicios_db.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay rutinas almacenadas.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final rutinaLV = snapshot.data?[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      if (rutinaLV != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              RutinaDetalleScreen(rutina: rutinaLV),
                        ));
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${rutinaLV?.nombre}',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Ejercicios:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Column(
                            children: rutinaLV!.ejercicios.map((ejercicio) {
                              return ListTile(
                                title: Text(ejercicio.name),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Músculo: ${ejercicio.muscle}'),
                                    Text('Descripción: ${ejercicio.description}'),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

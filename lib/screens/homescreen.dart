import 'package:flutter/material.dart';
import 'package:flutter_app/database/rutina_db.dart';
import 'package:flutter_app/database/db.dart';
import 'package:flutter_app/screens/rutinadetallescreen.dart';
import 'package:flutter_app/database/ejercicios_db.dart';
import 'package:line_icons/line_icons.dart';

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
      ejerciciosPorRutina[rutinaNombre]!.add(ejercicioFor);
    });

    numRutinas.forEach((rutinaFor) {
      final rutinaNombre = rutinaFor.nombre;
      if (ejerciciosPorRutina.containsKey(rutinaNombre)) {
        final ejerciciosLista = ejerciciosPorRutina[rutinaNombre]!;
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
        backgroundColor: Colors.black, // Cambia el color del appBar a negro
      ),
      backgroundColor: Colors.grey[900],
      body: FutureBuilder<List<Rutina>>(
        future: obtenerRutinasConEjercicios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No hay rutinas almacenadas.',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final rutinaLV = snapshot.data?[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.all(8),
                  color: Colors.grey[850],
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RutinaDetalleScreen(rutina: rutinaLV),
                      ));
                    },
                    child: Column( // Utilizamos un Column para alinear el título y el icono de papelera
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${rutinaLV?.nombre}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Ejercicios:',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      rutinaLV!.ejercicios
                                          .map((ejercicio) => ejercicio.name)
                                          .join('\n'),
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(LineIcons.trash, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Eliminar Rutina'),
                                      content: Text('¿Estás seguro de que quieres eliminar esta rutina y sus ejercicios?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // Cierra el cuadro de diálogo
                                          },
                                          child: Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            // Lógica para eliminar todos los ejercicios de la rutina
                                            int result = await DB.deleteRutine(rutinaLV!);
                                            if (result > 0) {
                                              // La rutina se eliminó correctamente
                                              // Ahora eliminamos todos los ejercicios relacionados
                                              int deletedExercises = await DB.deleteEjerciciosByTitulo(rutinaLV!.nombre);
                                            }
                                            Navigator.of(context).pop(); // Cierra el cuadro de diálogo
                                            // Vuelve a cargar la pantalla para reflejar la eliminación
                                            setState(() {});
                                          },
                                          child: Text('Eliminar'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
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

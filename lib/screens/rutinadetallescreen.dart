import 'package:flutter/material.dart';
import 'package:flutter_app/database/rutina_db.dart';

class RutinaDetalleScreen extends StatelessWidget {
  final Rutina rutina; // Objeto Rutina que se mostrará en pantalla.

  RutinaDetalleScreen({required this.rutina}); // Constructor que recibe una Rutina obligatoria.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(rutina.nombre), // Título de la AppBar con el nombre de la rutina.
        backgroundColor: Colors.black, // Cambia el color de fondo de la AppBar a negro.
      ),
      body: Container(
        color: Colors.grey[900], // Cambia el color de fondo a negro.
        child: ListView.builder(
          itemCount: rutina.ejercicios.length, // Cantidad de elementos a mostrar en la lista.
          itemBuilder: (context, ejercicioIndex) {
            final ejercicioLV = rutina.ejercicios[ejercicioIndex]; // Obtiene un ejercicio de la lista.

            return Card(
              elevation: 5, // Agrega sombra al card.
              margin: EdgeInsets.all(8), // Define márgenes alrededor del card.
              color: Colors.grey[850], // Cambia el color de fondo del Card a gris oscuro.

              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ejercicioLV.name, // Nombre del ejercicio.
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Cambia el color del texto a blanco.
                      ),
                    ),
                    SizedBox(height: 8), // Agrega un espacio vertical.
                    Text(
                      '${ejercicioLV.muscle}', // Grupo muscular del ejercicio.
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.teal[300], // Cambia el color del texto a blanco.
                      ),
                    ),
                    Text(
                      '${ejercicioLV.description}', // Descripción del ejercicio.
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Cambia el color del texto a blanco.
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

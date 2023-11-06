import 'package:flutter/material.dart';
import 'package:flutter_app/database/rutina_db.dart';

class RutinaDetalleScreen extends StatelessWidget {
  final Rutina rutina;

  RutinaDetalleScreen({required this.rutina});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(rutina.nombre),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.grey[900], // Cambia el color de fondo a negro
        child: ListView.builder(
          itemCount: rutina.ejercicios.length,
          itemBuilder: (context, ejercicioIndex) {
            final ejercicioLV = rutina.ejercicios[ejercicioIndex];
            return Card(
              elevation: 5, // Sombra del card
              margin: EdgeInsets.all(8), // Márgenes alrededor del card
              color: Colors.grey[850], // Cambia el color de fondo del Card a gris oscuro
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ejercicioLV.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Cambia el color del texto a blanco
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${ejercicioLV.muscle}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.teal[300], // Cambia el color del texto a blanco
                      ),
                    ),
                    Text(
                      '${ejercicioLV.description}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Cambia el color del texto a blanco
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

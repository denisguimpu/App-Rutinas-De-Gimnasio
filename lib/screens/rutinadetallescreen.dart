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
      ),
      body: ListView.builder(
        itemCount: rutina.ejercicios.length,
        itemBuilder: (context, ejercicioIndex) {
          final ejercicioLV = rutina.ejercicios[ejercicioIndex];
          return Card(
            elevation: 3, // Sombra del card
            margin: EdgeInsets.all(8), // Márgenes alrededor del card
            child: ListTile(
              title: Text(ejercicioLV.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Músculo: ${ejercicioLV.muscle}'),
                  Text('Descripción: ${ejercicioLV.description}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'ejercicios_db.dart';

class Rutina {
  int id;
  String nombre;
  List<Ejercicio> ejercicios;

  Rutina({
    required this.id,
    required this.nombre,
    required this.ejercicios,
  });
}
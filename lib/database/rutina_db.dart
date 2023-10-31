import 'ejercicios_db.dart';

class Rutina {
  String nombre;
  List<Ejercicio> ejercicios;

  Rutina({
    required this.nombre,
    required this.ejercicios,
  });

  Map<String,dynamic> toMap() {
    return {"nombre": nombre};
  }
}


class Ejercicio {


  String name;
  String muscle;
  String description;
  String titulo;
  int repeticiones;
  int series;
  int pesoMax;

  Ejercicio({required this.name, required this.muscle, required this.description,required this.titulo, required this.repeticiones, required this.series, required this.pesoMax});


  Map<String,dynamic> toMap() {
    return {"name": name, "muscle": muscle, "description": description, "titulo": titulo, "repeticiones": repeticiones, "series": series, "pesoMax": pesoMax};
  }
}


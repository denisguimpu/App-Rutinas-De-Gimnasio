

class Ejercicio {


  String name;
  String muscle;
  String description;
  String titulo;

  Ejercicio({required this.name, required this.muscle, required this.description,required this.titulo});


  Map<String,dynamic> toMap() {
    return {"name": name, "muscle": muscle, "description": description, "titulo": titulo};
  }
}


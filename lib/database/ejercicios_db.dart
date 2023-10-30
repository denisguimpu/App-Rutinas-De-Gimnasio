

class Ejercicio {

  int id;
  String name;
  String muscle;
  String description;

  Ejercicio({required this.name, required this.muscle, required this.description, required this.id});


  Map<String,dynamic> toMap() {
    return {"name": name, "muscle": muscle, "description": description, "id": id};
  }
}


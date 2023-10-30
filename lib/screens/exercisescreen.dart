import 'package:flutter/material.dart';
import 'package:flutter_app/model/excercise_view.dart';
import 'package:flutter_app/model/exercise.dart';
import './homescreen.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  List<Exercise> exercises = [
    Exercise('Sentadilla', 'Cuadriceps', "description", false),
    Exercise('Press banca', 'Pecho', "description", false),
    Exercise('Peso muerto', 'Isquiotiviales', "description", false),
  ];


  List<Exercise> selectedExercises = [];
  String textButton = "Cancelar";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ejercicios'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      return ExcercisesItem(
                        exercises[index].name,
                        exercises[index].muscle,
                        exercises[index].description,
                        exercises[index].isSelected,
                        index,
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: (){
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan[500],
                      ),
                      child: Text(
                        textButton,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ExcercisesItem(String name, String muscle, String description,
      bool isSelected, int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.cyan[700],
        child: Icon(
          Icons.person_outline_outlined,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(muscle),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Colors.lightBlue,
            )
          : Icon(
              Icons.check_circle_outline,
              color: Colors.lightBlue[200],
            ),

      onTap: () {
        setState(() {
          exercises[index].isSelected = !exercises[index].isSelected;
          if (exercises[index].isSelected == true) {
            selectedExercises.add(Exercise(name, muscle, description, true));
          } else if (exercises[index].isSelected == false) {
            selectedExercises.removeWhere(
                (element) => element.name == exercises[index].name);
          }
          if (selectedExercises.length == 0) {
            textButton = "Cancelar";
          } else if (selectedExercises.length > 0) {
            textButton = "Añadir (${selectedExercises.length})";
          }
        });
      },
    );
  }
}

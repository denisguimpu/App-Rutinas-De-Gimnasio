import 'package:flutter/material.dart';
import 'exercisescreen.dart';
import 'package:flutter_app/model/exercise.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Inicio'),
          centerTitle: true,
          backgroundColor: Colors.cyan,
        ),
        body: Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(20)),
          Text(
            'Fitness App',
            style: Theme.of(context).textTheme.headline2,
          ),
          Padding(padding: EdgeInsets.all(20)),
          MaterialButton(
            highlightColor: Theme.of(context).hintColor,
            elevation: 10.0,
            minWidth: 170.0,
            height: 50.0,
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'Nueva rutina',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainScreen()));
            },
          ),
          /*
          Padding(padding: EdgeInsets.all(20)),
          Expanded(child: ListView.builder(itemBuilder: (context, index) {
            return ExercisesItem(
              exercises[index].name,
              exercises[index].muscle,
              exercises[index].description,
              index,
            );
          })
          ),
          */
        ],
      ),
    ));
  }

  Widget ExercisesItem(
      String name, String muscle, String description, int index) {
    return ListTile();
  }

  List<Exercise> exercises = [
    Exercise('Sentadilla', 'Cuadriceps', "description", false),
    Exercise('Press banca', 'Pecho', "description", false),
    Exercise('Peso muerto', 'Isquiotiviales', "description", false),
  ];
}

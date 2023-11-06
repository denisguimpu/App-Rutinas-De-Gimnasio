import 'package:flutter/material.dart';
import 'package:flutter_app/database/ejercicios_db.dart';
import 'package:flutter_app/database/rutina_db.dart';
import 'package:flutter_app/model/exercise.dart';
import 'package:provider/provider.dart';
import '../database/db.dart';
import '../views/changenotifier.dart';


class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  List<Exercise> exercises = [
    Exercise(
        'Sentadilla',
        'Cuádriceps',
        'La sentadilla es un ejercicio compuesto que trabaja los músculos de las piernas y glúteos. Para realizarla, colócate de pie con los pies a la altura de los hombros, baja tus caderas hacia abajo y hacia atrás como si te estuvieras sentando en una silla invisible y luego regresa a la posición inicial.',
        false),
    Exercise(
        'Press de Banca',
        'Pecho',
        'El press de banca es un ejercicio para el desarrollo de la fuerza y la masa muscular en el pecho. Acuéstate en un banco con los pies en el suelo, sostén la barra con las manos separadas a la anchura de los hombros y baja la barra hacia tu pecho y luego empújala hacia arriba.',
        false),
    Exercise(
        'Peso Muerto',
        'Isquiotibiales',
        'El peso muerto es un ejercicio que involucra varios grupos musculares, incluyendo la espalda baja, los isquiotibiales, los glúteos y la espalda alta. Para hacerlo, colócate frente a la barra, agáchate para sujetarla, y luego levántala hasta que estés de pie.',
        false),
    Exercise(
        'Press Militar',
        'Hombros',
        'El press militar es un ejercicio para el desarrollo de los hombros. De pie, sostén una barra o mancuernas a la altura de los hombros y presiona hacia arriba sobre tu cabeza, luego baja a la posición inicial.',
        false),
    Exercise(
        'Pull-Ups',
        'Espalda',
        'Las dominadas son un ejercicio que trabaja los músculos de la espalda y los brazos. Cuelga de una barra y levanta tu cuerpo hacia arriba, manteniendo los codos doblados.',
        false),
    Exercise(
        'Fondos en Paralelas',
        'Tríceps',
        'Los fondos en paralelas son un ejercicio que se enfoca en los tríceps. Colócate entre dos barras paralelas, baja tu cuerpo y luego empújate hacia arriba.',
        false),
    Exercise(
        'Zancadas',
        'Cuádriceps',
        'Las zancadas son un ejercicio para las piernas que trabaja los cuádriceps y los glúteos. Da un paso adelante con una pierna y baja la cadera hasta que ambas rodillas estén dobladas a 90 grados, luego regresa a la posición inicial.',
        false),
    Exercise(
        'Curl de Bíceps',
        'Bíceps',
        'El curl de bíceps es un ejercicio para desarrollar los músculos de los brazos. Sujeta una barra o mancuernas con los brazos extendidos y dobla los codos para llevar el peso hacia los hombros, luego baja a la posición inicial.',
        false),
    Exercise(
        'Prensa de Piernas',
        'Cuádriceps',
        'La prensa de piernas es un ejercicio que trabaja los cuádriceps y los glúteos. Siéntate en la máquina de prensa de piernas y empuja el peso hacia arriba con las piernas.',
        false),
    Exercise(
        'Plancha',
        'Core',
        'La plancha es un ejercicio de resistencia para el core. Apóyate en los antebrazos y los dedos de los pies, manteniendo el cuerpo en línea recta durante un tiempo determinado.',
        false),
    Exercise(
        'Deadlift Rumano',
        'Isquiotibiales',
        'El deadlift rumano es una variante del peso muerto que se centra en los isquiotibiales y la espalda baja. Mantén las piernas rectas y baja el torso mientras mantienes la espalda recta y luego regresa a la posición inicial.',
        false),
    Exercise(
        'Press de Hombros con Mancuernas',
        'Hombros',
        'Este ejercicio trabaja los hombros de forma aislada. De pie, sostén una mancuerna en cada mano a la altura de los hombros y presiona hacia arriba, luego baja a la posición inicial.',
        false),
    Exercise(
        'Flexiones de Tríceps',
        'Tríceps',
        'Las flexiones de tríceps son un ejercicio que se enfoca en los tríceps. Realiza flexiones con las manos colocadas cerca una de la otra para trabajar más los tríceps.',
        false),
    Exercise(
        'Peso Muerto Sumo',
        'Piernas y Glúteos',
        'El peso muerto sumo es una variante del peso muerto que se realiza con un agarre ancho y trabaja especialmente los músculos de las piernas y glúteos.',
        false),
    Exercise(
        'Elevaciones Laterales',
        'Hombros',
        'Las elevaciones laterales son un ejercicio de aislamiento para los hombros. De pie, sostén una mancuerna en cada mano a los lados y levanta los brazos hacia los lados hasta que estén paralelos al suelo.',
        false),
    Exercise(
        'Prensa Inclinada',
        'Pecho',
        'La prensa inclinada es un ejercicio que se enfoca en el desarrollo del pecho superior. Realiza el ejercicio en un banco inclinado, bajando y subiendo la barra de pesas o mancuernas.',
        false),
    Exercise(
        'Pájaros',
        'Deltoides Posterior',
        'Los pájaros son un ejercicio para trabajar los deltoides posteriores. Inclínate hacia adelante en un banco o de pie y levanta pesas hacia los lados, manteniendo los brazos ligeramente doblados.',
        false),
    Exercise(
        'Prensa de Tríceps',
        'Tríceps',
        'La prensa de tríceps se realiza en una máquina específica y se enfoca en el desarrollo de los tríceps. Empuja la barra hacia arriba, extendiendo los brazos completamente.',
        false),
    Exercise(
        'Hiperextensiones',
        'Espalda Baja',
        'Las hiperextensiones son un ejercicio para fortalecer la espalda baja. Realiza el ejercicio en una máquina de hiperextensiones o con un banco romano, inclinándote hacia adelante y luego enderezando la espalda.',
        false),
    Exercise(
        'Curl de Martillo',
        'Bíceps',
        'El curl de martillo es una variante del curl de bíceps que se enfoca en los músculos del antebrazo. Sujeta una mancuerna en cada mano con las palmas mirándose entre sí y dobla los codos.',
        false),
    Exercise(
        'Zancada Lateral',
        'Piernas y Glúteos',
        'Las zancadas laterales son una variante de las zancadas que trabajan los músculos de las piernas y los glúteos de manera lateral. Da un paso lateral y baja la cadera.',
        false),
    Exercise(
        'Press de Banca Declinado',
        'Pecho',
        'El press de banca declinado se enfoca en el desarrollo del pecho inferior. Realiza el ejercicio en un banco declinado y baja y sube la barra de pesas o mancuernas.',
        false),
    Exercise(
        'Curl de Concentración',
        'Bíceps',
        'El curl de concentración es un ejercicio de aislamiento para los bíceps. Siéntate en un banco con una pierna apoyada en el interior del codo y realiza curls con una mancuerna.',
        false),
    Exercise(
        'Extensión de Cadera',
        'Glúteos',
        'La extensión de cadera se realiza en una máquina específica y trabaja los músculos de los glúteos. Realiza el movimiento de extensión de cadera hacia atrás.',
        false),
    Exercise(
        'Elevaciones Frontales',
        'Hombros',
        'Las elevaciones frontales son un ejercicio para los deltoides frontales. De pie, sostén una barra o mancuernas y levanta los brazos hacia adelante hasta la altura de los hombros.',
        false),
    Exercise(
        'Polea Alta',
        'Espalda',
        'La polea alta es un ejercicio que trabaja la espalda alta y los hombros. Utiliza una polea alta con una barra o cuerda y tira hacia abajo hacia el pecho.',
        false),
    Exercise(
        'Press Francés',
        'Tríceps',
        'El press francés es un ejercicio para desarrollar los tríceps. Realiza el ejercicio acostado en un banco, bajando la barra hacia la frente y luego extendiendo los brazos.',
        false),
    Exercise(
        'Elevaciones de Pantorrilla',
        'Pantorrillas',
        'Las elevaciones de pantorrilla trabajan los músculos de las pantorrillas. Puedes hacerlas en una máquina específica o de pie con pesas.',
        false),
    Exercise(
        'Burpees',
        'Cuerpo Completo',
        'Los burpees son un ejercicio cardiovascular de cuerpo completo. Combina saltos, flexiones y sentadillas en un movimiento fluido.',
        false),
    Exercise(
        'Abdominales Russian Twist',
        'Abdominales Oblicuos',
        'Los abdominales Russian Twist son un ejercicio para los oblicuos. Siéntate en el suelo, inclina el torso hacia atrás y gira el torso de un lado a otro sosteniendo un peso o una pelota medicinal.',
        false),
    Exercise(
        'Peso Muerto a una Pierna',
        'Piernas',
        'El peso muerto a una pierna es un ejercicio que trabaja la fuerza y el equilibrio. Sujeta una mancuerna en una mano y realiza un peso muerto mientras mantienes una pierna en el aire.',
        false),
    Exercise(
        'Press de Hombros Arnold',
        'Hombros',
        'El press de hombros Arnold es una variante del press de hombros estándar que involucra un giro en el movimiento de las pesas. Sostén las mancuernas con las palmas hacia ti y gira las manos durante el movimiento.',
        false),
    Exercise(
        'Sentadilla con Salto',
        'Piernas',
        'La sentadilla con salto es un ejercicio explosivo que combina una sentadilla con un salto. Realiza una sentadilla y luego impúlsate hacia arriba en un salto.',
        false),
    Exercise(
        'Curl de Bíceps con Barra Z',
        'Bíceps',
        'El curl de bíceps con barra Z es una variante del curl de bíceps estándar que utiliza una barra en forma de Z. Sujeta la barra con las manos en posición neutral y realiza curls.',
        false),
    Exercise(
        'Flexiones de Pecho Diamante',
        'Pecho',
        'Las flexiones de pecho diamante se realizan con las manos juntas en forma de diamante en el suelo. Baja y sube el cuerpo como en una flexión estándar.',
        false),
    Exercise(
        'Hip Thrust',
        'Glúteos',
        'El hip thrust es un ejercicio que se enfoca en el desarrollo de los glúteos. Realiza el ejercicio en un banco, con las pesas en las caderas, elevando la pelvis hacia arriba.',
        false),
    Exercise(
        'Press de Tríceps con Mancuernas',
        'Tríceps',
        'El press de tríceps con mancuernas se realiza acostado en un banco. Sujeta las mancuernas con los brazos extendidos y luego baja y sube las pesas.',
        false),
    Exercise(
        'Burpees con Lagartijas',
        'Cuerpo Completo',
        'Este es un ejercicio desafiante que combina burpees con flexiones. Realiza un burpee y luego añade una flexión en la posición de lagartija.',
        false),
    Exercise(
        'Peso Muerto Sumo con Mancuernas',
        'Piernas y Glúteos',
        'El peso muerto sumo con mancuernas es una variante que se realiza con las piernas más anchas y mancuernas a los lados. Realiza el movimiento de peso muerto sumo.',
        false),
    Exercise(
        'Dominadas a una Mano',
        'Espalda',
        'Las dominadas a una mano son un ejercicio avanzado que trabaja la espalda. Realiza dominadas usando una sola mano mientras mantienes la otra libre.',
        false),
    Exercise(
        'Plancha Lateral',
        'Abdominales Oblicuos',
        'La plancha lateral es una variante de la plancha que se enfoca en los abdominales oblicuos. Apóyate en un antebrazo y un pie, manteniendo el cuerpo en línea recta.',
        false),
    Exercise(
        'Prensa de Piernas Inclinada',
        'Cuádriceps',
        'La prensa de piernas inclinada se realiza en una máquina inclinada y trabaja los cuádriceps. Empuja el peso hacia arriba con las piernas en un ángulo inclinado.',
        false),
    Exercise(
        'Flexiones de Brazos con Pelota Medicinal',
        'Pecho',
        'Coloca una pelota medicinal bajo una mano mientras haces flexiones de brazos. Esto aumenta la intensidad y trabaja el equilibrio.',
        false),
    Exercise(
        'Abdominales de Pierna Colgante',
        'Abdominales Inferiores',
        'Cuelga de una barra y levanta las piernas hacia arriba, trabajando los abdominales inferiores. Mantén las piernas rectas durante el movimiento.',
        false),
    Exercise(
        'Sentadilla Frontal',
        'Piernas',
        'La sentadilla frontal se realiza con la barra en la parte frontal de los hombros. Baja y sube el cuerpo como en una sentadilla estándar, pero con énfasis en los cuádriceps.',
        false),
  ];
  TextEditingController titleController = TextEditingController();

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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration:
                          InputDecoration(labelText: 'Titulo del ejercicio'),
                    ),
                  ],
                ),
              ),
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
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (titleController.text.isNotEmpty &&
                            selectedExercises.length != 0) {
                          Rutina rutina = new Rutina(
                              nombre: titleController.text, ejercicios: []);
                          DB.insertTitulo(rutina);
                          selectedExercises.forEach((element) {
                            Ejercicio ejercicio = new Ejercicio(
                                name: element.name,
                                muscle: element.muscle,
                                description: element.description,
                                titulo: titleController.text);
                            DB.insert(ejercicio);
                          });
                          selectedExercises = [];
                          Provider.of<TabProvider>(context, listen: false)
                              .updateSelectedIndex(0);
                        } else if (selectedExercises.length == 0) {
                          Provider.of<TabProvider>(context, listen: false)
                              .updateSelectedIndex(0);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Título vacío'),
                                content: Text('Por favor, rellene el título'),
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan[500],
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

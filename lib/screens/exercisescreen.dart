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
        'Consejos para hacer bien la sentadilla:\n1. Mantén los pies a la altura de los hombros.\n2. Baja las caderas hacia abajo y hacia atrás como si te estuvieras sentando en una silla invisible.\n3. Asegúrate de que tus rodillas no se desplacen hacia adelante de tus pies.\n4. Mantén la espalda recta durante todo el movimiento.',
        false),
    Exercise(
        'Press de Banca',
        'Pecho',
        'Consejos para hacer bien el press de banca:\n1. Acuéstate en un banco con los pies en el suelo.\n2. Sostén la barra con las manos separadas a la anchura de los hombros.\n3. Baja la barra hacia tu pecho de manera controlada.\n4. Luego, empújala hacia arriba sin bloquear los codos en la posición final.',
        false),
    Exercise(
        'Peso Muerto',
        'Isquiotibiales',
        'Consejos para hacer bien el peso muerto:\n1. Agáchate para sujetar la barra.\n2. Mantén la espalda recta.\n3. Levanta la barra hasta que estés de pie.\n4. Asegúrate de mantener la barra cerca de tu cuerpo.\n5. Contrae los glúteos en la posición de pie.',
        false),
    Exercise(
        'Press Militar',
        'Hombros',
        'Consejos para hacer bien el press militar:\n1. Sostén una barra o mancuernas a la altura de los hombros.\n2. Presiona hacia arriba sobre tu cabeza.\n3. Mantén el núcleo firme y evita arquear la espalda.\n4. Baja la barra o mancuernas bajo control.',
        false),
    Exercise(
        'Pull-Ups',
        'Espalda',
        'Consejos para hacer bien las dominadas:\n1. Cuelga de una barra.\n2. Levanta tu cuerpo hacia arriba, manteniendo los codos doblados.\n3. Mantén los hombros hacia abajo y hacia atrás para enfocar el trabajo en la espalda y los brazos.',
        false),
    Exercise(
        'Fondos en Paralelas',
        'Tríceps',
        'Consejos para hacer bien los fondos en paralelas:\n1. Colócate entre dos barras paralelas.\n2. Baja tu cuerpo de manera controlada.\n3. Luego empújate hacia arriba.\n4. Asegúrate de mantener los codos cerca del cuerpo durante el movimiento.',
        false),
    Exercise(
        'Zancadas',
        'Cuádriceps',
        'Consejos para hacer bien las zancadas:\n1. Da un paso adelante con una pierna.\n2. Baja la cadera hasta que ambas rodillas estén dobladas a 90 grados.\n3. Mantén la espalda recta.\n4. Asegúrate de que la rodilla de la pierna trasera no toque el suelo en la posición más baja.',
        false),
    Exercise(
        'Curl de Bíceps',
        'Bíceps',
        'Consejos para hacer bien el curl de bíceps:\n1. Sujeta una barra o mancuernas con los brazos extendidos.\n2. Dobla los codos para llevar el peso hacia los hombros de manera controlada.\n3. Evita balancear el cuerpo durante el movimiento.',
        false),
    Exercise(
        'Prensa de Piernas',
        'Cuádriceps',
        'Consejos para hacer bien la prensa de piernas:\n1. Siéntate en la máquina de prensa de piernas.\n2. Empuja el peso hacia arriba con las piernas.\n3. Mantén la espalda pegada al respaldo.\n4. Controla el movimiento en todo momento.',
        false),
    Exercise(
        'Plancha',
        'Core',
        'Consejos para hacer bien la plancha:\n1. Apóyate en los antebrazos y los dedos de los pies.\n2. Mantén el cuerpo en línea recta y el núcleo contraído.\n3. Mantén la posición durante el tiempo determinado.\n4. Evita que la cadera se hunda o se eleve.',
        false),
    Exercise(
        'Deadlift Rumano',
        'Isquiotibiales',
        'Consejos para hacer bien el deadlift rumano:\n1. Mantén las piernas rectas.\n2. Baja el torso mientras mantienes la espalda recta.\n3. Luego regresa a la posición inicial.\n4. Asegúrate de sentir el estiramiento en los isquiotibiales al bajar el peso.',
        false),
    Exercise(
        'Press de Hombros con Mancuernas',
        'Hombros',
        'Consejos para hacer bien el press de hombros con mancuernas:\n1. Sostén una mancuerna en cada mano a la altura de los hombros.\n2. Presiona hacia arriba de manera controlada.\n3. Mantén el equilibrio y la estabilidad en todo momento.',
        false),
    Exercise(
        'Flexiones de Tríceps',
        'Tríceps',
        'Consejos para hacer bien las flexiones de tríceps:\n1. Realiza flexiones con las manos colocadas cerca una de la otra para trabajar más los tríceps.\n2. Mantén el cuerpo en línea recta.\n3. Baja el pecho hacia el suelo.',
        false),
    Exercise(
        'Peso Muerto Sumo',
        'Piernas y Glúteos',
        'Consejos para hacer bien el peso muerto sumo:\n1. Realiza el movimiento con un agarre ancho.\n2. Mantén las piernas separadas.\n3. Baja el torso manteniendo la espalda recta.\n4. Luego estira las caderas en la posición de pie.',
        false),
    Exercise(
        'Elevaciones Laterales',
        'Hombros',
        'Consejos para hacer bien las elevaciones laterales:\n1. De pie, sostén una mancuerna en cada mano a los lados.\n2. Levanta los brazos hacia los lados hasta que estén paralelos al suelo.\n3. Controla el movimiento en todo momento.',
        false),
    Exercise(
        'Prensa Inclinada',
        'Pecho',
        'Consejos para hacer bien la prensa inclinada:\n1. Realiza el ejercicio en un banco inclinado.\n2. Baja y sube la barra de pesas o mancuernas de manera controlada.\n3. Mantén el pecho arriba y la espalda pegada al banco.',
        false),
    Exercise(
        'Pájaros',
        'Deltoides Posterior',
        'Consejos para hacer bien los pájaros:\n1. Inclínate hacia adelante.\n2. Levanta pesas hacia los lados.\n3. Mantén los brazos ligeramente doblados.\n4. Siente la contracción en los deltoides posteriores.\n5. Evita balancear el cuerpo.',
        false),
    Exercise(
        'Prensa de Tríceps',
        'Tríceps',
        'Consejos para hacer bien la prensa de tríceps:\n1. Realiza el ejercicio en una máquina específica.\n2. Empuja la barra hacia arriba de manera controlada, extendiendo completamente los brazos.\n3. Mantén el núcleo firme durante el movimiento.',
        false),
    Exercise(
        'Hiperextensiones',
        'Espalda Baja',
        'Consejos para hacer bien las hiperextensiones:\n1. Realiza el ejercicio en una máquina de hiperextensiones o con un banco romano.\n2. Inclínate hacia adelante y luego endereza la espalda.\n3. Mantén la espalda recta y controla el movimiento.',
        false),
    Exercise(
        'Curl de Martillo',
        'Bíceps',
        'Consejos para hacer bien el curl de martillo:\n1. Sujeta una mancuerna en cada mano con las palmas mirándose entre sí.\n2. Dobla los codos de manera controlada.\n3. Evita balancear los brazos durante el movimiento.',
        false),
    Exercise(
        'Zancada Lateral',
        'Piernas y Glúteos',
        'Consejos para hacer bien las zancadas laterales:\n1. Da un paso lateral.\n2. Baja la cadera de manera controlada.\n3. Mantén el equilibrio y controla el movimiento en todo momento.',
        false),
    Exercise(
        'Press de Banca Declinado',
        'Pecho',
        'Consejos para hacer bien el press de banca declinado:\n1. Realiza el ejercicio en un banco declinado.\n2. Baja y sube la barra de pesas o mancuernas de manera controlada.\n3. Mantén el control en todo momento.',
        false),
    Exercise(
        'Curl de Concentración',
        'Bíceps',
        'Consejos para hacer bien el curl de concentración:\n1. Siéntate en un banco.\n2. Apoya una pierna en el interior del codo.\n3. Realiza curls con una mancuerna de manera controlada.\n4. Mantén la concentración en el bíceps trabajado.',
        false),
    Exercise(
        'Extensión de Cadera',
        'Glúteos',
        'Consejos para hacer bien la extensión de cadera:\n1. Realiza el movimiento de extensión de cadera hacia atrás de manera controlada.\n2. Siente la contracción en los glúteos.\n3. Mantén el núcleo firme.',
        false),
    Exercise(
        'Elevaciones Frontales',
        'Hombros',
        'Consejos para hacer bien las elevaciones frontales:\n1. Sostén una barra o mancuernas.\n2. Levanta los brazos hacia adelante hasta la altura de los hombros de manera controlada.\n3. Controla el movimiento y evita usar impulso.',
        false),
    Exercise(
        'Polea Alta',
        'Espalda',
        'Consejos para hacer bien la polea alta:\n1. Utiliza una polea alta con una barra o cuerda.\n2. Tira hacia abajo hacia el pecho de manera controlada.\n3. Mantén la espalda recta y el núcleo firme durante el movimiento.',
        false),
    Exercise(
        'Press Francés',
        'Tríceps',
        'Consejos para hacer bien el press francés:\n1. Realiza el ejercicio acostado en un banco.\n2. Baja la barra hacia la frente de manera controlada.\n3. Luego, extiende los brazos.\n4. Evita bloquear los codos en la posición final.',
        false),
    Exercise(
        'Elevaciones de Pantorrilla',
        'Pantorrillas',
        'Consejos para hacer bien las elevaciones de pantorrilla:\n1. Realiza el movimiento de elevación de pantorrilla de manera controlada.\n2. Mantén el equilibrio y evita movimientos bruscos.\n3. Siente la contracción en las pantorrillas.',
        false),
    Exercise(
        'Burpees',
        'Cuerpo Completo',
        'Consejos para hacer bien los burpees:\n1. Combina saltos, flexiones y sentadillas en un movimiento fluido.\n2. Realiza cada parte del ejercicio de manera controlada.\n3. Mantén un ritmo constante.',
        false),
    Exercise(
        'Abdominales Russian Twist',
        'Abdominales Oblicuos',
        'Consejos para hacer bien los abdominales Russian Twist:\n1. Siéntate en el suelo.\n2. Inclina el torso hacia atrás.\n3. Gira el torso de un lado a otro sosteniendo un peso o una pelota medicinal de manera controlada.\n4. Mantén el núcleo contraído en todo momento.',
        false),
    Exercise(
        'Peso Muerto a una Pierna',
        'Piernas',
        'Consejos para hacer bien el peso muerto a una pierna:\n1. Sujeta una mancuerna en una mano.\n2. Realiza un peso muerto mientras mantienes una pierna en el aire de manera controlada.\n3. Mantén el equilibrio y la estabilidad durante el movimiento.',
        false),
    Exercise(
        'Press de Hombros Arnold',
        'Hombros',
        'Consejos para hacer bien el press de hombros Arnold:\n1. Sostén las mancuernas con las palmas hacia ti.\n2. Gira las manos durante el movimiento de manera controlada.\n3. Mantén el control en todo momento.',
        false),
    Exercise(
        'Sentadilla con Salto',
        'Piernas',
        'Consejos para hacer bien la sentadilla con salto:\n1. Realiza una sentadilla de manera controlada.\n2. Impúlsate hacia arriba en un salto explosivo.\n3. Aterriza suavemente y repite el movimiento.',
        false),
    Exercise(
        'Curl de Bíceps con Barra Z',
        'Bíceps',
        'Consejos para hacer bien el curl de bíceps con barra Z:\n1. Sujeta la barra con las manos en posición neutral.\n2. Realiza curls de manera controlada.\n3. Evita balancear el cuerpo durante el movimiento.',
        false),
    Exercise(
        'Flexiones de Pecho Diamante',
        'Pecho',
        'Consejos para hacer bien las flexiones de pecho diamante:\n1. Coloca las manos juntas en forma de diamante en el suelo.\n2. Realiza flexiones de manera controlada.\n3. Mantén el cuerpo en línea recta durante todo el movimiento.',
        false),
    Exercise(
        'Hip Thrust',
        'Glúteos',
        'Consejos para hacer bien el hip thrust:\n1. Realiza el ejercicio en un banco.\n2. Coloca las pesas en las caderas.\n3. Eleva la pelvis hacia arriba de manera controlada.\n4. Siente la contracción en los glúteos.\n5. Evita arquear la espalda.',
        false),
    Exercise(
        'Press de Tríceps con Mancuernas',
        'Tríceps',
        'Consejos para un press de tríceps con mancuernas efectivo:\n1. Acuéstate en un banco con la espalda plana y los pies en el suelo.\n2. Sujeta las mancuernas con los brazos extendidos y los codos cerca de tu cabeza.\n3. Baja lentamente las pesas hacia tu frente, manteniendo los codos estables.\n4. Empuja las mancuernas hacia arriba, extendiendo completamente los brazos.\n5. Controla el movimiento en todo momento y evita arquear la espalda.',
        false),
    Exercise(
        'Burpees con Lagartijas',
        'Cuerpo Completo',
        'Consejos para realizar burpees con lagartijas de manera efectiva:\n1. Comienza de pie con los pies al ancho de los hombros.\n2. Realiza un burpee, bajando al suelo y saltando hacia atrás.\n3. En la posición de lagartija, mantén el cuerpo en línea recta y baja el pecho hacia el suelo.\n4. Empuja hacia arriba y vuelve a la posición de burpee.\n5. Salta hacia arriba con potencia al final del movimiento.\n6. Mantén un ritmo constante para un entrenamiento efectivo.',
        false),
    Exercise(
        'Peso Muerto Sumo con Mancuernas',
        'Piernas y Glúteos',
        'Consejos para un peso muerto sumo con mancuernas efectivo:\n1. Colócate con los pies más anchos que el ancho de los hombros y las mancuernas a los lados.\n2. Mantén la espalda recta y los hombros hacia atrás.\n3. Dobla las caderas y las rodillas para bajar las mancuernas hacia el suelo.\n4. Mantén las pesas cerca de las piernas durante el movimiento.\n5. Extiende las caderas y las rodillas para levantar las mancuernas.\n6. Mantén el núcleo comprometido y evita el encorvamiento de la espalda.',
        false),
    Exercise(
        'Dominadas a una Mano',
        'Espalda',
        'Consejos para realizar dominadas a una mano de manera efectiva:\n1. Asegúrate de tener una fuerza adecuada en la mano que sostiene la barra.\n2. Realiza dominadas usando una sola mano mientras mantienes la otra libre para equilibrar.\n3. Mantén un ritmo constante y controlado durante el movimiento.\n4. Evita el balanceo excesivo del cuerpo.\n5. Utiliza una banda de resistencia o un asistente si es necesario para progresar gradualmente.',
        false),
    Exercise(
        'Plancha Lateral',
        'Abdominales Oblicuos',
        'Consejos para una plancha lateral efectiva:\n1. Apóyate en un antebrazo y un pie, manteniendo el cuerpo en línea recta.\n2. Alinea el codo debajo del hombro y mantén la cadera elevada.\n3. Mantén los abdominales y los glúteos contraídos para estabilizar la posición.\n4. Respira de manera constante y mantén la posición durante el tiempo deseado.\n5. Cambia de lado para trabajar ambos lados de los abdominales oblicuos.',
        false),
    Exercise(
        'Prensa de Piernas Inclinada',
        'Cuádriceps',
        'Consejos para una prensa de piernas inclinada efectiva:\n1. Ajusta la máquina inclinada según tu comodidad.\n2. Coloca los pies en el soporte y la espalda en el respaldo.\n3. Empuja el peso hacia arriba con las piernas en un ángulo inclinado.\n4. Extiende completamente las piernas sin bloquear las rodillas.\n5. Controla el movimiento y evita usar impulso.\n6. Mantén una respiración constante durante el ejercicio.',
        false),
    Exercise(
        'Flexiones de Brazos con Pelota Medicinal',
        'Pecho',
        'Consejos para realizar flexiones de brazos con pelota medicinal de manera efectiva:\n1. Coloca una pelota medicinal bajo una mano mientras haces flexiones.\n2. Mantén las manos a la altura de los hombros y el cuerpo en línea recta.\n3. Baja el pecho hacia la pelota y luego empuja hacia arriba.\n4. Alterna la pelota entre las manos para trabajar ambos lados del pecho.\n5. Controla el movimiento y mantén la estabilidad durante el ejercicio.',
        false),
    Exercise(
        'Abdominales de Pierna Colgante',
        'Abdominales Inferiores',
        'Consejos para realizar abdominales de pierna colgante de manera efectiva:\n1. Cuelga de una barra con las manos firmes y las piernas extendidas.\n2. Levanta las piernas hacia arriba usando los músculos de los abdominales inferiores.\n3. Mantén las piernas rectas durante el movimiento.\n4. Controla la velocidad de descenso de las piernas para evitar el balanceo excesivo.\n5. Realiza repeticiones controladas y mantén la técnica adecuada.',
        false),
    Exercise(
        'Sentadilla Frontal',
        'Piernas',
        'Consejos para una sentadilla frontal efectiva:\n1. Coloca la barra en la parte frontal de los hombros, sosteniéndola con las manos cruzadas.\n2. Mantén los pies a la altura de los hombros.\n3. Baja el cuerpo flexionando las caderas y las rodillas, manteniendo la espalda recta.\n4. Mantén los codos altos para evitar que la barra se desplace hacia adelante.\n5. Extiende las caderas y las rodillas para volver a la posición inicial.\n6. Controla el movimiento en todo momento y evita el colapso de la espalda.',
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
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[900],
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
                      decoration: InputDecoration(
                        labelText: 'Titulo del ejercicio',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
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
                  },
                ),
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
                      if (titleController.text.isNotEmpty && selectedExercises.length != 0) {
                        Rutina rutina = new Rutina(
                            nombre: titleController.text, ejercicios: []);
                        DB.insertTitulo(rutina);
                        selectedExercises.forEach((element) {
                          Ejercicio ejercicio = new Ejercicio(
                              name: element.name,
                              muscle: element.muscle,
                              description: element.description,
                              titulo: titleController.text,
                              repeticiones: 0,
                              series: 0,
                              pesoMax: 0);
                          DB.insert(ejercicio);
                        });
                        // Desseleccionar ejercicios después de guardar
                        selectedExercises.clear();

                        // Deseleccionar ejercicios en la lista exercises
                        for (int i = 0; i < exercises.length; i++) {
                          exercises[i].isSelected = false;
                        }

                        // Actualizar el estado para reflejar los cambios
                        setState(() {
                          textButton = "Cancelar"; // Actualiza el texto del botón
                        });
                        Provider.of<TabProvider>(context, listen: false).updateSelectedIndex(0);
                        // Vaciar el campo del título después de guardar
                        titleController.clear();
                      } else if (selectedExercises.length == 0) {
                        setState(() {
                          textButton = "Cancelar"; // Restaura el texto del botón a "Cancelar"
                        });
                        Provider.of<TabProvider>(context, listen: false).updateSelectedIndex(0);
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
                      backgroundColor: Colors.grey[700],
                    ),
                    child: Text(
                      textButton,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Agrega margen vertical
      child: Card(
        color: Colors.grey[800], // Establece el fondo gris al Card
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[700],
            child: Icon(
              Icons.person_outline_outlined,
              color: Colors.white,
            ),
          ),
          title: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            muscle,
            style: TextStyle(color: Colors.white),
          ),
          trailing: isSelected
              ? Icon(
            Icons.check_circle,
            color: Colors.white,
          )
              : Icon(
            Icons.check_circle_outline,
            color: Colors.white,
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
        ),
      ),
    );
  }
}

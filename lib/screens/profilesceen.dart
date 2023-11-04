import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double weight = 70.0;
  double height = 1.75;
  double waist = 80.0;
  double neck = 35.0;
  double hip = 90.0;

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController neckController = TextEditingController();
  TextEditingController hipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    weightController.text = weight.toString();
    heightController.text = height.toString();
    waistController.text = waist.toString();
    neckController.text = neck.toString();
    hipController.text = hip.toString();

    weightController.addListener(updateValues);
    heightController.addListener(updateValues);
    waistController.addListener(updateValues);
    neckController.addListener(updateValues);
    hipController.addListener(updateValues);
  }

  void updateValues() {
    setState(() {
      weight = double.parse(weightController.text);
      height = double.parse(heightController.text);
      waist = double.parse(waistController.text);
      neck = double.parse(neckController.text);
      hip = double.parse(hipController.text);
    });
  }

  double calculateBMI(double weight, double height) {
    return weight / (height * height);
  }

  String getHealthStatus(double bmi) {
    if (bmi < 18.5) {
      return 'Bajo peso';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Peso normal';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Sobrepeso';
    } else {
      return 'Obesidad';
    }
  }

  double calculateBodyFatPercentage(double waist, double neck, double hip, double weight, double height) {
    // Realiza los cálculos para el porcentaje de grasa corporal
    // Puedes implementar la fórmula deseada aquí
    // Por ejemplo, puedes utilizar la fórmula de Navy o cualquier otra
    return 20.0; // Valor de ejemplo, reemplázalo con el cálculo real
  }

  @override
  Widget build(BuildContext context) {
    final bmi = calculateBMI(weight, height);
    final healthStatus = getHealthStatus(bmi);
    final bodyFatPercentage = calculateBodyFatPercentage(waist, neck, hip, weight, height);

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Peso (kg)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Peso (kg)'),
              ),
              SizedBox(height: 12),
              Text(
                'Altura (m)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Altura (m)'),
              ),
              SizedBox(height: 12),
              Text(
                'Circunferencia de la cintura (cm)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: waistController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Circunferencia de la cintura (cm)'),
              ),
              SizedBox(height: 12),
              Text(
                'Circunferencia del cuello (cm)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: neckController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Circunferencia del cuello (cm)'),
              ),
              SizedBox(height: 12),
              Text(
                'Circunferencia de la cadera (cm)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: hipController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Circunferencia de la cadera (cm)'),
              ),
              SizedBox(height: 16),
              Text(
                'BMI: $bmi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Estado de Salud: $healthStatus',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Porcentaje de Grasa Corporal: $bodyFatPercentage%',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

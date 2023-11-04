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
    final leanBodyMass = weight - (weight * (waist + neck - hip) / 100.0);
    final bodyFat = weight - leanBodyMass;
    return (bodyFat / weight) * 100.0;
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
              _buildField('Peso (kg)', weightController),
              _buildField('Altura (m)', heightController),
              _buildField('Circunferencia de la cintura (cm)', waistController),
              _buildField('Circunferencia del cuello (cm)', neckController),
              _buildField('Circunferencia de la cadera (cm)', hipController),
              SizedBox(height: 16),
              Text(
                'BMI: ${bmi.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Estado de Salud: $healthStatus',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Porcentaje de Grasa Corporal: ${bodyFatPercentage.toStringAsFixed(2)}%',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Ingrese $title',
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../database/db.dart';
import '../database/userData.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController waistController = TextEditingController();
  TextEditingController neckController = TextEditingController();
  TextEditingController hipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final userData = await DB.getUserData();
    if (userData != null) {
      setState(() {
        weightController.text = userData.weight.toString();
        heightController.text = userData.height.toString();
        waistController.text = userData.waist.toString();
        neckController.text = userData.neck.toString();
        hipController.text = userData.hip.toString();
      });
    }
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

  double calculateBMI(double weight, double height) {
    if (height > 0) {
      return weight / (height * height);
    } else {
      return 0.0;
    }
  }

  double calculateBodyFat(double weight,double height, double waist, double neck, double hip) {
    final leanBodyMass = weight - (weight * (waist + neck - hip) / 100.0);
    final bodyFat = weight - leanBodyMass;
    return (bodyFat / weight) * 100.0;
  }

  double calculateLeanBodyMass(double weight, double bodyFat) {
    return weight * (1 - (bodyFat / 100));
  }

  void updateValues() {
    final weight = double.tryParse(weightController.text) ?? 0.0;
    final height = double.tryParse(heightController.text) ?? 0.0;
    final waist = double.tryParse(waistController.text) ?? 0.0;
    final neck = double.tryParse(neckController.text) ?? 0.0;
    final hip = double.tryParse(hipController.text) ?? 0.0;

    DB.saveUserData(UserData(
      weight: weight,
      height: height,
      waist: waist,
      neck: neck,
      hip: hip,
    ));
  }

  @override
  Widget build(BuildContext context) {
    double weight = double.tryParse(weightController.text) ?? 0.0;
    double height = double.tryParse(heightController.text) ?? 0.0;
    double waist = double.tryParse(waistController.text) ?? 0.0;
    double neck = double.tryParse(neckController.text) ?? 0.0;
    double hip = double.tryParse(hipController.text) ?? 0.0;

    double bmi = calculateBMI(weight, height);
    double bodyFat = calculateBodyFat(weight, height, waist, neck, hip);
    double leanBodyMass = calculateLeanBodyMass(weight, bodyFat);
    String healthStatus = getHealthStatus(bmi);

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[900],
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
              Text('Índice de masa corporal: ${bmi.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 16),
              Text('Estado de salud: ${healthStatus}',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 16),
              Text('Porcentaje de grasa: ${bodyFat.toStringAsFixed(2)}%',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 16),
              Text('Porcentaje de masa magra: ${leanBodyMass.toStringAsFixed(2)} kg',
                style: TextStyle(color: Colors.white, fontSize: 18),
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
              color: Colors.white,
            ),
          ),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 16, color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Ingrese $title',
              contentPadding: EdgeInsets.all(12),
              border: OutlineInputBorder(),
              fillColor: Colors.white,
              filled: true,
            ),
            onChanged: (value) {
              updateValues();
            },
          ),
        ],
      ),
    );
  }
}

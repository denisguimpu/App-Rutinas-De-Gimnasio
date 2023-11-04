import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double weight = 70.0; // Peso del usuario en kilogramos
  double height = 1.75; // Altura del usuario en metros

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    weightController.text = weight.toString();
    heightController.text = height.toString();

    weightController.addListener(updateValues);
    heightController.addListener(updateValues);
  }

  double calculateBMI(double weight, double height) {
    return weight / (height * height);
  }

  String getHealthStatus(double bmi) {
    if (bmi < 18.5) {
      return 'Bajo peso';
    } else if (bmi < 24.9) {
      return 'Peso normal';
    } else if (bmi < 29.9) {
      return 'Sobrepeso';
    } else {
      return 'Obesidad';
    }
  }

  void updateValues() {
    setState(() {
      weight = double.parse(weightController.text);
      height = double.parse(heightController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bmi = calculateBMI(weight, height);
    final healthStatus = getHealthStatus(bmi);

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Peso (kg)',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Altura (m)',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (m)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Índice de Masa Corporal (IMC): ${bmi.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Estado de salud: $healthStatus',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

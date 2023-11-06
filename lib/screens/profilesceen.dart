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

  void updateValues() {
    final weight = double.parse(weightController.text);
    final height = double.parse(heightController.text);
    final waist = double.parse(waistController.text);
    final neck = double.parse(neckController.text);
    final hip = double.parse(hipController.text);

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
              Text('Índice de masa corporal:',style: TextStyle(color: Colors.white, fontSize: 18),),
              SizedBox(height: 16),
              Text('Porcentaje de grasa:',style: TextStyle(color: Colors.white, fontSize: 18),),
              SizedBox(height: 16),
              Text('Porcentaje de masa magra:',style: TextStyle(color: Colors.white, fontSize: 18),),
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
              updateValues(); // Llama a la función cuando el texto cambia
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
            children: <Widget> [
              Padding(padding: EdgeInsets.all(20)),
              Icon(Icons.account_circle, size: 50.0,),
              Text('Profile Screen'),
            ]
        ),
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/exercisescreen.dart';
import 'package:flutter_app/screens/profilesceen.dart';
import 'package:flutter_app/screens/homescreen.dart';
import 'package:flutter_app/views/bottomnavbar.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      home: BottomNavBar(),
      theme: ThemeData(
        primaryColor: Color(0xFF5F5FFF),
        hintColor: Color(0XFF030047),
        highlightColor: Color(0XFFB7B7D2),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
            color: Color(0XFF030047),
          ),
            headline2: TextStyle(
            fontSize: 36.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF5F5FFF),
        ),
            bodyText1: TextStyle(
            fontSize: 20.0,
            color: Color(0XFFb7B7D2)
        )
        )
      ),
    );

  }
  
}

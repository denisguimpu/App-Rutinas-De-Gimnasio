import 'package:flutter/material.dart';
import 'package:flutter_app/screens/exercisescreen.dart';
import 'package:flutter_app/screens/profilesceen.dart';
import 'package:flutter_app/screens/homescreen.dart';
import 'package:flutter_app/views/bottomnavbar.dart';
import 'package:flutter_app/views/changenotifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TabProvider(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      home: BottomNavBar(),
    );

  }
  
}

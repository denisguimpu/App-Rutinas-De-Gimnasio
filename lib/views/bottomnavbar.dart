import 'package:flutter/material.dart';
import 'package:flutter_app/screens/exercisescreen.dart';
import 'package:flutter_app/screens/homescreen.dart';

import '../screens/profilesceen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super (key : key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}


class _BottomNavBarState extends State<BottomNavBar> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    final screens = [ SplashScreen(), MainScreen(), ProfileScreen()];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
            backgroundColor:  Colors.cyan,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle_outlined),
            label: 'Ejercicios',
            backgroundColor:  Colors.lightGreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
            backgroundColor:  Colors.deepPurple,
          ),
        ],
      ),
    );
  }
}
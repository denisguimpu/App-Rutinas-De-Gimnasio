import 'package:flutter/material.dart';
import 'package:flutter_app/screens/mainscreen.dart';
import 'package:flutter_app/screens/splashscreen.dart';

void main() {
  runApp( MyAppstateless());
}
class MyAppstateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      home: SplashScreen(),
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
class Myapp extends StatefulWidget{
  const Myapp({super.key});
  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp>{

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Inicio',
      style: optionStyle,
    ),
    Text(
      'Index 1: Ejercicios',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

}

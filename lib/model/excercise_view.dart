import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ExcerciseView extends StatelessWidget {
  final String child;


  ExcerciseView({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        height: 100,
        color: Colors.deepPurple[100],
        child: Center(
            child: Text(
                child,
            style: TextStyle(fontSize: 40),
            )),
      ),
    );
  }
}
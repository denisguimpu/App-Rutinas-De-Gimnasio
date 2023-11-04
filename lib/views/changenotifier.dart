import 'package:flutter/material.dart';

class TabProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    print('selectedIndex actualizado a: $_selectedIndex'); // Agregar un print statement
    notifyListeners();
  }
}

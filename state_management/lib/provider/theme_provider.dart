

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeModel extends ChangeNotifier {

  Color textColor = Colors.red;

  void changeTextColor(int number){
    textColor = number.isEven ? Colors.red : Colors.blue;
    notifyListeners();
  }

}
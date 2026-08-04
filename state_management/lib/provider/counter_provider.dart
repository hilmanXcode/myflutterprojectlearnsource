
import 'package:flutter/material.dart';

class CounterModel extends ChangeNotifier {
  int _counter = 0;

  int get counterNumber => _counter;

  void incrementNumber(){
    _counter++;
    notifyListeners();
  }


  void decrementNumber(){
    _counter--;
    notifyListeners();
  }

}
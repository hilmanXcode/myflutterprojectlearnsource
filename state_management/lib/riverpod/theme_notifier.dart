
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends Notifier<Color> {
  @override
  Color build() => Colors.red;

  void changeTextColor(int number){
    state = number.isEven ? Colors.red : Colors.blue;
  }
}

final themeNotifier = NotifierProvider<ThemeNotifier, Color>(ThemeNotifier.new);
import 'package:find_my_location/screens/flutter_maps_screen.dart';
import 'package:find_my_location/screens/google_maps_screen.dart';
import 'package:flutter/material.dart';

class TabHandler extends StatefulWidget {

  final String tabScreen;
  const TabHandler({super.key, required this.tabScreen});

  @override
  State<TabHandler> createState() => _TabHandlerState();
}

class _TabHandlerState extends State<TabHandler> {
  @override
  Widget build(BuildContext context) {
    
    if(widget.tabScreen == "Google Maps"){
      return GoogleMapsScreen();
    } else if(widget.tabScreen == "Flutter Maps"){
      return FlutterMapsScreen();
    } else {
      return Scaffold(
        body: Center(
          child: Text("hello world"),
        ),
      );
    }
  }
}
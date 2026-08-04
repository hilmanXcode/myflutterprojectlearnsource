import 'package:find_my_location/screens/flutter_maps_screen.dart';
import 'package:find_my_location/screens/google_maps_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';


void main() {
// Require Hybrid Composition mode on Android.
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    // Force Hybrid Composition mode.
    mapsImplementation.useAndroidViewSurface = true;
  }
  // ·

 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  const MyHomePage({super.key});

  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  late TabController tabController;
  late List<String> maps;
  late List<Tab> tabs;


  var currentIndex = 0;
  final screens = [GoogleMapsScreen(), FlutterMapsScreen()];

  @override
  void initState() {
    super.initState();

    Geolocator.requestPermission();
    

  }

  @override
  Widget build(BuildContext context) {




  
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Google Maps"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Flutter Maps")
        ]
      ),
    );
  }
}

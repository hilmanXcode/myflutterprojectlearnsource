import 'dart:async';

import 'package:find_my_location/components/card_info_location.dart';
import 'package:find_my_location/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';



class FlutterMapsScreen extends StatefulWidget {
  const FlutterMapsScreen({super.key});

  @override
  State<FlutterMapsScreen> createState() => _FlutterMapsScreenState();
}

class _FlutterMapsScreenState extends State<FlutterMapsScreen> {

  var initialLatitude = -6.192273605139613;
  var initialLongitude = 106.8032467242155;
  var initialZoom = 16.0;
  var initialAdress = "Testing";

  List<Marker> markers = [];

  Timer? searchTimer;
  late MapController mapController;
  late Geocoding geocoding;

  @override
  void initState() {
    super.initState();
    
    mapController = MapController();
    geocoding = Geocoding();
    setMarker(initialLatitude, initialLongitude, initialAdress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Flutter Maps"),
        ),
      ),

      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: LatLng(initialLatitude, initialLongitude), // Center the map over London, UK
              initialZoom: initialZoom,
              onLongPress: (tapPosition, point) async {
                initialLatitude = point.latitude;
                initialLongitude = point.longitude;
                initialAdress = await Helper.getAddressFromLatLong(
                  geocoding,
                  initialLatitude,
                  initialLongitude
                );

                setMarker(
                  initialLatitude,
                  initialLongitude,
                  initialAdress
                );
              }
            ),
            children: [
              TileLayer( // Bring your own tiles
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
                userAgentPackageName: 'com.example.find_my_location'
              ),


              MarkerLayer(markers: markers)
             
            ],
          ),

          CardInfoLocation(
            latitude: initialLatitude,
            longitude: initialLongitude,
            address: initialAdress,
            onChanged: (value){
              if(searchTimer?.isActive ?? false) searchTimer?.cancel();
              if(value.trim().isNotEmpty){
                searchTimer = Timer(Duration(seconds: 1), (){
                  searchLocation(value);
                });
              }
            },
            onSubmit: (value){}
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: getLocationWithGPS,
        child: Icon(Icons.gps_fixed),
      ),
    );
  }

  void getLocationWithGPS() async {
    try {
      final location = await Geolocator.getCurrentPosition();
      initialLatitude = location.latitude;
      initialLongitude = location.longitude;
      initialAdress = await Helper.getAddressFromLatLong(geocoding, initialLatitude, initialLongitude);

      // arahkan peta ke lokasi yang di cari
      mapController.moveAndRotate(LatLng(initialLatitude, initialLongitude), initialZoom, 0);
      //tampilkan marker
      setMarker(initialLatitude, initialLongitude, initialAdress);
    } catch(e){
      Helper.showSnackBar(context, "terjadi error: $e");
    }
  }

  void searchLocation(String search) async {
    try {
      final location = await geocoding.locationFromAddress(search);

      // if(location)

      if(location.isNotEmpty){
        initialLatitude = location.first.latitude;
        initialLongitude = location.first.longitude;
        initialAdress = await Helper.getAddressFromLatLong(geocoding, initialLatitude, initialLongitude);


        // arahkan peta ke lokasi yang di cari
        mapController.moveAndRotate(LatLng(initialLatitude, initialLongitude), initialZoom, 0);

        //tampilkan marker
        setMarker(initialLatitude, initialLongitude, initialAdress);
        

      }

    } catch(e){
      Helper.showSnackBar(context, "Tidak dapat menemukan alamat $e");
    }
  }

  void setMarker(double latitude, double longitude, String address){
    setState(() {

      markers.clear();
      markers.add(
        Marker(
          point: LatLng(latitude, longitude),
          child: Icon(Icons.location_pin, color: Colors.black, size: 48,)
        ),

      );
    });
  }

}
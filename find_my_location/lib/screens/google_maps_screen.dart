import 'dart:async';
import 'package:find_my_location/components/card_info_location.dart';
import 'package:find_my_location/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({super.key});

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {

  var initialLatitude = -6.192273605139613;
  var initialLongitude = 106.8032467242155;
  var initialZoom = 16.0;
  var initialAdress = "Testing";
  
  late Completer<GoogleMapController> googleMapController;
  Set<Marker> markers = {};
  late Geocoding geocoding;
  Timer? searchTimer;

  @override
  void initState() {
    super.initState();
    
    googleMapController = Completer<GoogleMapController>();
    geocoding = Geocoding();
    setMarker(initialLatitude, initialLongitude, initialAdress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          GoogleMap(
            markers: markers,
            initialCameraPosition: CameraPosition(
              target: LatLng(initialLatitude, initialLongitude),
              zoom: initialZoom
            ),
            onMapCreated: (controller) {
              googleMapController.complete(controller);
            },
            onLongPress: (latlong) async {

              initialLatitude = latlong.latitude;
              initialLongitude = latlong.longitude;
              initialAdress = await Helper.getAddressFromLatLong(geocoding, initialLatitude, initialLongitude);


              setMarker(initialLatitude, initialLongitude, initialAdress);
            },
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

      if(location.isMocked){
        Helper.showSnackBar(context, "Anda menggunakan Fake GPS/Mock Location");
        return;
      }

      initialLatitude = location.latitude;
      initialLongitude = location.longitude;
      initialAdress = await Helper.getAddressFromLatLong(geocoding, initialLatitude, initialLongitude);

      // arahkan peta ke lokasi yang di cari
      final controller = await googleMapController.future;
      final cameraPosition = CameraPosition(
        target: LatLng(initialLatitude, initialLongitude),
        zoom: initialZoom
      );

      final cameraUpdate = CameraUpdate.newCameraPosition(cameraPosition);

      controller.animateCamera(cameraUpdate);

      //tampilkan marker
      setMarker(initialLatitude, initialLongitude, initialAdress);
    } catch(e){
      Helper.showSnackBar(context, "terjadi error: $e");
    }
  }

  void searchLocation(String search) async {
    try {
      final location = await geocoding.locationFromAddress(search);

      if(location.isNotEmpty){
        initialLatitude = location.first.latitude;
        initialLongitude = location.first.longitude;
        initialAdress = await Helper.getAddressFromLatLong(geocoding, initialLatitude, initialLongitude);

        // arahkan peta ke lokasi yang di cari
        final controller = await googleMapController.future;
        final cameraPosition = CameraPosition(
          target: LatLng(initialLatitude, initialLongitude),
          zoom: initialZoom
        );

        final cameraUpdate = CameraUpdate.newCameraPosition(cameraPosition);

        controller.animateCamera(cameraUpdate);

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
          markerId: MarkerId(address),
          position: LatLng(latitude, longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          infoWindow: InfoWindow(title: address)
        
        ),

      );
    });
  }

}
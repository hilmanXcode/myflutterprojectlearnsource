import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class Helper {

  static void showSnackBar(BuildContext context, String message, {Color color = Colors.red}){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: color,
        )
    );
  }

  static Future<String> getAddressFromLatLong(Geocoding geocoding, double latitude, double longitude) async {
    try{
      List<Placemark> placemark = await geocoding.placemarkFromCoordinates(latitude, longitude);

      if(placemark.isNotEmpty){
        final place = placemark[0];
        final name = place.name ?? "-";
        final thoroughfare = place.thoroughfare ?? "-";
        final subThoroughfare = place.subThoroughfare ?? "-";
        final subLocality = place.subLocality ?? "-";
        final locality = place.locality ?? "-";
        final subAdministrativeArea = place.subAdministrativeArea ?? "-";
        final administrativeArea = place.administrativeArea ?? "-";
        final postalCode = place.postalCode ?? "-";
        final country = place.country ?? "-";
        return "$name, $thoroughfare, $subThoroughfare, $subLocality, $locality, $subAdministrativeArea, $administrativeArea, $postalCode, $country";
      } else {
        return "Alamat tidak ditemukan";
      }
    } catch (exc){
      return "Error saat mendapatkan alamat: ${exc.toString()}";
    }
  }

}
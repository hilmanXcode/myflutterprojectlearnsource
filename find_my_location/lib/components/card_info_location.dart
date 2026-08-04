import 'package:flutter/material.dart';

class CardInfoLocation extends StatelessWidget {

  final double latitude;
  final double longitude;
  final String address;
  final String hintText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmit;
  // final bool onlyOneMark;

  const CardInfoLocation({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.address,
    this.hintText = 'Cari Lokasi',
    required this.onChanged,
    required this.onSubmit,
    // required this onlyOneMark

  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  hintText: hintText
              ),
              onChanged: onChanged,
              onSubmitted: onSubmit,
            ),
            SizedBox(height: 8),
            Text("$latitude,$longitude", textAlign: TextAlign.center,),
            Text(address, textAlign: TextAlign.center,),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

}
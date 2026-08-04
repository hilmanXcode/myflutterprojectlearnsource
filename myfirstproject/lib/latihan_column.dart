
import 'package:flutter/material.dart';

class LatihanColumn extends StatelessWidget {
  const LatihanColumn({super.key});

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    debugPrint("Status Bar Height $statusBarHeight");
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: statusBarHeight),
          Text("Ini adalah teks"),
          Text("Ini contoh teks 2"),
          Text("ini contoh project flutter pertama kita"),
          Icon(Icons.home, color: Colors.blue, size: 48),
          FilledButton(onPressed: (){
          }, child: Text("Button 1")),
          OutlinedButton.icon(onPressed: (){

          }, label: Text("Button 2"), 
          icon: Icon(Icons.home)),

          TextField(
            decoration: 
              InputDecoration(
                hintText: "Masukkan nama anda"
              )
          ),
          Image.asset("assets/image/semsung.png"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.email, size: 36),
              Icon(Icons.home, size: 36),
              Text("Contoh sajah")
            ],
          ),
        ],
      ),
    );
  }
}
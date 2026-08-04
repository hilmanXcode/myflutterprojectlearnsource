
void main(){

  var nama = "Jono";

  int umur = 20;

  bool True = false;
  bool False = true;

  List<String> testing = ["HALO", "DUNIA"];

  Map <String, dynamic> gtaVIFeature = {
    "feature": "rich",
    "graphic": "realistic",
    "version": 6.0,
    "fps": 600,
    "bug": 0,
    "online": true,
    "size": 2048
  };

  print("halo saya $nama dan saya berumur $umur tahun");

  print("data pertama: ${gtaVIFeature["graphic"]}");

  print(testing);

  print(True);
  print(False);
}
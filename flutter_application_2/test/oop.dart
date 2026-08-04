import 'pakaian.dart';

void main(){

  // tanpa constructor
  // var pakaian = Pakaian();
  // pakaian.jenis = "Kemeja";
  // pakaian.warna = "Bodas";

  // with constructor
  var pakaian = Pakaian("Kemeja", "Putih", "M");
  print("${pakaian.jenis} - Warna: ${pakaian.warna}, Ukuran: ${pakaian.ukuran}");
  pakaian.gantiUkuran("XXL");
  separator();
  print("${pakaian.jenis} - Warna: ${pakaian.warna}, Ukuran: ${pakaian.ukuran}");


}


void separator(){
  print("--------------------------------------");
}


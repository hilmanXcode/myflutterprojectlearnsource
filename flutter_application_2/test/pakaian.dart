class Pakaian {
  // Attribut
  String? jenis;
  String? warna;
  String? _ukuran;

  // Constructor
  // Positional argument
  // Pakaian(String jenisNya, String warnaNya){
  //   jenis = jenisNya;
  //   warna = warnaNya;
  // }

  // Named argument
  // Pakaian({String? jenisNya, String? warnaNya}){
  //   jenis = jenisNya;
  //   warna = warnaNya;
  // }

  // direct name argument constructor
  // Pakaian({this.jenis, this.warna});

  // direct constructor
  Pakaian(this.jenis, this.warna, String? ukuran){
    _ukuran = ukuran;
  }


  void gantiUkuran(String ukuranBaru){
    _ukuran = ukuranBaru;
  }

  // String? ukuran(){
  //   return _ukuran;
  // }

  String? get ukuran {
    return _ukuran;
  }





}
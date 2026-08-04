void main(){


  // Kesimpulan
  // 1. ? -> variable diperbolehkan null
  // 2. ?? -> Untuk handle null
  // 3. ! -> gunakan ketika kita sudah memastikan sebuah data kalau data tersebut tidak null
  // 4. late -> untuk memastikan bahwa sebelum dieksekusi -> wajib di inisialisasi dulu

  // String? nama = getNama();

  // if(nama?.length == null){
  //   print("tidak ada data");
  // }else {
  //   // kalau datanya sudah di pastikan tapi masih merah karena ada kemungkinan null
  //   // gunakan ! untuk mengatasi nya
  //   print("$nama terdiri dari ${nama!.length} karakter");
  // }
  late String? nama;
  nama = "jajang";
  printNama(nama);
  // String? nama = null;
  // print(nama?.length ?? "TIDAK ADA DATA");
}

void printNama(String? parameterNama){
  print(parameterNama);
}
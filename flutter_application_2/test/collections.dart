void main(){
  // list itu isinya array
  List<String> motorku = ["GSX-R 150", "NMAX", "Jupyter MX", "MX Kings"];

  print(motorku);

  // int i = 1;-
  // for(String item in motorku){
  //   print("Motor ke - $i : $item");
  //   i++;
  // }

  // Set itu isinya object
  // memiliki fitur union untuk menggabungkan 2 buah set dan ia tidak akan duplikasi a.k.a unique
  // memiliki fitur intersection yaitu untuk menampilkan data yang sama saja dari 2 variabel set
  Set matematika = {8, 9, 7};
  Set fisika = {9, 8, 7, 10};

  print(matematika.intersection(fisika));

  // Map
  // key-value based 
  Map nilai = {
    "matematika": [8, 9, 10, 11, 0],
    "fisika": [10,8,9,19]
  };

  print(nilai);


  print('--------------------');
  List data = [8, 9, 7, 10, 11];
  // membuat sebuah array baru dan memasukkan data tersebut ke dalam sebuah array, tipe nya bisa array lagi atau pun yang lain
  // List copyData = [data, 5];
  // spread operator(mirip js) jadi ia memasukkan data angka 5 tersebut ke dalam array data
  List spreadData = [...data, 5];
  print(spreadData);

}
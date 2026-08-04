void main(){

  try {

    double umur = double.parse("20.5");

    print(umur);

  }
  on FormatException {
    print("Data haruslah berupa angka");
  }
  catch(e){
    print(e);
  }

}
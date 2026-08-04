import 'package:intl/intl.dart';

class Helper {

  static String formatDate(String date, String format){
    try {
      final dateTime = DateTime.parse(date);
      return DateFormat(format, "id_ID").format(dateTime);
    } catch(e){
      return "Invalid date";
    }
  }

  

}
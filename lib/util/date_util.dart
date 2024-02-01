import 'package:intl/intl.dart';

class DateUtil{
  DateUtil._();
  static String getToday() {
    DateTime now = DateTime.now();
    DateFormat format = DateFormat('yyyy-MM-dd');
    String strToday = format.format(now);
    return strToday;
  }
}
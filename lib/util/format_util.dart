import 'package:intl/intl.dart';

class FormatUtil {
  FormatUtil._();
  static String priceFormat(int price) {
    NumberFormat priceFormat = NumberFormat('#,###');
    return priceFormat.format(price);
  }
}

import 'package:intl/intl.dart';

class FormatUtil {
  FormatUtil._();
  static String priceFormat(int price) {
    final NumberFormat numberFormat = NumberFormat('###,###원');
    return numberFormat.format(price);
  }

  static String priceDataFormat(String price) {
    String numericString = price.replaceAll(RegExp(r'[^0-9]'), '');
    return numericString;
  }

  static String securityFormat(String value) {
    return value.replaceAll(RegExp(r'[0-9]'), '*');
  }
}

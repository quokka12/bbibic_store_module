import 'package:shared_preferences/shared_preferences.dart';

/** SharedPreferences를 관리하는 클래스
 *
 * 마지막 수정 : 2023-8-24 */
class MySharedPreferences {
  /// 저장소 가져오기
  static Future getData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (key) {
      case 'user':
      case 'cart':
        return prefs.getStringList('cart');
    }
  }

  /// 저장소에 데이터 저장
  static Future setData(String key, var obj) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (key) {
      case 'user':
      case 'cart':
        return prefs.setStringList('cart', obj);
    }
  }

  /// 저장소 비우기
  static Future delete() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// 저장소 특정 데이터 변경
  static Future update(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}

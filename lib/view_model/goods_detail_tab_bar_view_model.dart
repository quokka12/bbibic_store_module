import 'package:flutter/cupertino.dart';

class GoodsDetailTabBarViewModel with ChangeNotifier {
  bool firstPage = true;

  void changePage(){
    firstPage = !firstPage;
    notifyListeners();
  }
}
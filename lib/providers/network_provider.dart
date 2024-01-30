import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../theme/app_text_styles.dart';

class NetworkProvider with ChangeNotifier {
  bool isConnected = false;

  Future checkNetwork() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet) {
      isConnected = true;
    } else {
      isConnected = false;
      Fluttertoast.showToast(
        msg: "인터넷을 연결해주세요.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: AppTextStyles.B1,
      );
    }
    Logger().i("인터넷 연결 : $isConnected");
    notifyListeners();
    return isConnected;
  }
}

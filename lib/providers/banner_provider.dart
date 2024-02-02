import 'dart:io';

import 'package:bbibic_store/database/firebase/banner_firebase.dart';
import 'package:bbibic_store/models/ad_banner.dart';
import 'package:bbibic_store/util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../configs/router/route_names.dart';
import '../pakages/camera_pakage.dart';
import '../screens/widgets/loading_bar.dart';
import '../theme/app_text_styles.dart';

class BannerProvider with ChangeNotifier {
  File? banner = null;

  Future add(BuildContext context) async {
    AppLoadingBar.addDataLoading(context);
    AdBanner adBanner = AdBanner(bannerId: '',image: '',startDate: DateUtil.getToday());
    bool isSuccess = await BannerFirebase.add(context, adBanner, banner);
    if(isSuccess){
      clear();
      context.goNamed(RouteNames.bannerManagement);
    }
    notifyListeners();
  }

  Future delete(BuildContext context, String bannerId) async {
    AppLoadingBar.deleteDataLoading(context);
    bool isSuccess = await BannerFirebase.delete(context, bannerId)!;
    context.pop();
    if(isSuccess){
      Fluttertoast.showToast(
        msg: "삭제 완료.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: AppTextStyles.B1,
      );
      notifyListeners();
    }
    return isSuccess;
  }

  Future addBanner() async {
    banner = await CameraPakage.getImageNoCrop();
    notifyListeners();
  }
  void clear(){
    banner = null;
    notifyListeners();
  }

}
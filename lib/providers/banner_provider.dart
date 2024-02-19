import 'dart:io';

import 'package:bbibic_store/database/firebase/banner_firebase.dart';
import 'package:bbibic_store/models/ad_banner.dart';
import 'package:bbibic_store/util/date_util.dart';
import 'package:bbibic_store/util/toast_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../configs/router/route_names.dart';
import '../pakages/camera_pakage.dart';
import '../screens/widgets/loading_bar.dart';

class BannerProvider with ChangeNotifier {
  File? banner = null;
  List<AdBanner> bannerList = [];
  bool isGetted = false;

  Future<List<AdBanner>> getData(BuildContext context) async {
    return await BannerFirebase.getData(context);
  }

  void refresh(BuildContext context) {
    getData(context).then((bannerList) {
      this.bannerList = bannerList;
      isGetted = true;
      notifyListeners();
    });
  }

  BannerProvider(BuildContext context) {
    refresh(context);
  }

  Future add(BuildContext context) async {
    //예외처리
    if (banner == null) {
      ToastUtil.basic("사진을 추가해주세요");
      return;
    }

    AppLoadingBar.addDataLoading(context);

    AdBanner adBanner =
        AdBanner(bannerId: '', image: '', startDate: DateUtil.getToday());
    bool isSuccess = await BannerFirebase.add(context, adBanner, banner);

    if (isSuccess) {
      if (banner == null) {
        ToastUtil.basic("저장 완료");
        return;
      }
      clear();
      refresh(context);
      context.goNamed(RouteNames.bannerManagement);
    }
  }

  Future delete(BuildContext context, String bannerId) async {
    AppLoadingBar.deleteDataLoading(context);
    bool isSuccess = await BannerFirebase.delete(context, bannerId)!;
    context.pop();
    if (isSuccess) {
      ToastUtil.basic("삭제 완료");
      refresh(context);
    }
    return isSuccess;
  }

  Future addBanner() async {
    banner = await CameraPakage.getImageNoCrop();
    notifyListeners();
  }

  void clear() {
    banner = null;
    notifyListeners();
  }
}

import 'dart:io';

import 'package:bbibic_store/configs/router/route_names.dart';
import 'package:bbibic_store/providers/photo_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../database/firebase/goods_firebase.dart';
import '../models/goods.dart';
import '../screens/widgets/loading_bar.dart';
import '../theme/app_text_styles.dart';
import '../util/toast_util.dart';
import 'category_provider.dart';

class GoodsProvider with ChangeNotifier {
  Goods goods = Goods(status: true);

  Future add(BuildContext context, Goods goods, List<File?> thumbnailImageList,
      List<File?> detailImageList) async {
    //예외처리
    if (thumbnailImageList.isEmpty || detailImageList.isEmpty) {
      ToastUtil.basic("썸네일 혹은 상세이미지를 추가해주세요");
      return;
    }
    if (goods.categoryId == null || goods.categoryId!.isEmpty) {
      ToastUtil.basic("태그를 1개 이상 선택해주세요");
      return;
    }

    AppLoadingBar.addDataLoading(context);
    bool isSuccess = await GoodsFirebase.add(
        context, goods, thumbnailImageList, detailImageList);
    if (isSuccess) {
      Provider.of<CategoryProvider>(context, listen: false).clear();
      Provider.of<PhotoProvider>(context, listen: false).clear();
      context.goNamed(RouteNames.goodsManagement);
    }
    notifyListeners();
  }

  Future delete(BuildContext context, Goods goods) async {
    AppLoadingBar.deleteDataLoading(context);
    bool isSuccess = await GoodsFirebase.delete(context, goods)!;
    context.pop();
    if (isSuccess) {
      ToastUtil.basic("삭제 완료.");
      notifyListeners();
    }
    return isSuccess;
  }

  void changeStatus(BuildContext context, String goodsId, bool status) {
    AppLoadingBar.addDataLoading(context);
    GoodsFirebase.changeStatus(context, goodsId, status);
    context.pop();
    notifyListeners();
  }

  void set(Goods goods) {
    this.goods = goods;
    notifyListeners();
  }

  void clear() {
    goods = Goods(status: true);
    notifyListeners();
  }
}

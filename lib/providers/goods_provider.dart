import 'dart:io';

import 'package:bbibic_store/configs/router/route_names.dart';
import 'package:bbibic_store/providers/photo_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../database/firebase/goods_firebase.dart';
import '../models/goods.dart';
import '../screens/widgets/loading_bar.dart';
import '../theme/app_text_styles.dart';
import 'category_provider.dart';

class GoodsProvider with ChangeNotifier {
  Goods goods = Goods(status: true);

  Future add(BuildContext context, Goods goods, List<File?> thumbnailImageList,
      List<File?> detailImageList) async {
    AppLoadingBar.addDataLoading(context);
    bool isSuccess = await GoodsFirebase.add(context, goods, thumbnailImageList, detailImageList);
    if(isSuccess){
      Provider.of<CategoryProvider>(context,listen: false).clear();
      Provider.of<PhotoProvider>(context,listen: false).clear();
      context.goNamed(RouteNames.goodsManagement);
    }
    notifyListeners();
  }

  Future deleted(BuildContext context, Goods goods) async {
    AppLoadingBar.deleteDataLoading(context);
    bool isSuccess = await GoodsFirebase.delete(context, goods)!;
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
  void changeStatus(BuildContext context, String goodsId,bool status){
    AppLoadingBar.addDataLoading(context);
    GoodsFirebase.changeStatus(context, goodsId, status);
    context.pop();
    notifyListeners();
  }
  void set(Goods goods){
    this.goods = goods;
    notifyListeners();
  }
  void clear(){
    goods = Goods(status: true);
    notifyListeners();
  }
}
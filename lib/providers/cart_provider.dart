import 'package:bbibic_store/database/firebase/goods_firebase.dart';
import 'package:bbibic_store/database/shared_preferences/my_shared_preferences.dart';
import 'package:bbibic_store/models/goods.dart';
import 'package:bbibic_store/theme/app_text_styles.dart';
import 'package:bbibic_store/util/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../configs/router/route_names.dart';
import '../models/cart.dart';

class CartProvider with ChangeNotifier {
  List<String> goodsIdList = [];
  List<Goods> goodsList = [];
  List<Cart> cartList = [];
  int totalPrice = 0;
  int totalCount = 0;

  void changeCount(int index, int count) {
    cartList[index].count = count;
    getSelectedItemCount();
    getSelectedItemPrice();
    notifyListeners();
  }

  void changeIsSelected(int index) {
    cartList[index].isSelected = !cartList[index].isSelected;
    getSelectedItemCount();
    getSelectedItemPrice();
    notifyListeners();
  }

  void deleteItem(int index) {
    goodsIdList.removeAt(index);
    goodsList.removeAt(index);
    cartList.removeAt(index);
    MySharedPreferences.setData("cart", goodsIdList);
    getSelectedItemCount();
    getSelectedItemPrice();
    notifyListeners();
  }

  void getSelectedItemCount() {
    int total = 0;
    for (Cart cart in cartList) {
      if (cart.isSelected) {
        total += cart.count;
      }
    }
    totalCount = total;
  }

  void getSelectedItemPrice() {
    int total = 0;
    for (Cart cart in cartList) {
      if (cart.isSelected) {
        total += cart.goodsPrice * cart.count;
      }
    }
    totalPrice = total;
  }

  Future add(BuildContext context, Goods goods) async {
    if (goodsIdList.contains(goods.goodsId)) {
      ToastUtil.basic("해당 상품이 이미 장바구니에 존재합니다.");
      return;
    }
    goodsList.add(goods);
    goodsIdList.add(goods.goodsId!);
    MySharedPreferences.setData("cart", goodsIdList);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("해당 상품을 장바구니에 담았어요.", style: AppTextStyles.whiteColorB2),
        action: SnackBarAction(
          label: '장바구니로 이동',
          onPressed: () {
            getData(context);
            context.pushNamed(RouteNames.cart);
          },
        ),
      ),
    );

    notifyListeners();
  }

  Future getData(BuildContext context) async {
    goodsIdList = await MySharedPreferences.getData("cart") ?? [];
    List<Goods> tempLIst = [];
    List<Cart> cartTempLIst = [];
    for (String goodsId in goodsIdList) {
      tempLIst.add(await GoodsFirebase.getDataEqualUID(context, goodsId));
    }
    goodsList = tempLIst;
    for (Goods goods in goodsList) {
      cartTempLIst.add(Cart(goods.goodsId!, goods.goodsPrice!, 0, false));
    }
    cartList = cartTempLIst;
    notifyListeners();
  }

  void clear() {
    goodsIdList = [];
    goodsList = [];
    cartList = [];
    totalPrice = 0;
    totalCount = 0;
    notifyListeners();
  }
}

import 'package:bbibic_store/providers/address_provider.dart';
import 'package:bbibic_store/providers/banner_provider.dart';
import 'package:bbibic_store/providers/cart_provider.dart';
import 'package:bbibic_store/providers/category_provider.dart';
import 'package:bbibic_store/providers/goods_provider.dart';
import 'package:bbibic_store/theme/app_colors.dart';
import 'package:bbibic_store/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/goods.dart';

class MyDialog {
  MyDialog._();
  static void basicDialog(BuildContext context, String content,
      String colorMenuText, Function()? onTap) {
    showDialog(
      context: context,
      barrierDismissible: false, //바깥 영역 터치시 닫을지 여부 결정
      builder: ((context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 148,
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                    flex: 7,
                    child: Text(content, style: AppTextStyles.blackColorB1)),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColors.grey200,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child:
                                  Text('취소', style: AppTextStyles.blackColorB1),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: onTap,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.bbibic,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(colorMenuText,
                                  style: AppTextStyles.blackColorB1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  static void categoryDeleteDialog(BuildContext context,
      CategoryProvider categoryProvider, String categoryName) {
    showDialog(
      context: context,
      barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
      builder: ((context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 148,
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Text("#$categoryName",
                          style: AppTextStyles.blackColorB1Bold),
                      Text("카테고리를 삭제하시겠습니까?", style: AppTextStyles.blackColorB1)
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.grey200,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child:
                                  Text('취소', style: AppTextStyles.blackColorB1),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              categoryProvider
                                  .deleted(context, categoryName)
                                  .then((value) {
                                if (value) {
                                  Fluttertoast.showToast(
                                    msg: "삭제 완료.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    fontSize: AppTextStyles.B1,
                                  );
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.bbibic,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child:
                                  Text("삭제", style: AppTextStyles.whiteColorB1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  static void goodsDeleteDialog(
      BuildContext context1, GoodsProvider goodsProvider, Goods goods) {
    showDialog(
      context: context1,
      barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
      builder: ((context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 148,
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Text("해당 상품을 삭제하시겠습니까?",
                          style: AppTextStyles.blackColorB1)
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.grey200,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child:
                                  Text('취소', style: AppTextStyles.blackColorB1),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              goodsProvider.delete(context1, goods);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.bbibic,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child:
                                  Text("삭제", style: AppTextStyles.whiteColorB1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  static void bannerDeleteDialog(
      BuildContext context1, BannerProvider bannerProvider, String bannerId) {
    showDialog(
      context: context1,
      barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
      builder: ((context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 148,
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Text("해당 배너를 삭제하시겠습니까?",
                          style: AppTextStyles.blackColorB1)
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.grey200,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child:
                                  Text('취소', style: AppTextStyles.blackColorB1),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              bannerProvider.delete(
                                context1,
                                bannerId,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.bbibic,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child:
                                  Text("삭제", style: AppTextStyles.whiteColorB1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  static void cartItemDeleteDialog(
      BuildContext context1, CartProvider cartProvider, int i) {
    showDialog(
      context: context1,
      barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
      builder: ((context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 148,
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("해당 상품을 장바구니에서",
                            style: AppTextStyles.blackColorB1),
                        Text("삭제하시겠습니까?", style: AppTextStyles.blackColorB1),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.grey200,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child:
                                  Text('취소', style: AppTextStyles.blackColorB1),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              cartProvider.deleteItem(context1, i);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.bbibic,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child:
                                  Text("삭제", style: AppTextStyles.whiteColorB1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  static void addressDeleteDialog(BuildContext context1,
      AddressProvider addressProvider, String addressId) {
    showDialog(
      context: context1,
      barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
      builder: ((context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 148,
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Text("해당 배송지를 삭제하시겠습니까?",
                        style: AppTextStyles.blackColorB1),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.grey200,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child:
                                  Text('취소', style: AppTextStyles.blackColorB1),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              addressProvider.delete(context1, addressId);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.bbibic,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child:
                                  Text("삭제", style: AppTextStyles.whiteColorB1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

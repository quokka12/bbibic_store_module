import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../configs/router/route_names.dart';
import '../../../models/cart.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/goods_provider.dart';
import '../../../providers/order_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_decorations.dart';
import '../../../theme/app_text_styles.dart';

class GoodsDetailButtonWidget extends StatelessWidget {
  const GoodsDetailButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final goodsProvider = Provider.of<GoodsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                decoration: AppDecorations.buttonDecoration(AppColors.bbibic),
                child: MaterialButton(
                  onPressed: () {
                    orderProvider.setOrderCart([
                      Cart(
                        goodsProvider.goods.goodsId!,
                        goodsProvider.goods.goodsName!,
                        goodsProvider.goods.thumbnailImages![0],
                        goodsProvider.goods.goodsPrice!,
                        0,
                        true,
                      ),
                    ]);
                    context.pushNamed(RouteNames.payment);
                  },
                  child: Text("구매하기", style: AppTextStyles.whiteColorB1),
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              height: 48,
              decoration: AppDecorations.buttonDecoration(AppColors.black),
              child: MaterialButton(
                onPressed: () => cartProvider.add(context, goodsProvider.goods),
                child: Text("장바구니", style: AppTextStyles.whiteColorB1),
              ),
            ),
          ],
        ));
  }
}

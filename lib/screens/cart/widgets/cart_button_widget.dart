import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_decorations.dart';
import '../../../theme/app_text_styles.dart';
import '../../../util/format_util.dart';

class CartButtonWidget extends StatelessWidget {
  const CartButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text("총 결제 예상 금액", style: AppTextStyles.blackColorB2),
                const Spacer(),
                Text(FormatUtil.priceFormat(cartProvider.totalPrice),
                    style: AppTextStyles.blackColorH1Bold),
              ],
            ),
          ),
          Container(
            height: 48,
            width: double.infinity,
            decoration: AppDecorations.buttonDecoration(AppColors.bbibic),
            child: MaterialButton(
              onPressed: () {},
              child: Text("구매하기(${cartProvider.totalCount})",
                  style: AppTextStyles.whiteColorB1),
            ),
          ),
        ],
      ),
    );
  }
}

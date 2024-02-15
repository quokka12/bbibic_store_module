import 'package:bbibic_store/screens/widgets/my_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../models/goods.dart';
import '../../providers/cart_provider.dart';
import '../../providers/goods_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_decorations.dart';
import '../../theme/app_text_styles.dart';
import '../../util/format_util.dart';
import '../widgets/my_app_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar.basicAppBar(
              context,
              '장바구니',
              () {
                cartProvider.clear();
                context.pop();
              },
            ),
            _itemListHelper(cartProvider),
            _buttonHelper(cartProvider),
          ],
        ),
      ),
    );
  }

  Widget _itemListHelper(CartProvider cartProvider) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              if (cartProvider.goodsList != null) ...[
                for (int i = 0; i < cartProvider.goodsList.length; i++) ...[
                  _cardHelper(cartProvider, cartProvider.goodsList[i], i),
                ]
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardHelper(CartProvider cartProvider, Goods goods, int i) {
    final List<String> items = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: AppDecorations.buttonDecoration(Colors.white),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              goods.thumbnailImages![0],
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${goods.goodsName}",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.blackColorS2Bold),
                    Text("${FormatUtil.priceFormat(goods.goodsPrice!)}원",
                        style: AppTextStyles.blackColorB2),
                    Row(
                      children: [
                        if (goods.categoryId != null) ...[
                          for (String category in goods.categoryId!) ...[
                            Text(" #${category}",
                                style: AppTextStyles.grey600ColorC1),
                          ]
                        ]
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: cartProvider.cartList[i].isSelected,
                      onChanged: (value) => cartProvider.changeIsSelected(i),
                    ),
                    Container(
                      width: 76,
                      child: DropdownButtonFormField2<String>(
                        value: "${cartProvider.cartList[i].count}",
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        hint: Text('0', style: AppTextStyles.blackColorS2Bold),
                        items: items
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: AppTextStyles.blackColorS2Bold,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            cartProvider.changeCount(i, int.parse(value!)),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.only(right: 8),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 24,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            IconButton(
              onPressed: () =>
                  MyDialog.cartItemDeleteDialog(context, cartProvider, i),
              icon: Icon(Icons.delete_outline_rounded),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonHelper(CartProvider cartProvider) {
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
                Spacer(),
                Text(FormatUtil.priceFormat(cartProvider.totalPrice),
                    style: AppTextStyles.blackColorH1Bold),
                Text("원", style: AppTextStyles.blackColorB2),
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

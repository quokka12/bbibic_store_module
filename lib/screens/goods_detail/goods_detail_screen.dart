import 'package:bbibic_store/screens/goods_detail/widgets/goods_detail_button_widget.dart';
import 'package:bbibic_store/screens/goods_detail/widgets/goods_detail_info_widget.dart';
import 'package:bbibic_store/screens/goods_detail/widgets/goods_detail_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/goods_provider.dart';
import '../widgets/my_app_bar.dart';

class GoodsDetailScreen extends StatefulWidget {
  const GoodsDetailScreen({Key? key}) : super(key: key);

  @override
  State<GoodsDetailScreen> createState() => _GoodsDetailScreenState();
}

class _GoodsDetailScreenState extends State<GoodsDetailScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final goodsProvider = Provider.of<GoodsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar.oneMenuAppBar(context, "상품 상세정보", () {
              goodsProvider.clear();
              Navigator.pop(context);
            }, Icon(Icons.favorite_border, size: 28), () {}),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GoodsDetailInfoWidget(),
                    SizedBox(height: 12),
                    GoodsDetailTabBar(),
                  ],
                ),
              ),
            ),
            const GoodsDetailButtonWidget(),
          ],
        ),
      ),
    );
  }
}

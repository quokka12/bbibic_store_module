import 'package:bbibic_store/screens/cart/widgets/cart_button_widget.dart';
import 'package:bbibic_store/screens/cart/widgets/cart_item_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
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
            const CartItemListWidget(),
            const CartButtonWidget(),
          ],
        ),
      ),
    );
  }
}

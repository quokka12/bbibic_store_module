import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../configs/router/route_names.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      height: 56,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _searchBarHelper(context),
          const SizedBox(width: 12),
          _menuButtonHelper(context),
        ],
      ),
    );
  }

  Widget _searchBarHelper(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.pushNamed(RouteNames.goodsSearch);
        }, //,
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.center,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.grey200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "원하시는 상품이 있으신가요?",
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.grey600ColorC1,
                ),
                const Icon(
                  Icons.search_rounded,
                  size: 24,
                  color: AppColors.grey800,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuButtonHelper(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(RouteNames.cart);
          },
          child: const Icon(Icons.shopping_cart_outlined, size: 24),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => context.goNamed(RouteNames.myInfo),
          child: const Icon(Icons.person_outlined, size: 24),
        ),
      ],
    );
  }
}

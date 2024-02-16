import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class MyAppBar {
  MyAppBar._();
  static Widget basicAppBar(
      BuildContext context, String title, Function()? onPressed) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 52,
            child: IconButton(
              onPressed: onPressed ?? () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 24),
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.blackColorS1,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 52),
        ],
      ),
    );
  }

  static Widget oneMenuAppBar(BuildContext context, String title,
      Function()? onBackPressed, Widget icon, Function()? onPressed) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 52,
            child: IconButton(
              onPressed: onBackPressed ?? () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 24),
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.blackColorS1,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 8, top: 4),
            width: 52,
            child: IconButton(
              onPressed: onPressed ?? () => Navigator.pop(context),
              icon: icon,
            ),
          ),
        ],
      ),
    );
  }
}

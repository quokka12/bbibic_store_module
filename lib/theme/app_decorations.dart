import 'package:flutter/material.dart';

import 'app_colors.dart';


class AppDecorations {
  AppDecorations._();

  static BoxDecoration buttonDecoration(Color? color){
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: AppColors.grey200,offset: Offset(2,2))
      ]
    );
  }
  static BoxDecoration tagDecoration() {
    return BoxDecoration(
      color: AppColors.grey150,
      border: Border.all(color: Colors.transparent, width: 1),
      borderRadius: BorderRadius.circular(8),
    );
  }

  static BoxDecoration selectedTagDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: AppColors.black, width: 1),
      borderRadius: BorderRadius.circular(8),
    );
  }
}

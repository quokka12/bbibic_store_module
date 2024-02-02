import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class PhotoComponent{
  PhotoComponent._();
  static Widget imageHelper(url) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: SizedBox(
        height: 150,
        width: 150,
        child: Image.file(File(url!.path), fit: BoxFit.fitHeight),
      ),
    );
  }

  static Widget photoRemoveInfoHelper() {
    return  Container(
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            size: 16,
            color: AppColors.grey600,
          ),
          const SizedBox(width: 4),
          Text(
            "추가한 사진은 터치해서 삭제할 수 있어요!",
            style: AppTextStyles.grey600ColorB2,
          ),
        ],
      ),
    );
  }
}

import 'package:bbibic_store/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoadingBar {
  AppLoadingBar._();
  static void addDataLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            content: Container(
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/loading.json',
                    height: 130,
                    fit: BoxFit.contain,
                  ),
                  Text("데이터를 저장하고 있어요", style: AppTextStyles.blackColorB2Bold),
                ],
              ),
            ),
          );
        });
  }

  static void deleteDataLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            content: Container(
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/loading.json',
                    height: 130,
                    fit: BoxFit.contain,
                  ),
                  Text("데이터를 삭제하고 있어요", style: AppTextStyles.blackColorB2Bold),
                ],
              ),
            ),
          );
        });
  }
}

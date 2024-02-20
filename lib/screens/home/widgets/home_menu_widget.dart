import 'package:bbibic_store/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../configs/router/route_names.dart';
import '../../../theme/app_assets.dart';
import '../../../theme/app_text_styles.dart';

class HomeMenuWidget extends StatelessWidget {
  HomeMenuWidget({super.key});

  List<Map> menuList = [
    {"image": AppAssets.imageMedicine, "title": "영양제"},
    {"image": AppAssets.imageCream, "title": "영양크림"},
    {"image": AppAssets.imageMask, "title": "위생용품"},
    {"image": AppAssets.imageMedicalEquipment, "title": "의료기기"},
    {"image": AppAssets.imageInterior, "title": "인테리어"},
  ];

  @override
  Widget build(BuildContext context) {
    List<Function()?> onTapPage = [
      () {
        context.push("/${RouteNames.goodsList}/asd/인기순");
      },
      () {
        context.push("/${RouteNames.goodsList}/asd/인기순");
      },
      () {
        context.push("/${RouteNames.goodsList}/asd/인기순");
      },
      () {
        context.push("/${RouteNames.goodsList}/asd/인기순");
      },
      () {
        context.push("/${RouteNames.goodsList}/asd/인기순");
      },
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < menuList.length; i++) ...[
            Expanded(
              child: GestureDetector(
                onTap: onTapPage[i],
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.grey150,
                          borderRadius: BorderRadius.circular(12)),
                      child: Image.asset(
                        menuList[i]["image"],
                        width: 36,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      menuList[i]["title"],
                      style: AppTextStyles.grey800ColorB1,
                    ),
                  ],
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

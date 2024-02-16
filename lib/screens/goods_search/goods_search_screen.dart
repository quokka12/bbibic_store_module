import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../configs/router/route_names.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class GoodsSearchScreen extends StatelessWidget {
  GoodsSearchScreen({super.key});
  List<String> searchs = ['칼슘', '영양제', '유산균', '비타민D', '눈건강', '간건강'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 52,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 48,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 24),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "원하시는 상품이 있으신가요?",
                            hintStyle: AppTextStyles.grey600ColorB2,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push("/${RouteNames.goodsList}/asd/최신순");
                        // context.pushNamed(RouteNames.goodsList,
                        //     queryParameters: {
                        //       'searchWord': 'asd',
                        //       'filter': '최신순'
                        //     });
                      },
                      child: const Icon(
                        Icons.search_rounded,
                        size: 28,
                        color: AppColors.grey800,
                      ),
                    ),
                    SizedBox(width: 12),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("최근 검색어", style: AppTextStyles.blackColorB2Bold),
                        Text("전체삭제", style: AppTextStyles.grey600ColorC1),
                      ],
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 8,
                      children: [
                        for (String content in searchs) ...[
                          Container(
                            padding: EdgeInsets.only(
                                left: 8, top: 4, right: 4, bottom: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  width: 1, color: AppColors.grey600),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      content,
                                      style: AppTextStyles.grey600ColorC1,
                                    ),
                                    SizedBox(width: 8),
                                  ],
                                ),
                                Icon(Icons.close,
                                    size: 20, color: AppColors.grey600)
                              ],
                            ),
                          )
                        ]
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

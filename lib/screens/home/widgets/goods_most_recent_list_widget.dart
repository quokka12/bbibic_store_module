import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../configs/router/route_names.dart';
import '../../../providers/goods_provider.dart';
import '../../../theme/app_assets.dart';
import '../../../theme/app_text_styles.dart';
import '../../../util/format_util.dart';
import 'goods_loading_widget.dart';

class GoodsMostRecentListWidget extends StatelessWidget {
  const GoodsMostRecentListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Colors.white,
      child: Column(
        children: [
          _titleHelper(context),
          const SizedBox(height: 12),
          _goodsListHelper(context),
        ],
      ),
    );
  }

  Widget _titleHelper(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      alignment: Alignment.bottomLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(AppAssets.imageNew, width: 32, fit: BoxFit.contain),
              const SizedBox(width: 8),
              Text("삐빅샵 새로 나온 상품", style: AppTextStyles.blackColorS1Bold),
            ],
          ),
          GestureDetector(
            onTap: () {
              context.push("/${RouteNames.goodsList}/asd/최신순");
            },
            child: Row(
              children: [
                Text("더보기", style: AppTextStyles.blackColorB2),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward_rounded, size: 20),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _goodsListHelper(BuildContext context) {
    final goodsProvider = Provider.of<GoodsProvider>(context);
    return !goodsProvider.isGetted
        ? const GoodsLoadingWidget()
        : goodsProvider.mostRecentGoodsList.isEmpty
            ? _noDataHelper()
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    for (int i = 0;
                        i < goodsProvider.mostRecentGoodsList.length;
                        i++) ...[
                      GestureDetector(
                        onTap: () {
                          goodsProvider
                              .set(goodsProvider.mostRecentGoodsList[i]);
                          context.pushNamed(RouteNames.goodsDetail);
                        },
                        child: SizedBox(
                          width: 160,
                          child: Column(
                            children: [
                              Image.network(
                                goodsProvider
                                    .mostRecentGoodsList[i].thumbnailImages![0],
                                width: 120,
                                height: 120,
                                fit: BoxFit.contain,
                                loadingBuilder: (context, Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Text(
                                "${goodsProvider.mostRecentGoodsList[i].goodsName}",
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.blackColorB1,
                              ),
                              Text(
                                FormatUtil.priceFormat(goodsProvider
                                    .mostRecentGoodsList[i].goodsPrice!),
                                style: AppTextStyles.blackColorB2Bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ]
                  ],
                ),
              );
  }

  Widget _noDataHelper() {
    return Column(
      children: [
        Text(
          "곧 새로운 상품이 등록될 예정이에요!",
          style: AppTextStyles.grey600ColorB2,
        ),
        Text(
          "조금만 기다려주세요~",
          style: AppTextStyles.grey600ColorB2,
        ),
      ],
    );
  }
}

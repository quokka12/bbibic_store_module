import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../providers/goods_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_sizes.dart';
import '../../../theme/app_text_styles.dart';
import '../../../util/format_util.dart';
import '../../widgets/category_widget.dart';

class GoodsDetailInfoWidget extends StatelessWidget {
  const GoodsDetailInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final goodsProvider = Provider.of<GoodsProvider>(context);
    return Column(
      children: [
        _thumbnailHelper(context, goodsProvider),
        Container(
          padding: EdgeInsets.only(left: 20, top: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            "${goodsProvider.goods.goodsName}",
            style: AppTextStyles.blackColorH2Bold,
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          child: Text(
            FormatUtil.priceFormat(goodsProvider.goods.goodsPrice ?? 0),
            style: AppTextStyles.blackColorS1,
          ),
        ),
        _tagHelper(context, goodsProvider),
      ],
    );
  }

  Widget _thumbnailHelper(BuildContext context, GoodsProvider goodsProvider) {
    return SizedBox(
      width: AppSizes.ratioOfHorizontal(context, 1),
      height: AppSizes.ratioOfHorizontal(context, 1),
      child: AnotherCarousel(
        autoplay: false,
        dotSize: 8,
        dotColor: AppColors.grey300,
        dotIncreasedColor: AppColors.bbibic,
        dotBgColor: Colors.transparent,
        images: [
          if (goodsProvider.goods.thumbnailImages != null) ...[
            for (int i = 0;
                i < goodsProvider.goods.thumbnailImages!.length;
                i++)
              Image.network(
                goodsProvider.goods.thumbnailImages![i],
                fit: BoxFit.fill,
                loadingBuilder:
                    (context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: AppSizes.ratioOfHorizontal(context, 1),
                      height: AppSizes.ratioOfHorizontal(context, 1),
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                  );
                },
              ),
          ]
        ],
      ),
    );
  }

  Widget _tagHelper(BuildContext context, GoodsProvider goodsProvider) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 12),
      child: Row(
        children: [
          Text("관련태그", style: AppTextStyles.blackColorS2Bold),
          SizedBox(width: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if (goodsProvider.goods.categoryId != null) ...[
                    for (int i = 0;
                        i < goodsProvider.goods.categoryId!.length;
                        i++) ...[
                      categoryCard(goodsProvider.goods.categoryId![i])
                    ]
                  ]
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

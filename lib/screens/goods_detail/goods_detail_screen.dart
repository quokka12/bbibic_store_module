import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:bbibic_store/screens/goods_detail/widgets/goods_detail_tab_bar.dart';
import 'package:bbibic_store/theme/app_colors.dart';
import 'package:bbibic_store/theme/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../providers/cart_provider.dart';
import '../../providers/goods_provider.dart';
import '../../theme/app_decorations.dart';
import '../../theme/app_text_styles.dart';
import '../../util/format_util.dart';
import '../widgets/my_app_bar.dart';

class GoodsDetailScreen extends StatefulWidget {
  const GoodsDetailScreen({Key? key}) : super(key: key);

  @override
  State<GoodsDetailScreen> createState() => _GoodsDetailScreenState();
}

class _GoodsDetailScreenState extends State<GoodsDetailScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final goodsProvider = Provider.of<GoodsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getData(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          MyAppBar.basicAppBar(context, "상품 상세정보", () {
            goodsProvider.clear();
            Navigator.pop(context);
          }),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _goodsInfoHelper(goodsProvider),
                  const SizedBox(height: 12),
                  const GoodsDetailTabBar(),
                ],
              ),
            ),
          ),
          _buttonHelper(goodsProvider, cartProvider),
        ]),
      ),
    );
  }

  Widget _goodsInfoHelper(GoodsProvider goodsProvider) {
    return Column(
      children: [
        SizedBox(
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
                    loadingBuilder: (context, Widget child,
                        ImageChunkEvent? loadingProgress) {
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
        ),
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
            "${FormatUtil.priceFormat(goodsProvider.goods.goodsPrice!)}원",
            style: AppTextStyles.blackColorS1,
          ),
        ),
        Padding(
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
                          _categoryCard(goodsProvider.goods.categoryId![i])
                        ]
                      ]
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoryCard(String name) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: UnconstrainedBox(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: AppDecorations.tagDecoration(),
          child: Text("#$name", style: AppTextStyles.blackColorB1),
        ),
      ),
    );
  }

  Widget _buttonHelper(GoodsProvider goodsProvider, CartProvider cartProvider) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                decoration: AppDecorations.buttonDecoration(AppColors.bbibic),
                child: MaterialButton(
                  onPressed: () {},
                  child: Text("구매하기", style: AppTextStyles.whiteColorB1),
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              height: 48,
              decoration: AppDecorations.buttonDecoration(AppColors.black),
              child: MaterialButton(
                onPressed: () => cartProvider.add(context, goodsProvider.goods),
                child: Text("장바구니", style: AppTextStyles.whiteColorB1),
              ),
            ),
          ],
        ));
  }
}

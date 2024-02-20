import 'package:bbibic_store/screens/goods_list/widgets/goods_list_search_app_bar.dart';
import 'package:bbibic_store/theme/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../configs/router/route_names.dart';
import '../../models/goods.dart';
import '../../providers/goods_provider.dart';
import '../../theme/app_decorations.dart';
import '../../theme/app_text_styles.dart';
import '../../util/format_util.dart';

class GoodsListScreen extends StatelessWidget {
  String searchWord = '';
  String filter = '최신순';
  GoodsListScreen({super.key, required this.searchWord, required this.filter});

  @override
  Widget build(BuildContext context) {
    final GoodsProvider goodsProvider = Provider.of<GoodsProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              GoodsListSearchAppBar(searchWord: searchWord, filter: filter),
              !goodsProvider.isGetted
                  ? const SizedBox()
                  : goodsProvider.mostRecentGoodsList.isEmpty
                      ? _comingSoonHelper()
                      : Expanded(
                          child: goodsListHelper(context, goodsProvider)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _comingSoonHelper() {
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

  Widget goodsListHelper(BuildContext context, GoodsProvider goodsProvider) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const SizedBox(height: 4),
          for (Goods goods in goodsProvider.mostRecentGoodsList) ...[
            goodsCardHelper(context, goodsProvider, goods),
            const SizedBox(width: 16),
          ]
        ],
      ),
    );
  }

  Widget goodsCardHelper(
      BuildContext context, GoodsProvider goodsProvider, Goods goods) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: () {
          goodsProvider.set(goods);
          context.pushNamed(RouteNames.goodsDetail);
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: AppDecorations.buttonDecoration(Colors.white),
          width: AppSizes.ratioOfHorizontal(context, 1) - 16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                goods.thumbnailImages![0],
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: AppSizes.ratioOfHorizontal(context, 1) - 164,
                    child: Text(
                      "${goods.goodsName}",
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.blackColorB2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    FormatUtil.priceFormat(goods.goodsPrice!),
                    style: AppTextStyles.blackColorB1Bold,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      for (String tag in goods.categoryId!) ...[
                        Text("#$tag", style: AppTextStyles.grey600ColorC1),
                        const SizedBox(width: 4),
                      ],
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

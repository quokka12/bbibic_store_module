import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../providers/goods_provider.dart';
import '../../../../theme/app_decorations.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../../util/format_util.dart';
import '../../../widgets/my_dialog.dart';

class GoodsListWidget extends StatelessWidget {
  const GoodsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoodsProvider goodsProvider = Provider.of<GoodsProvider>(context);
    return !goodsProvider.isGetted
        ? _loadingHelper()
        : goodsProvider.mostRecentGoodsList == []
            ? _noDataHelper()
            : Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        for (int i = 0;
                            i < goodsProvider.goodsList.length;
                            i++) ...[
                          _itemCard(context, goodsProvider, i),
                          const SizedBox(height: 12),
                        ]
                      ],
                    ),
                  ),
                ),
              );
  }

  Widget _noDataHelper() {
    return Center(child: Text('데이터가 없습니다.', style: AppTextStyles.blackColorH1));
  }

  Widget _loadingHelper() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (int i = 0; i < 5; i++) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: AppDecorations.buttonDecoration(Colors.white),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 80,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 120,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 90,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 70,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: 60,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(height: 58),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _itemCard(BuildContext context, GoodsProvider goodsProvider, int i) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: AppDecorations.buttonDecoration(Colors.white),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                Image.network(
                  goodsProvider.goodsList[i].thumbnailImages![0],
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${goodsProvider.goodsList[i].goodsName}",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.blackColorB1Bold,
                      ),
                      Text(
                        FormatUtil.priceFormat(
                            goodsProvider.goodsList[i].goodsPrice!),
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.blackColorB1,
                      ),
                      Text(
                        goodsProvider.goodsList[i].status ? "판매중" : "판매정지",
                        overflow: TextOverflow.ellipsis,
                        style: goodsProvider.goodsList[i].status
                            ? AppTextStyles.blueColorB1
                            : AppTextStyles.redColorB1,
                      ),
                      Text(
                        "판매 수량 : ${goodsProvider.goodsList[i].goodsSell}",
                        style: AppTextStyles.blackColorB1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "조회 수 : ${goodsProvider.goodsList[i].views}",
                        style: AppTextStyles.blackColorB1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${goodsProvider.goodsList[i].createdDate}",
                        style: AppTextStyles.grey600ColorB2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "판매 여부",
                        style: AppTextStyles.blackColorB1Bold,
                      ),
                      Switch(
                        activeColor: Colors.blueAccent,
                        value: goodsProvider.goodsList[i].status,
                        onChanged: (value) => goodsProvider.changeStatus(
                            context,
                            goodsProvider.goodsList[i].goodsId!,
                            !goodsProvider.goodsList[i].status),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: AppDecorations.buttonDecoration(Colors.redAccent),
            child: MaterialButton(
              onPressed: () => MyDialog.goodsDeleteDialog(
                context,
                goodsProvider,
                goodsProvider.goodsList[i],
              ),
              child: Text("상품 삭제", style: AppTextStyles.whiteColorB2),
            ),
          ),
        ],
      ),
    );
  }
}

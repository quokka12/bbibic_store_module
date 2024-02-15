import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../database/firebase/goods_firebase.dart';
import '../../../../models/goods.dart';
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
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: FutureBuilder<List<Goods>>(
                future: GoodsFirebase.getData(context),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Goods>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _loadingHelper();
                  }

                  if (snapshot.hasError) {
                    // 에러 발생 시의 UI 처리
                    return Text('에러 발생: ${snapshot.error}');
                  }

                  List<Goods>? goodsList = snapshot.data;
                  if (snapshot.data == null ||
                      goodsList == null ||
                      goodsList.isEmpty) {
                    return _noDataHelper();
                  }

                  // TODO: 받아온 데이터를 활용한 UI 구성 및 반환 처리
                  return _dataListHelper(context, goodsProvider, goodsList);
                })),
      ),
    );
  }

  Widget _noDataHelper() {
    return Center(child: Text('데이터가 없습니다.', style: AppTextStyles.blackColorH1));
  }

  Widget _loadingHelper() {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
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
      ),
    );
  }

  Widget _dataListHelper(BuildContext context, GoodsProvider goodsProvider,
      List<Goods> goodsList) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            for (int i = 0; i < goodsList!.length; i++) ...[
              _itemCard(context, goodsProvider, goodsList, i),
              const SizedBox(height: 12),
            ]
          ],
        ),
      ),
    );
  }

  Widget _itemCard(BuildContext context, GoodsProvider goodsProvider,
      List<Goods> goodsList, int i) {
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
                  goodsList[i].thumbnailImages![0],
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
                        "${goodsList[i].goodsName}",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.blackColorB1Bold,
                      ),
                      Text(
                        "${FormatUtil.priceFormat(goodsList[i].goodsPrice!)}원",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.blackColorB1,
                      ),
                      Text(
                        goodsList[i].status ? "판매중" : "판매정지",
                        overflow: TextOverflow.ellipsis,
                        style: goodsList[i].status
                            ? AppTextStyles.blueColorB1
                            : AppTextStyles.redColorB1,
                      ),
                      Text(
                        "판매 수량 : ${goodsList[i].goodsSell}",
                        style: AppTextStyles.blackColorB1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "조회 수 : ${goodsList[i].views}",
                        style: AppTextStyles.blackColorB1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${goodsList[i].createdDate}",
                        style: AppTextStyles.grey600ColorB2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "판매 여부",
                        style: AppTextStyles.blackColorB1Bold,
                      ),
                      Switch(
                        activeColor: Colors.blueAccent,
                        value: goodsList[i].status,
                        onChanged: (value) => goodsProvider.changeStatus(
                            context,
                            goodsList[i].goodsId!,
                            !goodsList[i].status),
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
                goodsList[i],
              ),
              child: Text("상품 삭제", style: AppTextStyles.whiteColorB2),
            ),
          ),
        ],
      ),
    );
  }
}

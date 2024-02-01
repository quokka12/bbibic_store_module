import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../providers/goods_provider.dart';
import '../../../theme/app_sizes.dart';

class GoodsDetailImageWidget extends StatelessWidget {
  const GoodsDetailImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoodsProvider goodsProvider = Provider.of<GoodsProvider>(context);
    return Column(
        children: [
          if(goodsProvider.goods.detailImages != null)...[
            for(int i = 0; i< goodsProvider.goods.detailImages!.length;i++)
              Image.network(goodsProvider.goods.detailImages![i],
                width: AppSizes.ratioOfHorizontal(context, 1),
                fit: BoxFit.fitWidth,
                loadingBuilder: (context, Widget child, ImageChunkEvent? loadingProgress) {
                  if(loadingProgress == null){
                    return child;
                  }
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child:
                      Container(
                        width: double.infinity,
                        height: 1000,
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                      ),
                    );
                },
              ),
          ],
        ],
    );
  }
}

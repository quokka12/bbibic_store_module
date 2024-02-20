import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../models/ad_banner.dart';
import '../../../../providers/banner_provider.dart';
import '../../../../theme/app_decorations.dart';
import '../../../../theme/app_sizes.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../widgets/my_dialog.dart';

class BannerListWidget extends StatelessWidget {
  const BannerListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bannerProvider = Provider.of<BannerProvider>(context);
    return bannerProvider.bannerList == []
        ? _noDataHelper()
        : _dataListHelper(context, bannerProvider, bannerProvider.bannerList);
  }

  Widget _noDataHelper() {
    return Center(child: Text('데이터가 없습니다.', style: AppTextStyles.blackColorH1));
  }

  Widget _dataListHelper(BuildContext context, BannerProvider bannerProvider,
      List<AdBanner>? bannerList) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 12),
          for (int i = 0; i < bannerList!.length; i++) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: AppDecorations.buttonDecoration(Colors.white),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.network(
                          bannerList[i].image,
                          width: AppSizes.ratioOfHorizontal(context, 1),
                          height:
                              AppSizes.ratioOfHorizontal(context, 1) / 3 - 24,
                          fit: BoxFit.fill,
                          loadingBuilder: (context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return _cardLoadingHelper(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "게시일 : ${bannerList[i].startDate}",
                    style: AppTextStyles.grey600ColorB2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    decoration:
                        AppDecorations.buttonDecoration(Colors.redAccent),
                    child: MaterialButton(
                      onPressed: () => MyDialog.bannerDeleteDialog(
                          context, bannerProvider, bannerList[i].bannerId),
                      child: Text("배너 삭제", style: AppTextStyles.whiteColorB2),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ]
        ],
      ),
    );
  }

  Widget _cardLoadingHelper(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        height: AppSizes.ratioOfVertical(context, 0.097),
        color: Colors.black,
      ),
    );
  }
}

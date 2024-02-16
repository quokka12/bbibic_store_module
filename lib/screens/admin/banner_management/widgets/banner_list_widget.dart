import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../database/firebase/banner_firebase.dart';
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
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: FutureBuilder<List<AdBanner>>(
                future: BannerFirebase.getData(context),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AdBanner>> snapshot) {
                  // 데이터 로딩 중일 때의 UI 처리
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _loadingHelper(context);
                  }

                  // 에러 발생 시의 UI 처리
                  if (snapshot.hasError) {
                    return Text('에러 발생: ${snapshot.error}');
                  }

                  List<AdBanner>? bannerList = snapshot.data;

                  // 데이터를 성공적으로 받아온 경우의 UI 처리
                  if (snapshot.data == null ||
                      bannerList == null ||
                      bannerList.isEmpty) {
                    return _noDataHelper();
                  }

                  // TODO: 받아온 데이터를 활용한 UI 구성 및 반환 처리
                  return _dataListHelper(context, bannerProvider, bannerList);
                })),
      ),
    );
  }

  Widget _noDataHelper() {
    return Center(child: Text('데이터가 없습니다.', style: AppTextStyles.blackColorH1));
  }

  Widget _loadingHelper(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < 5; i++) ...[
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
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              width: double.infinity,
                              height: AppSizes.ratioOfVertical(context, 0.097),
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          decoration:
                              AppDecorations.buttonDecoration(Colors.redAccent),
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text("배너 삭제",
                                style: AppTextStyles.whiteColorB2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: 150,
                        height: 20,
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _dataListHelper(BuildContext context, BannerProvider bannerProvider,
      List<AdBanner>? bannerList) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1000),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
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
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                              loadingBuilder: (context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: double.infinity,
                                    height: AppSizes.ratioOfVertical(
                                        context, 0.097),
                                    color: Colors.black,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            decoration: AppDecorations.buttonDecoration(
                                Colors.redAccent),
                            child: MaterialButton(
                              onPressed: () => MyDialog.bannerDeleteDialog(
                                  context,
                                  bannerProvider,
                                  bannerList[i].bannerId),
                              child: Text("배너 삭제",
                                  style: AppTextStyles.whiteColorB2),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        "게시일 : ${bannerList[i].startDate}",
                        style: AppTextStyles.grey600ColorB2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )),
              const SizedBox(height: 12),
            ]
          ],
        ),
      ),
    );
  }
}

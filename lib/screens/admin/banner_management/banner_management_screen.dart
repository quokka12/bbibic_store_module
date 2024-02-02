import 'package:bbibic_store/database/firebase/banner_firebase.dart';
import 'package:bbibic_store/models/ad_banner.dart';
import 'package:bbibic_store/providers/banner_provider.dart';
import 'package:bbibic_store/screens/widgets/my_dialog.dart';
import 'package:bbibic_store/theme/app_colors.dart';
import 'package:bbibic_store/theme/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../configs/router/route_names.dart';
import '../../../theme/app_decorations.dart';
import '../../../theme/app_text_styles.dart';
import '../../widgets/my_app_bar.dart';

class BannerManagementScreen extends StatelessWidget {
  const BannerManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bannerProvider = Provider.of<BannerProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar.basicAppBar(context, '배너 관리', null),
            Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: FutureBuilder<List<AdBanner>>(
                        future: BannerFirebase.getData(context),
                        builder: (BuildContext context, AsyncSnapshot<List<AdBanner>> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // 데이터 로딩 중일 때의 UI 처리
                            return Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  for (int i = 0; i < 5; i++) ...[
                                    Container(
                                        width:double.infinity,
                                        padding: const EdgeInsets.all(12),
                                        decoration: AppDecorations.buttonDecoration(Colors.white),
                                        child:Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor: Colors.grey.shade100,
                                                child: Container(width: double.infinity,height: AppSizes.ratioOfVertical(context, 0.097),color: Colors.black,),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Container(
                                              decoration: AppDecorations.buttonDecoration(Colors.redAccent),
                                              child: MaterialButton(
                                                onPressed: () {},
                                                child: Text("배너 삭제",style: AppTextStyles.whiteColorB2),
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            // 에러 발생 시의 UI 처리
                            return Text('에러 발생: ${snapshot.error}');
                          } else {
                            // 데이터를 성공적으로 받아온 경우의 UI 처리
                            if(snapshot.data == null){
                              return Text('데이터가 없습니다.');
                            }
                            List<AdBanner>? bannerList = snapshot.data;
                            if(bannerList?.length == 0){
                              return Center(child: Text('데이터가 없습니다.',style: AppTextStyles.blackColorH1));
                            }
                            // TODO: 받아온 데이터를 활용한 UI 구성 및 반환 처리
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 1000),
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    for (int i = 0; i < bannerList!.length; i++) ...[
                                      Container(
                                        width:double.infinity,
                                        padding: const EdgeInsets.all(12),
                                        decoration: AppDecorations.buttonDecoration(Colors.white),
                                        child:Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Image.network(bannerList[i].image,
                                                    width: double.infinity,
                                                    fit: BoxFit.fitWidth,
                                                    loadingBuilder: (context, Widget child, ImageChunkEvent? loadingProgress) {
                                                      if(loadingProgress == null){
                                                        return child;
                                                      }
                                                      return Shimmer.fromColors(
                                                        baseColor: Colors.grey.shade300,
                                                        highlightColor: Colors.grey.shade100,
                                                        child:
                                                        Container(width: double.infinity,height: AppSizes.ratioOfVertical(context, 0.097),color: Colors.black,),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Container(
                                                  decoration: AppDecorations.buttonDecoration(Colors.redAccent),
                                                  child: MaterialButton(
                                                      onPressed: () =>MyDialog.bannerDeleteDialog(context,bannerProvider,bannerList[i].bannerId),
                                                    child: Text("배너 삭제",style: AppTextStyles.whiteColorB2),
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
                                        )
                                      ),
                                      const SizedBox(height: 12),
                                    ]
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      )
                  ),
                ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(RouteNames.addBanner),
        label: Text("배너 추가하기",style: AppTextStyles.whiteColorB1),
        icon: Icon(Icons.edit,color: Colors.white),
        backgroundColor: AppColors.bbibic,
      ),
    );
  }

}

import 'package:bbibic_store/configs/router/route_names.dart';
import 'package:bbibic_store/screens/widgets/my_dialog.dart';
import 'package:bbibic_store/theme/app_colors.dart';
import 'package:bbibic_store/theme/app_decorations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../database/firebase/goods_firebase.dart';
import '../../../models/goods.dart';
import '../../../providers/goods_provider.dart';
import '../../../theme/app_text_styles.dart';
import '../../widgets/my_app_bar.dart';

class GoodsManagementScreen extends StatefulWidget {
  const GoodsManagementScreen({Key? key}) : super(key: key);

  @override
  State<GoodsManagementScreen> createState() => _GoodsManagementScreenState();
}

class _GoodsManagementScreenState extends State<GoodsManagementScreen> {
  @override
  Widget build(BuildContext context) {
    final GoodsProvider goodsProvider = Provider.of<GoodsProvider>(context);
    return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MyAppBar.basicAppBar(context, '상품 관리', null),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: FutureBuilder<List<Goods>>(
                          future: GoodsFirebase.getData(context),
                          builder: (BuildContext context, AsyncSnapshot<List<Goods>> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // 데이터 로딩 중일 때의 UI 처리
                              return Container(
                                width: double.infinity,
                                child: Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: [
                                    for (int i = 0; i < 5; i++) ...[
                                      Container(
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
                                                width: 150,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                              ),
                                              SizedBox(height: 12),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 210,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Container(
                                                    width: 80,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Container(
                                                    width: 120,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Container(
                                                    width: 100,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Container(
                                                    width: 90,
                                                    height: 16,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Container(
                                                    width: 70,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  SizedBox(height: 12),
                                                  Container(
                                                    width: 60,
                                                    height: 32,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  SizedBox(height: 16),
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
                            } else if (snapshot.hasError) {
                              // 에러 발생 시의 UI 처리
                              return Text('에러 발생: ${snapshot.error}');
                            } else {
                              // 데이터를 성공적으로 받아온 경우의 UI 처리
                              if(snapshot.data == null){
                                return Text('데이터가 없습니다.');
                              }
                              List<Goods>? goodsList = snapshot.data;
                              if(goodsList?.length == 0){
                                return Center(child: Text('데이터가 없습니다.',style: AppTextStyles.blackColorH1));
                              }
                              // TODO: 받아온 데이터를 활용한 UI 구성 및 반환 처리
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 1000),
                                child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      for (int i = 0; i < goodsList!.length; i++) ...[
                                        Container(
                                          width:double.infinity,
                                          padding: const EdgeInsets.all(12),
                                          decoration: AppDecorations.buttonDecoration(Colors.white),
                                          child: Column(
                                            children: [
                                              Container(
                                                width:double.infinity,
                                                child: Wrap(
                                                    spacing: 12,
                                                    runSpacing: 2,
                                                    children: [
                                                      Image.network(goodsList[i].thumbnailImages![0],
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.contain,
                                                        loadingBuilder: (context, Widget child, ImageChunkEvent? loadingProgress) {
                                                          if(loadingProgress == null){
                                                            return child;
                                                          }
                                                          return Shimmer.fromColors(
                                                            baseColor: Colors.grey.shade300,
                                                            highlightColor: Colors.grey.shade100,
                                                            child:
                                                            Container(
                                                              width: 100,
                                                              height: 100,
                                                              decoration: BoxDecoration(
                                                                color: Colors.black,
                                                                borderRadius: BorderRadius.circular(12),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Container(
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
                                                              goodsList[i].status ? "판매중" : "판매정지",
                                                              overflow: TextOverflow.ellipsis,
                                                              style: goodsList[i].status ?
                                                              AppTextStyles.blueColorB1:
                                                              AppTextStyles.redColorB1,
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
                                                              onChanged: (value) => goodsProvider.changeStatus(context, goodsList[i].goodsId!, !goodsList[i].status),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ),
                                              Container(
                                                width:double.infinity,
                                                decoration: AppDecorations.buttonDecoration(Colors.redAccent),
                                                child: MaterialButton(onPressed: () =>
                                                    MyDialog.goodsDeleteDialog(
                                                      context,
                                                      goodsProvider,
                                                      goodsList[i],
                                                    ),
                                                  child: Text("상품 삭제",style: AppTextStyles.whiteColorB2),),
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 12),
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
            onPressed: () => context.pushNamed(RouteNames.addGoods),
            label: Text("상품 추가하기",style: AppTextStyles.whiteColorB1),
            icon: Icon(Icons.edit,color: Colors.white,),
            backgroundColor: AppColors.bbibic,
          ),
    );
  }
}

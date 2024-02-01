import 'dart:async';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:bbibic_store/database/firebase/goods_firebase.dart';
import 'package:bbibic_store/providers/goods_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../configs/router/route_names.dart';
import '../../database/firebase/category_firebase.dart';
import '../../models/goods.dart';
import '../../providers/category_provider.dart';
import '../../theme/app_assets.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';
import '../widgets/loading_bar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map> menuList = [
    {"image": AppAssets.imageMedicine, "title": "영양제"},
    {"image": AppAssets.imageCream, "title": "영양크림"},
    {"image": AppAssets.imageMask, "title": "위생용품"},
    {"image": AppAssets.imageInterior, "title": "인테리어"},
  ];

  List<Map> popularGoodsList = [
    {
      "image": "assets/images/test1.jpg",
      "title": "덴프스 덴마크 유산균 이야기",
      "price": 26180
    },
    {
      "image": "assets/images/test2.jpg",
      "title": "콴첼 뮤코다당단백 콘드로이친 플러스",
      "price": 22000
    },
    {
      "image": "assets/images/test3.jpg",
      "title": "종근당건강 아이클리어 루테인 지아잔틴",
      "price": 4800
    },
    {"image": "assets/images/test4.jpg", "title": "오쏘몰 이뮨", "price": 69750},
    {
      "image": "assets/images/test5.jpg",
      "title": "에버그린 멀티비타민 앤 미네랄",
      "price": 29700
    },
    {
      "image": "assets/images/test6.jpg",
      "title": "종근당건강 프로메가 알티지 오메가3 듀얼",
      "price": 7550
    },
    {
      "image": "assets/images/test7.jpg",
      "title": "고려은단비타민C1000",
      "price": 42000
    },
    {
      "image": "assets/images/test8.jpg",
      "title": "주영엔에스 관절엔 콘드로이친 1200",
      "price": 50250
    },
  ];

  List<Map> newGoodsList = [
    {
      "image": "assets/images/test8.jpg",
      "title": "주영엔에스 관절엔 콘드로이친 1200",
      "price": 50250
    },
    {
      "image": "assets/images/test7.jpg",
      "title": "고려은단비타민C1000",
      "price": 42000
    },
    {
      "image": "assets/images/test6.jpg",
      "title": "종근당건강 프로메가 알티지 오메가3 듀얼",
      "price": 7550
    },
    {
      "image": "assets/images/test5.jpg",
      "title": "에버그린 멀티비타민 앤 미네랄",
      "price": 29700
    },
    {
      "image": "assets/images/test1.jpg",
      "title": "덴프스 덴마크 유산균 이야기",
      "price": 26180
    },
    {
      "image": "assets/images/test2.jpg",
      "title": "콴첼 뮤코다당단백 콘드로이친 플러스",
      "price": 22000
    },
    {
      "image": "assets/images/test3.jpg",
      "title": "종근당건강 아이클리어 루테인 지아잔틴",
      "price": 4800
    },
    {
      "image": "assets/images/test4.jpg",
      "title": "오쏘몰 이뮨",
      "price": 69750,
    },
  ];
  @override
  Widget build(BuildContext context) {
    final GoodsProvider goodsProvider = Provider.of<GoodsProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              homeAppBar(),
              bannerHelper(),
              SizedBox(height: 20),
              homeMenuHelper(),
              SizedBox(height: 20),
              firebaseGoodsListHelper("삐빅샵 새로 나온 상품", goodsProvider),
              SizedBox(height: 20),
              goodsListHelper("삐빅샵 인기상품", popularGoodsList),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeAppBar() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      height: 56,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.grey200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("원하시는 상품이 있으신가요?",
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.grey600ColorC1,
                    ),
                    Icon(
                      Icons.search_rounded,
                      size: 24,
                      color: AppColors.grey800,
                    ),
                  ],
                )
                ),
              ),
            ),
          SizedBox(width: 12),
          Row(
            children: [
              GestureDetector(
                onTap: () { },
                child: Icon(Icons.shopping_cart, size: 24),
              ),
              SizedBox(width: 12),
              GestureDetector(
                onTap: ()=> context.goNamed(RouteNames.myInfo),
                child: Icon(Icons.person, size: 24),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget bannerHelper() {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                child: SizedBox(
                  width: double.infinity,
                  height: AppSizes.ratioOfHorizontal(context, 1) / 3,
                  child: AnotherCarousel(
                    dotSize: 0,
                    dotBgColor: Colors.transparent,
                    images: [
                      Image.asset(
                        AppAssets.imageBanner2,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      Image.asset(
                        AppAssets.imageBanner3,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      Image.asset(
                        AppAssets.imageBanner4,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ));
          }
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: double.infinity,
              height: AppSizes.ratioOfHorizontal(context, 1) / 3,
              decoration: const BoxDecoration(color: Colors.black),
            ),
          );
        });
  }

  Widget homeMenuHelper() {
    return Row(
      children: [
        for (int i = 0; i < menuList.length; i++)
          Expanded(
            child: Column(
              children: [
                Image.asset(
                  menuList[i]["image"],
                  width: 42,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 8),
                Text(
                  menuList[i]["title"],
                  style: AppTextStyles.blackColorB2,
                ),
              ],
            ),
          )
      ],
    );
  }

  Widget goodsListHelper(String title, List<Map> goodsList) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.bottomLeft,
          child: Text(title, style: AppTextStyles.blackColorH2Bold),
        ),
        const SizedBox(height: 12),
        FutureBuilder(
            future: Future.delayed(const Duration(seconds: 1)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 1000),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        for (int i = 0; i < goodsList.length; i++) ...[
                          Container(
                            width: 160,
                            child: Column(
                              children: [
                                Image.asset(
                                  goodsList[i]["image"],
                                  width: 160,
                                  height: 120,
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  goodsList[i]["title"],
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.blackColorS1,
                                ),
                                Text(
                                  "${goodsList[i]["price"]} 원",
                                  style: AppTextStyles.blackColorS2Bold,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                        ]
                      ],
                    ),
                  ),
                );
              }
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      for (int i = 0; i < 10; i++) ...[
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                width: 160,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                width: 80,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                      ]
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }

  Widget firebaseGoodsListHelper(String title,GoodsProvider goodsProvider) {
    return  Column(
        children: [
        const SizedBox(height: 20),
        Container(
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.bottomLeft,
          child: Text(title, style: AppTextStyles.blackColorH2Bold),
        ),
        const SizedBox(height: 12),
        FutureBuilder<List<Goods>>(
          future: GoodsFirebase.getDataSortByCreatedDate(context),
          builder: (BuildContext context, AsyncSnapshot<List<Goods>> snapshot) {
            List<Goods>? goodsList = snapshot.data;
            if(goodsList == null){
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      for (int i = 0; i < 10; i++) ...[
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                width: 160,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                width: 80,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                      ],
                    ],
                  ),
                ),
              );
            }
            if(goodsList.isEmpty){
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
            if(snapshot.connectionState == ConnectionState.done) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      for (int i = 0; i < goodsList!.length; i++) ...[
                        GestureDetector(
                      onTap : (){
                        goodsProvider.set(goodsList[i]);
                        context.pushNamed(RouteNames.goodsDetail);
                      },
                      child: SizedBox(
                        width: 160,
                        child: Column(
                          children: [
                            Image.network(goodsList[i].thumbnailImages![0],
                              width: 150,
                              height: 150,
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
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Text(
                              "${goodsList[i].goodsName}",
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.blackColorS1,
                            ),
                            Text(
                              "${goodsList[i].goodsPrice} 원",
                              style: AppTextStyles.blackColorS2Bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                        SizedBox(width: 16),
                      ]
                    ],
                  ),
                ),
              );
            }
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    for (int i = 0; i < 10; i++) ...[
                      Container(
                        child: Column(
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: 160,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: 80,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

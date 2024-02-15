import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:bbibic_store/database/firebase/banner_firebase.dart';
import 'package:bbibic_store/database/firebase/goods_firebase.dart';
import 'package:bbibic_store/models/ad_banner.dart';
import 'package:bbibic_store/providers/goods_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../configs/router/route_names.dart';
import '../../models/goods.dart';
import '../../providers/cart_provider.dart';
import '../../theme/app_assets.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';
import '../../util/format_util.dart';

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
    {"image": AppAssets.imageMedicalEquipment, "title": "의료기기"},
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
    {
      "image": "assets/images/test4.jpg",
      "title": "오쏘몰 이뮨",
      "price": 69750,
    },
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
      "price": 50250,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final GoodsProvider goodsProvider = Provider.of<GoodsProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.grey200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              homeAppBar(),
              firebaseBannerHelper(),
              homeMenuHelper(),
              const SizedBox(height: 16),
              firebaseGoodsListHelper(
                  AppAssets.imageNew, "삐빅샵 새로 나온 상품", goodsProvider),
              const SizedBox(height: 16),
              firebaseGoodsListHelper(
                  AppAssets.imageHot, "삐빅샵 인기상품", goodsProvider),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeAppBar() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      height: 56,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
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
                      Text(
                        "원하시는 상품이 있으신가요?",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.grey600ColorC1,
                      ),
                      const Icon(
                        Icons.search_rounded,
                        size: 24,
                        color: AppColors.grey800,
                      ),
                    ],
                  )),
            ),
          ),
          const SizedBox(width: 12),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  final cartProvider =
                      Provider.of<CartProvider>(context, listen: false);
                  cartProvider.getData(context);
                  context.pushNamed(RouteNames.cart);
                },
                child: const Icon(Icons.shopping_cart_outlined, size: 24),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => context.goNamed(RouteNames.myInfo),
                child: const Icon(Icons.person_outlined, size: 24),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget homeMenuHelper() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < menuList.length; i++) ...[
            Expanded(
              child: Column(
                children: [
                  Image.asset(
                    menuList[i]["image"],
                    width: 36,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    menuList[i]["title"],
                    style: AppTextStyles.blackColorC1,
                  ),
                ],
              ),
            ),
            if (i != menuList.length - 1)
              Container(
                width: 1,
                height: 28,
                color: AppColors.grey300,
              )
          ]
        ],
      ),
    );
  }

  Widget firebaseBannerHelper() {
    return FutureBuilder(
        future: BannerFirebase.getData(context),
        builder:
            (BuildContext context, AsyncSnapshot<List<AdBanner>> snapshot) {
          List<AdBanner>? bannerList = snapshot.data;
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
                      for (int i = 0; i < bannerList!.length; i++) ...[
                        Image.network(
                          bannerList[i].image,
                          width: double.infinity,
                          height: AppSizes.ratioOfHorizontal(context, 1) / 3,
                          fit: BoxFit.fill,
                        ),
                      ]
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

  Widget firebaseGoodsListHelper(
      String image, String title, GoodsProvider goodsProvider) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Image.asset(
                  image,
                  width: 32,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 8),
                Text(title, style: AppTextStyles.blackColorS1Bold),
              ],
            ),
          ),
          const SizedBox(height: 12),
          FutureBuilder<List<Goods>>(
            future: GoodsFirebase.getDataSortByCreatedDate(context),
            builder:
                (BuildContext context, AsyncSnapshot<List<Goods>> snapshot) {
              List<Goods>? goodsList = snapshot.data;
              if (goodsList == null) {
                return goodsLoadingHelper();
              }
              if (goodsList.isEmpty) {
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
              if (snapshot.connectionState == ConnectionState.done) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 1000),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        for (int i = 0; i < goodsList!.length; i++) ...[
                          GestureDetector(
                            onTap: () {
                              goodsProvider.set(goodsList[i]);
                              context.pushNamed(RouteNames.goodsDetail);
                            },
                            child: SizedBox(
                              width: 160,
                              child: Column(
                                children: [
                                  Image.network(
                                    goodsList[i].thumbnailImages![0],
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    "${goodsList[i].goodsName}",
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.blackColorB1,
                                  ),
                                  Text(
                                    "${FormatUtil.priceFormat(goodsList[i].goodsPrice!)}원",
                                    style: AppTextStyles.blackColorB2Bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                        ]
                      ],
                    ),
                  ),
                );
              }
              return goodsLoadingHelper();
            },
          ),
        ],
      ),
    );
  }

  Widget goodsLoadingHelper() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(width: 20),
            for (int i = 0; i < 5; i++) ...[
              SizedBox(
                width: 160,
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 160,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 100,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 28),
            ],
          ],
        ),
      ),
    );
  }
}

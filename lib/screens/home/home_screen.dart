import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:bbibic_store/database/firebase/banner_firebase.dart';
import 'package:bbibic_store/models/ad_banner.dart';
import 'package:bbibic_store/screens/home/widgets/goods_most_popular_list_widget.dart';
import 'package:bbibic_store/screens/home/widgets/goods_most_recent_list_widget.dart';
import 'package:bbibic_store/screens/home/widgets/home_app_bar.dart';
import 'package:bbibic_store/screens/home/widgets/home_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_sizes.dart';
import '../widgets/company_info_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey150,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeAppBar(),
              _bannerHelper(),
              HomeMenuWidget(),
              const SizedBox(height: 12),
              const GoodsMostRecentListWidget(),
              const SizedBox(height: 12),
              const GoodsMostPopularListWidget(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  decoration: BoxDecoration(color: AppColors.grey300),
                ),
              ),
              CompanyInfoWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bannerHelper() {
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
                        loadingBuilder: (context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              width: AppSizes.ratioOfHorizontal(context, 1),
                              height: AppSizes.ratioOfHorizontal(context, 1),
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ]
                  ],
                ),
              ),
            );
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
}

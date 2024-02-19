import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../providers/banner_provider.dart';
import '../../../theme/app_sizes.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerProvider = Provider.of<BannerProvider>(context);
    return !bannerProvider.isGetted
        ? _loadingBanner(context)
        : bannerProvider.bannerList == []
            ? const SizedBox()
            : SizedBox(
                width: AppSizes.ratioOfHorizontal(context, 1),
                height: AppSizes.ratioOfHorizontal(context, 1) / 3,
                child: AnotherCarousel(
                  dotSize: 0,
                  dotBgColor: Colors.transparent,
                  images: [
                    for (int i = 0;
                        i < bannerProvider.bannerList.length;
                        i++) ...[
                      Image.network(
                        bannerProvider.bannerList[i].image,
                        width: double.infinity,
                        height: AppSizes.ratioOfHorizontal(context, 1) / 3,
                        fit: BoxFit.fill,
                        loadingBuilder: (context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return _loadingBanner(context);
                        },
                      ),
                    ]
                  ],
                ),
              );
  }

  Widget _loadingBanner(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: AppSizes.ratioOfHorizontal(context, 1),
        height: AppSizes.ratioOfHorizontal(context, 1) / 3,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
      ),
    );
  }
}

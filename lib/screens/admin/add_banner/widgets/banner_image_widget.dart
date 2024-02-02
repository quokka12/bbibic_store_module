import 'dart:io';

import 'package:bbibic_store/providers/banner_provider.dart';
import 'package:bbibic_store/screens/admin/components/photo_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/photo_provider.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_sizes.dart';
import '../../../../theme/app_text_styles.dart';


class BannerImageWidget extends StatelessWidget {
  const BannerImageWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    final bannerProvider = Provider.of<BannerProvider>(context);
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text("배너 이미지 추가",style: AppTextStyles.blackColorH2Bold),
            ),
            const SizedBox(height: 12),
            bannerProvider.banner != null ?
              _photoListHelper(context, bannerProvider):
              _addButton(context, bannerProvider),
            _bannerInfoHelper(),
            PhotoComponent.photoRemoveInfoHelper(),

          ],
        ),
    );
  }

  Widget _imageHelper(BuildContext context, url) {
    return  SizedBox(
      width: double.infinity,
      height: AppSizes.ratioOfHorizontal(context, 1) / 3,
      child: Image.file(File(url!.path), fit: BoxFit.fill),
    );
  }

  Widget _bannerInfoHelper() {
    return Padding(
      padding: const EdgeInsets.only(left: 12,top: 12),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            size: 16,
            color: AppColors.grey600,
          ),
          const SizedBox(width: 4),
          Text(
            "배너 이미지의 세로 : 가로 비율은 1 : 3을 권장합니다.",
            style: AppTextStyles.grey600ColorB2,
          ),
        ],
      ),
    );
  }

  Widget _addButton(BuildContext context, BannerProvider bannerProvider){
    return InkWell(
      onTap: () => bannerProvider.addBanner(),
      child: Container(
        width: AppSizes.ratioOfHorizontal(context, 1),
        height: AppSizes.ratioOfHorizontal(context, 1) / 3,
        color: AppColors.grey300,
        alignment: Alignment.center,
        child: const Icon(Icons.add, size: 24, color: AppColors.black),
      ),
    );
  }

  Widget _photoListHelper(BuildContext context, BannerProvider bannerProvider){
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              title: Text(
                '사진 삭제',
                style: AppTextStyles.blackColorH1,
              ),
              content: Text('해당 사진을 정말 삭제하겠습니까?', style: AppTextStyles.blackColorB1),
              actions: [
                TextButton(
                  child: Text('삭제', style: AppTextStyles.blackColorB1),
                  onPressed: () {
                    Navigator.pop(context);
                    bannerProvider.clear();
                  },
                ),
                TextButton(
                  child: Text('닫기', style: AppTextStyles.blackColorB1),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          }),
        );
      },
      child: _imageHelper(context, bannerProvider.banner),
    );
  }
}

import 'dart:io';

import 'package:bbibic_store/screens/admin/components/photo_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/photo_provider.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';


class ThumbnailWidget extends StatelessWidget {
  const ThumbnailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final photoProvider = Provider.of<PhotoProvider>(context);
    return Padding(
        padding: const EdgeInsets.only(left: 12,top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("썸네일 이미지",style: AppTextStyles.blackColorH2Bold),
            const SizedBox(height: 12),
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      for (int i = 0; i < photoProvider.thumbnailList.length; i++)
                        GestureDetector(
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
                                        photoProvider.removeThumbnail(i);
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
                          child: PhotoComponent.imageHelper(photoProvider.thumbnailList[i]),
                        ),
                      InkWell(
                        onTap: () => photoProvider.addThumbnail(),
                        child: Container(
                          width: 150,
                          height: 150,
                          color: AppColors.grey300,
                          alignment: Alignment.center,
                          child: const Icon(Icons.add, size: 24, color: AppColors.black),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }

}

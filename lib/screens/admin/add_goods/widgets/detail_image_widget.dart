import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/photo_provider.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';


class DetailImageWidget extends StatelessWidget {
  const DetailImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final photoProvider = Provider.of<PhotoProvider>(context);
    return Padding(
        padding: const EdgeInsets.only(left: 12,top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("상세정보 이미지",style: AppTextStyles.blackColorH2Bold),
            const SizedBox(height: 12),
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      for (int i = 0; i < photoProvider.detailList.length; i++)
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
                                        photoProvider.removeDetail(i);
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
                          child: imageHelper(photoProvider.detailList[i]),
                        ),
                      InkWell(
                        onTap: () => photoProvider.addDetail(),
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

  Widget imageHelper(url) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: SizedBox(
        height: 150,
        width: 150,
        child: Image.file(File(url!.path), fit: BoxFit.fitHeight),
      ),
    );
  }

  Widget photoRemoveInfoHelper() {
    return  Row(
      children: [
        const Icon(
          Icons.info_outline,
          size: 16,
          color: AppColors.grey600,
        ),
        const SizedBox(width: 4),
        Text(
          "추가한 사진은 터치해서 삭제할 수 있어요!",
          style: AppTextStyles.grey600ColorB2,
        ),
      ],
    );
  }
}

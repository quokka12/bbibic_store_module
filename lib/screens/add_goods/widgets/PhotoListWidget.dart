import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/photo_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';


class PhotoListWidget extends StatelessWidget {
  const PhotoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final photoProvider = Provider.of<PhotoProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 12),
                for (int i = 0; i < photoProvider.photoList.length; i++)
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
                                  photoProvider.removePhotos(i);
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
                    child: imageHelper(photoProvider.photoList[i]),
                  ),
                InkWell(
                  onTap: () => photoProvider.addPhotos(),
                  child: Container(
                    width: 200,
                    height: 150,
                    color: AppColors.grey300,
                    alignment: Alignment.center,
                    child: const Icon(Icons.add, size: 24, color: AppColors.black),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
          ),
        ),
        photoRemoveInfoHelper(),
      ],
    );
  }

  Widget imageHelper(url) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: SizedBox(
        height: 150,
        width: 200,
        child: Image.file(File(url!.path), fit: BoxFit.fill),
      ),
    );
  }

  Widget photoRemoveInfoHelper() {
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
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
      ),
    );
  }
}

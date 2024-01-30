import 'package:bbibic_store/configs/router/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../database/firebase/category_firebase.dart';
import '../../../providers/category_provider.dart';
import '../../../theme/app_decorations.dart';
import '../../../theme/app_text_styles.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    CategoryFirebase.getData(context).then((value) {
    categoryProvider.categoryList = value;
    });
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("카테고리",style: AppTextStyles.blackColorH2Bold),
                GestureDetector(
                  onTap: () =>context.pushNamed(RouteNames.categoryManagement),
                  child: Text("카테고리 관리",style: AppTextStyles.underlineBlue),
                )
              ],
            ),
            const SizedBox(width: 4),
            Text(
              "관련 카테고리 태그는 4개까지 설정 가능해요!",
              style: AppTextStyles.grey600ColorB2,
            ),
            SizedBox(height: 12),
            _categoryList(context, categoryProvider),
          ],
        ),
    );
  }

  Widget _categoryList(BuildContext context, CategoryProvider categoryProvider) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      spacing: 4,
      runSpacing: 4,
      children: [
        for(int i =0; i<categoryProvider.categoryList!.length;i++)
          _categoryCard(categoryProvider.categoryList[i],categoryProvider),
      ],
    );
  }

  Widget _categoryCard(String name, CategoryProvider categoryProvider) {

    return Padding(
      padding: const EdgeInsets.all(6),
      child: InkWell(
        onTap: () {
          if (categoryProvider.selectedCategoryList.contains(name)) {
            categoryProvider.unselectTag(name);
          } else {
            categoryProvider.selectTag(name);
          }
        },
        child: UnconstrainedBox(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: categoryProvider.selectedCategoryList.contains(name)
                ? AppDecorations.selectedTagDecoration()
                : AppDecorations.tagDecoration(),
            child: Text(
              "#$name",
              style: categoryProvider.selectedCategoryList.contains(name)
                  ? AppTextStyles.blackColorB1
                  : AppTextStyles.grey600ColorB1,
            ),
          ),
        ),
      ),
    );
  }
}

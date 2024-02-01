import 'package:bbibic_store/configs/router/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../database/firebase/category_firebase.dart';
import '../../../../providers/category_provider.dart';
import '../../../../theme/app_decorations.dart';
import '../../../../theme/app_text_styles.dart';


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
                  child: Text("카테고리 관리",style: AppTextStyles.underline),
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
    return FutureBuilder<List<String>>(
      future: CategoryFirebase.getData(context),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(height: 1000); // 데이터 로딩 중에 보여줄 위젯
        } else if (snapshot.hasError) {
          Fluttertoast.showToast(
            msg: "데이터를 불러올 수 없습니다. 다시 시도해주세요.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: AppTextStyles.B1,
          );
          return SizedBox(); // 에러 발생 시 보여줄 위젯
        } else {
          List<String>? categoryList = snapshot.data; // List<String> 형태의 데이터 추출
          // 추출한 데이터를 활용하여 UI를 구성하거나 다른 작업을 수행할 수 있습니다.
          return Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: 12,
            runSpacing: 12,
            children: [
              for(int i = 0; i<categoryList!.length;i++)
                _categoryCard(categoryList[i], categoryProvider),
            ],
          );
        }
      },
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

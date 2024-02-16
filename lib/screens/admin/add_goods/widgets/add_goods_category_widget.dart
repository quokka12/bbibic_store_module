import 'package:bbibic_store/util/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../configs/router/route_names.dart';
import '../../../../providers/category_provider.dart';
import '../../../../theme/app_decorations.dart';
import '../../../../theme/app_text_styles.dart';

class AddGoodsCategoryWidget extends StatelessWidget {
  const AddGoodsCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleHelper(context),
          const SizedBox(width: 4),
          _categoryInfoText(),
          const SizedBox(height: 12),
          _itemList(context, categoryProvider),
        ],
      ),
    );
  }

  Widget _titleHelper(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("카테고리", style: AppTextStyles.blackColorH2Bold),
        GestureDetector(
          onTap: () => context.pushNamed(RouteNames.categoryManagement),
          child: Text("카테고리 관리", style: AppTextStyles.underline),
        )
      ],
    );
  }

  Widget _categoryInfoText() {
    return Text(
      "관련 카테고리 태그는 4개까지 설정 가능해요!",
      style: AppTextStyles.grey600ColorB2,
    );
  }

  Widget _itemList(BuildContext context, CategoryProvider categoryProvider) {
    return FutureBuilder<List<String>>(
      future: categoryProvider.getData(context),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasError) {
          ToastUtil.basic("데이터를 불러올 수 없습니다. 다시 시도해주세요.");
          return const SizedBox(); // 에러 발생 시 보여줄 위젯
        } else {
          List<String> categoryList = snapshot.data!; // List<String> 형태의 데이터 추출
          // 추출한 데이터를 활용하여 UI를 구성하거나 다른 작업을 수행할 수 있습니다.
          return Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: 12,
            runSpacing: 12,
            children: [
              for (int i = 0; i < categoryList.length; i++)
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

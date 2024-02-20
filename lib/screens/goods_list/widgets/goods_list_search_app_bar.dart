import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/category_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_decorations.dart';
import '../../../theme/app_text_styles.dart';
import '../../../util/toast_util.dart';

class GoodsListSearchAppBar extends StatelessWidget {
  String searchWord = '';
  String filter = '최신순';
  GoodsListSearchAppBar(
      {super.key, required this.searchWord, required this.filter});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 52,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 48,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      right: 8,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "원하시는 상품이 있으신가요?",
                        hintStyle: AppTextStyles.grey600ColorB2,
                      ),
                    ),
                  ),
                ),
                const Icon(
                  Icons.search_rounded,
                  size: 28,
                  color: AppColors.grey800,
                ),
                const SizedBox(width: 12),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 4),
            child: Row(
              children: [
                Text("태그", style: AppTextStyles.blackColorB2Bold),
                SizedBox(width: 12),
                Expanded(
                  child: FutureBuilder<List<String>>(
                    future: categoryProvider.getData(context),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.hasError) {
                        ToastUtil.basic("데이터를 불러올 수 없습니다. 다시 시도해주세요.");
                        return const SizedBox(); // 에러 발생 시 보여줄 위젯
                      } else {
                        List<String> categoryList = [];
                        if (snapshot.data != null) {
                          categoryList = snapshot.data!;
                        }
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i = 0; i < categoryList.length; i++)
                                _categoryCard(
                                    categoryList[i], categoryProvider),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(filter, style: AppTextStyles.grey600ColorC1),
              Icon(
                Icons.arrow_drop_down_rounded,
                color: AppColors.grey600,
                size: 28,
              ),
              SizedBox(width: 12),
            ],
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _categoryCard(String name, CategoryProvider categoryProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 4, right: 4),
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
                  ? AppTextStyles.blackColorC1
                  : AppTextStyles.grey600ColorC1,
            ),
          ),
        ),
      ),
    );
  }
}

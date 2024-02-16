import 'package:bbibic_store/util/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../database/firebase/category_firebase.dart';
import '../../../../providers/category_provider.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_decorations.dart';
import '../../../../theme/app_text_styles.dart';
import '../../../widgets/my_dialog.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("상품 태그", style: AppTextStyles.blackColorH2Bold),
          _categoryRemoveInfoHelper(),
          const SizedBox(height: 8),
          _itemListHelper(context),
        ],
      ),
    );
  }

  Widget _categoryRemoveInfoHelper() {
    return Row(
      children: [
        const Icon(
          Icons.info_outline,
          size: 16,
          color: AppColors.grey600,
        ),
        const SizedBox(width: 4),
        Text(
          "상품 태그는 터치해서 삭제할 수 있어요!",
          style: AppTextStyles.grey600ColorB2,
        ),
      ],
    );
  }

  Widget _itemListHelper(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return FutureBuilder<List<String>>(
      future: categoryProvider.getData(context),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasError) {
          ToastUtil.basic("데이터를 불러올 수 없습니다. 다시 시도해주세요.");
          return const SizedBox(); // 에러 발생 시 보여줄 위젯
        } else {
          List<String> categoryList = [];
          if (snapshot.data != null) {
            categoryList = snapshot.data!;
          }
          // 추출한 데이터를 활용하여 UI를 구성하거나 다른 작업을 수행할 수 있습니다.
          return Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: 12,
            runSpacing: 12,
            children: [
              for (int i = 0; i < categoryList.length; i++)
                _categoryCard(context, categoryList[i], categoryProvider),
            ],
          );
        }
      },
    );
  }

  Widget _categoryCard(
      BuildContext context, String name, CategoryProvider categoryProvider) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: InkWell(
        onTap: () {
          MyDialog.categoryDeleteDialog(context, categoryProvider, name);
          CategoryFirebase.getData(context).then((value) {
            categoryProvider.refresh(value);
          });
        },
        child: UnconstrainedBox(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: AppDecorations.tagDecoration(),
            child: Text("#$name", style: AppTextStyles.grey600ColorB1),
          ),
        ),
      ),
    );
  }
}

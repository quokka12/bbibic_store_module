import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return categoryProvider.categoryList.isEmpty
        ? SizedBox()
        : Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            children: [
              for (int i = 0; i < categoryProvider.categoryList.length; i++)
                _categoryCard(context, categoryProvider.categoryList[i],
                    categoryProvider),
            ],
          );
  }

  Widget _categoryCard(
      BuildContext context, String name, CategoryProvider categoryProvider) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: InkWell(
        onTap: () {
          MyDialog.categoryDeleteDialog(context, categoryProvider, name);
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

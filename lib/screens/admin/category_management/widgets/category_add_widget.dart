import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/category_provider.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_decorations.dart';
import '../../../../theme/app_text_styles.dart';

class CategoryAddWidget extends StatefulWidget {
  const CategoryAddWidget({super.key});

  @override
  State<CategoryAddWidget> createState() => _CategoryAddWidgetState();
}

class _CategoryAddWidgetState extends State<CategoryAddWidget> {
  final categoryNameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    categoryNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("상품 태그 추가", style: AppTextStyles.blackColorH2Bold),
          const SizedBox(height: 8),
          _formHelper(context),
        ],
      ),
    );
  }

  Widget _formHelper(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Form(
      key: _formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              enabled: true,
              controller: categoryNameController,
              decoration: InputDecoration(
                hintText: '추가할 태그명을 입력해주세요.',
                hintStyle: AppTextStyles.grey600ColorB1,
              ),
              style: AppTextStyles.blackColorB1,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return '추가할 태그명을 입력해주세요.';
                }
                return null;
              },
              maxLines: 1,
              minLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              height: 48,
              decoration: AppDecorations.buttonDecoration(AppColors.bbibic),
              child: MaterialButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() != true) return;
                  categoryProvider.add(context, categoryNameController.text);
                  categoryNameController.clear();
                },
                child: Text("추가하기", style: AppTextStyles.whiteColorB1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

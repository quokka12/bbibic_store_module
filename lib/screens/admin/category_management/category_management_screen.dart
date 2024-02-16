import 'package:bbibic_store/screens/admin/category_management/widgets/category_add_widget.dart';
import 'package:bbibic_store/screens/admin/category_management/widgets/category_list_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/my_app_bar.dart';

class CategoryManagementScreen extends StatelessWidget {
  const CategoryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyAppBar.basicAppBar(context, "상품 태그 관리", null),
              const CategoryAddWidget(),
              const CategoryListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

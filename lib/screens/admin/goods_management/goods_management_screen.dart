import 'package:bbibic_store/configs/router/route_names.dart';
import 'package:bbibic_store/screens/admin/goods_management/widgets/goods_list_widget.dart';
import 'package:bbibic_store/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/app_text_styles.dart';
import '../../widgets/my_app_bar.dart';

class GoodsManagementScreen extends StatefulWidget {
  const GoodsManagementScreen({Key? key}) : super(key: key);

  @override
  State<GoodsManagementScreen> createState() => _GoodsManagementScreenState();
}

class _GoodsManagementScreenState extends State<GoodsManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar.basicAppBar(context, '상품 관리', null),
            const GoodsListWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(RouteNames.addGoods),
        label: Text("상품 추가하기", style: AppTextStyles.whiteColorB1),
        icon: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: AppColors.bbibic,
      ),
    );
  }
}

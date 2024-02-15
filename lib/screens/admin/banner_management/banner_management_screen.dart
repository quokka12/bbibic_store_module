import 'package:bbibic_store/screens/admin/banner_management/widgets/banner_list_widget.dart';
import 'package:bbibic_store/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../configs/router/route_names.dart';
import '../../../theme/app_text_styles.dart';
import '../../widgets/my_app_bar.dart';

class BannerManagementScreen extends StatelessWidget {
  const BannerManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar.basicAppBar(context, '배너 관리', null),
            const BannerListWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(RouteNames.addBanner),
        label: Text("배너 추가하기", style: AppTextStyles.whiteColorB1),
        icon: Icon(Icons.add_a_photo_outlined, color: Colors.white),
        backgroundColor: AppColors.bbibic,
      ),
    );
  }
}

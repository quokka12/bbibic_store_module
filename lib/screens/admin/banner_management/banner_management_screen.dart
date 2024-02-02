import 'package:bbibic_store/database/firebase/banner_firebase.dart';
import 'package:bbibic_store/models/ad_banner.dart';
import 'package:bbibic_store/providers/banner_provider.dart';
import 'package:bbibic_store/screens/admin/banner_management/widgets/banner_list_widget.dart';
import 'package:bbibic_store/screens/widgets/my_dialog.dart';
import 'package:bbibic_store/theme/app_colors.dart';
import 'package:bbibic_store/theme/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../configs/router/route_names.dart';
import '../../../theme/app_decorations.dart';
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
        label: Text("배너 추가하기",style: AppTextStyles.whiteColorB1),
        icon: Icon(Icons.edit,color: Colors.white),
        backgroundColor: AppColors.bbibic,
      ),
    );
  }

}

import 'package:bbibic_store/providers/banner_provider.dart';
import 'package:bbibic_store/screens/admin/add_banner/widgets/banner_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_decorations.dart';
import '../../../theme/app_text_styles.dart';
import '../../widgets/my_app_bar.dart';

class AddBannerScreen extends StatelessWidget {
  const AddBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerProvider = Provider.of<BannerProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar.basicAppBar(context, "배너 추가", () {
              bannerProvider.clear();
              Navigator.pop(context);
            }),
            const Expanded(child: BannerImageWidget()),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: 48,
                width: double.infinity,
                decoration: AppDecorations.buttonDecoration(AppColors.bbibic),
                child: MaterialButton(
                  onPressed: () async => bannerProvider.add(context),
                  child: Text("배너 추가하기", style: AppTextStyles.whiteColorB1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

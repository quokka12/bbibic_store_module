import 'package:bbibic_store/screens/goods_detail/widgets/goods_detail_image_widget.dart';
import 'package:bbibic_store/theme/app_colors.dart';
import 'package:bbibic_store/theme/app_decorations.dart';
import 'package:bbibic_store/theme/app_sizes.dart';
import 'package:bbibic_store/theme/app_text_styles.dart';
import 'package:bbibic_store/view_model/goods_detail_tab_bar_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class GoodsDetailTabBar extends StatelessWidget {
  const GoodsDetailTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  goodsDetailTabBarViewModel = Provider.of<GoodsDetailTabBarViewModel>(context);
    return  Column(
      children: [
        _tabBar(goodsDetailTabBarViewModel),
        goodsDetailTabBarViewModel.firstPage ?
            GoodsDetailImageWidget():
            SizedBox(
              height: AppSizes.ratioOfVertical(context, 1) - 200,
              child: Column(
                children: [
                  Lottie.asset("assets/animations/store.json",width: 200, fit: BoxFit.contain),
                  Text("서비스 준비중입니다!",style: AppTextStyles.blackColorB1Bold),
                ],
              )
            ),
      ]
    );
  }
  Widget _tabBar(GoodsDetailTabBarViewModel goodsDetailTabBarViewModel){
      return SizedBox(
        height: 48,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => goodsDetailTabBarViewModel.changePage(),
                child: Container(
                  decoration: goodsDetailTabBarViewModel.firstPage ?
                    AppDecorations.selectedTabBar():
                    BoxDecoration(),
                  alignment: Alignment.center,
                  child: Text(
                    "상품 상세정보",
                    style: goodsDetailTabBarViewModel.firstPage ?
                      AppTextStyles.blackColorB1Bold:
                      AppTextStyles.grey600ColorB1,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => goodsDetailTabBarViewModel.changePage(),
                child: Container(
                  decoration: !goodsDetailTabBarViewModel.firstPage ?
                  AppDecorations.selectedTabBar():
                  BoxDecoration(),
                  alignment: Alignment.center,
                  child: Text(
                    "상품 후기",
                    style: !goodsDetailTabBarViewModel.firstPage ?
                    AppTextStyles.blackColorB1Bold:
                    AppTextStyles.grey600ColorB1,
                  ),
                ),
              )
            ),
          ],
        ),
      );
  }
}

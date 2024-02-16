import 'package:bbibic_store/screens/widgets/company_info_widget.dart';
import 'package:bbibic_store/theme/app_decorations.dart';
import 'package:bbibic_store/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../configs/router/route_names.dart';
import '../../providers/cart_provider.dart';
import '../widgets/my_app_bar.dart';

class MyInfoScreen extends StatelessWidget {
  const MyInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyAppBar.basicAppBar(context, "내 정보", null),
              authInfoHelper(context),
              serviceInfoHelper(context),
              appInfoHelper(context),
              adminInfoHelper(context),
              AppVersionHelper(context),
              const CompanyInfoWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget authInfoHelper(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text("계정 정보", style: AppTextStyles.grey600ColorB2),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(12),
          decoration: AppDecorations.buttonDecoration(Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("TEST@bbibic.com", style: AppTextStyles.blackColorB2),
              Text("01012341234", style: AppTextStyles.blackColorB2),
              Container(
                alignment: Alignment.center,
                child: Text("정보 수정하기", style: AppTextStyles.underline),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget serviceInfoHelper(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 8),
          child: Text("서비스", style: AppTextStyles.grey600ColorB2),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(12),
          decoration: AppDecorations.buttonDecoration(Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () =>
                    context.pushNamed(RouteNames.deliveryAddressManagement),
                child: Text("배송지 관리", style: AppTextStyles.blackColorB1Bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text("구매/배송 목록", style: AppTextStyles.blackColorB1Bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text("찜한 목록", style: AppTextStyles.blackColorB1Bold),
              ),
              TextButton(
                onPressed: () {
                  final cartProvider =
                      Provider.of<CartProvider>(context, listen: false);
                  cartProvider.getData(context);
                  context.pushNamed(RouteNames.cart);
                },
                child: Text("장바구니", style: AppTextStyles.blackColorB1Bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget appInfoHelper(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 8),
          child: Text("정보", style: AppTextStyles.grey600ColorB2),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(12),
          decoration: AppDecorations.buttonDecoration(Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () => context.pushNamed(RouteNames.termOfUser),
                child: Text("서비스 이용약관", style: AppTextStyles.blackColorB1Bold),
              ),
              TextButton(
                onPressed: () => context.pushNamed(RouteNames.privacyPolicy),
                child: Text("개인정보처리방침", style: AppTextStyles.blackColorB1Bold),
              ),
              TextButton(
                onPressed: () => context.pushNamed(RouteNames.serviceCenter),
                child: Text("고객센터", style: AppTextStyles.blackColorB1Bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget adminInfoHelper(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 8),
          child: Text("관리자", style: AppTextStyles.grey600ColorB2),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(12),
          decoration: AppDecorations.buttonDecoration(Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () =>
                      context.pushNamed(RouteNames.goodsManagement),
                  child: Text("상품 관리", style: AppTextStyles.blackColorB1Bold)),
              TextButton(
                  onPressed: () =>
                      context.pushNamed(RouteNames.categoryManagement),
                  child:
                      Text("상품 태그 관리", style: AppTextStyles.blackColorB1Bold)),
              TextButton(
                  onPressed: () {},
                  child: Text("주문 관리", style: AppTextStyles.blackColorB1Bold)),
              TextButton(
                  onPressed: () => context.pushNamed(RouteNames.serviceCenter),
                  child:
                      Text("서비스 문의 관리", style: AppTextStyles.blackColorB1Bold)),
              TextButton(
                  onPressed: () =>
                      context.pushNamed(RouteNames.bannerManagement),
                  child: Text("배너 관리", style: AppTextStyles.blackColorB1Bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget AppVersionHelper(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text("App ver. 1.0.0.", style: AppTextStyles.grey600ColorC1),
    );
  }
}

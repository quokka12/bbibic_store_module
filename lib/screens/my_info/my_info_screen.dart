import 'package:bbibic_store/theme/app_colors.dart';
import 'package:bbibic_store/theme/app_decorations.dart';
import 'package:bbibic_store/theme/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../configs/router/route_names.dart';
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
              MyAppBar.basicAppBar(context,"내 정보", null),
              authInfoHelper(context),
              serviceInfoHelper(context),
              appInfoHelper(context),
              adminInfoHelper(context),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text("App ver. 1.0.0.",style: AppTextStyles.grey600ColorC1),
              ),
              companyInfoHelper(),
            ],
          ),
        ),
      ),
    );
  }

  Widget authInfoHelper(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text("계정 정보",style: AppTextStyles.grey600ColorB2),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(12),
          decoration: AppDecorations.buttonDecoration(Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("TEST@bbibic.com",style: AppTextStyles.blackColorB2),
              Text("01012341234",style: AppTextStyles.blackColorB2),
              Container(
                alignment: Alignment.center,
                child: Text("정보 수정하기",style: AppTextStyles.underline),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget serviceInfoHelper(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20,top: 8),
          child: Text("서비스",style: AppTextStyles.grey600ColorB2),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(12),
          decoration: AppDecorations.buttonDecoration(Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(onPressed: () => context.pushNamed(RouteNames.deliveryAddressManagement), child: Text("배송지 관리",style: AppTextStyles.blackColorB1Bold),),
              TextButton(onPressed: (){}, child: Text("구매/배송 목록",style: AppTextStyles.blackColorB1Bold),),
              TextButton(onPressed: (){}, child: Text("찜한 목록",style: AppTextStyles.blackColorB1Bold),),
              TextButton(onPressed: (){}, child: Text("장바구니",style: AppTextStyles.blackColorB1Bold),),
            ],
          ),
        ),
      ],
    );
  }

  Widget appInfoHelper(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20,top: 8),
          child: Text("정보",style: AppTextStyles.grey600ColorB2),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(12),
          decoration: AppDecorations.buttonDecoration(Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(onPressed: () => context.pushNamed(RouteNames.termOfUser), child: Text("서비스 이용약관",style: AppTextStyles.blackColorB1Bold)),
              TextButton(onPressed: () => context.pushNamed(RouteNames.privacyPolicy), child: Text("개인정보처리방침",style: AppTextStyles.blackColorB1Bold)),
              TextButton(onPressed: () => context.pushNamed(RouteNames.serviceCenter), child: Text("고객센터",style: AppTextStyles.blackColorB1Bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget adminInfoHelper(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20,top: 8),
          child: Text("관리자",style: AppTextStyles.grey600ColorB2),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(12),
          decoration: AppDecorations.buttonDecoration(Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(onPressed: () => context.pushNamed(RouteNames.goodsManagement), child: Text("상품 관리",style: AppTextStyles.blackColorB1Bold)),
              TextButton(onPressed: () => context.pushNamed(RouteNames.categoryManagement), child: Text("상품 태그 관리",style: AppTextStyles.blackColorB1Bold)),
              TextButton(onPressed: () {}, child: Text("주문 관리",style: AppTextStyles.blackColorB1Bold)),
              TextButton(onPressed: () => context.pushNamed(RouteNames.serviceCenter), child: Text("서비스 문의 관리",style: AppTextStyles.blackColorB1Bold)),
              TextButton(onPressed: () => context.pushNamed(RouteNames.bannerManagement), child: Text("배너 관리",style: AppTextStyles.blackColorB1Bold)),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget companyInfoHelper(){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text("(주)에스지엘 | 대표 김선명",style: AppTextStyles.grey600ColorC1),
            Text("사업자등록번호 : 537-86-02993",style: AppTextStyles.grey600ColorC1),
            Text("주소 : 서울시 서초구 남부순환로 2497",style: AppTextStyles.grey600ColorC1),
            Text("통신판매 : 제 2023-서울서초-3702호",style: AppTextStyles.grey600ColorC1),
            Text("FAX : 0504-423-0034 | EMAIL : bb@bbibic.com",style: AppTextStyles.grey600ColorC1),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

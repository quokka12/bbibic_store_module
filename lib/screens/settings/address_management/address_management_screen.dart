import 'package:bbibic_store/screens/widgets/my_app_bar.dart';
import 'package:bbibic_store/screens/widgets/my_dialog.dart';
import 'package:bbibic_store/theme/app_colors.dart';
import 'package:bbibic_store/theme/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../configs/router/route_names.dart';
import '../../../models/address.dart';
import '../../../providers/address_provider.dart';
import '../../../theme/app_decorations.dart';
import '../../../theme/app_text_styles.dart';
import '../../../util/format_util.dart';

class AddressManagementScreen extends StatelessWidget {
  const AddressManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyAppBar.basicAppBar(context, "배송지 관리", null),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: AppDecorations.buttonDecoration(Colors.white),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("본가 우리집", style: AppTextStyles.blackColorS2Bold),
                      SizedBox(height: 4),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.bbibic, width: 1),
                        ),
                        child:
                            Text("기본 배송지", style: AppTextStyles.blackColorC2),
                      ),
                      SizedBox(height: 4),
                      Text("서울시 중랑구 중랑천로 43 신성아파트",
                          style: AppTextStyles.blackColorB2),
                      Text("102동 901호", style: AppTextStyles.blackColorB2),
                      SizedBox(height: 4),
                      Text("공동 현관 비밀번호 : #****",
                          style: AppTextStyles.grey600ColorC1),
                    ],
                  ),
                ),
              ),
              for (Address address in addressProvider.addressList) ...[
                _AddressCardHelper(context, addressProvider, address),
              ]
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(RouteNames.addAddress),
        label: Text("배송지 추가하기", style: AppTextStyles.whiteColorB1),
        icon: const Icon(
          Icons.add_home_outlined,
          color: Colors.white,
        ),
        backgroundColor: AppColors.bbibic,
      ),
    );
  }

  Widget _AddressCardHelper(
      BuildContext context, AddressProvider addressProvider, Address address) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: AppDecorations.buttonDecoration(Colors.white),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(address.addressName,
                        style: AppTextStyles.blackColorS2Bold),
                    SizedBox(width: 12),
                    GestureDetector(
                      child: Text(
                        "기본 배송지로 설정",
                        style: AppTextStyles.underlineC1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                SizedBox(
                  width: AppSizes.ratioOfHorizontal(context, 1) - 100,
                  child:
                      Text(address.address, style: AppTextStyles.blackColorB2),
                ),
                SizedBox(
                  width: AppSizes.ratioOfHorizontal(context, 1) - 100,
                  child: Text(address.detailedAddress,
                      style: AppTextStyles.blackColorB2),
                ),
                SizedBox(height: 4),
                Text(
                    "공동 현관 비밀번호 : ${FormatUtil.securityFormat(address.securityCode)}",
                    style: AppTextStyles.grey600ColorC1),
              ],
            ),
            IconButton(
              onPressed: () => MyDialog.addressDeleteDialog(
                  context, addressProvider, address.addressId),
              icon: Icon(Icons.delete_outline_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

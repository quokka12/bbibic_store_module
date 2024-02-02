import 'package:bbibic_store/screens/widgets/my_app_bar.dart';
import 'package:bbibic_store/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeliveryAddressManagementScreen extends StatelessWidget {
  const DeliveryAddressManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar.basicAppBar(context, "배송지 관리", null),
          ],
        ),
      ),
    );
  }
}

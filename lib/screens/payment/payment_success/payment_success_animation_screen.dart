import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../configs/router/route_names.dart';
import '../../../theme/app_sizes.dart';

class PaymentSuccessAnimationScreen extends StatefulWidget {
  const PaymentSuccessAnimationScreen({super.key});

  @override
  State<PaymentSuccessAnimationScreen> createState() =>
      _PaymentSuccessAnimationScreenState();
}

class _PaymentSuccessAnimationScreenState
    extends State<PaymentSuccessAnimationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 2500), () {
      context.goNamed(RouteNames.paymentSuccess);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future(() => false); //뒤로가기 막음
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Lottie.asset(
              'assets/animations/payment_success.json',
              width: AppSizes.ratioOfHorizontal(context, 1),
              repeat: false,
              fit: BoxFit.contain,
            ),
          ),
        ));
  }
}

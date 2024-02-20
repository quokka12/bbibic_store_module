import 'package:bbibic_store/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentInProgressScreen extends StatefulWidget {
  const PaymentInProgressScreen({super.key});

  @override
  State<PaymentInProgressScreen> createState() =>
      _PaymentInProgressScreenState();
}

class _PaymentInProgressScreenState extends State<PaymentInProgressScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("assets/animations/payment_in_progress.json",
                  width: 160, fit: BoxFit.contain),
              Text("결제 진행중입니다...", style: AppTextStyles.blackColorB1),
            ],
          ),
        ),
      ),
    );
  }
}

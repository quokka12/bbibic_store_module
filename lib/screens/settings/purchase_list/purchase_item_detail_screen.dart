import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/order_provider.dart';
import '../../../theme/app_decorations.dart';
import '../../../theme/app_text_styles.dart';
import '../../../util/format_util.dart';
import '../../widgets/my_app_bar.dart';

class PurchaseItemDetailScreen extends StatelessWidget {
  const PurchaseItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar.basicAppBar(context, "결제 완료", null),
            Expanded(child: goodsListHelper(context)),
          ],
        ),
      ),
    );
  }

  Widget goodsListHelper(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "받는 사람",
              style: AppTextStyles.blackColorB1Bold,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: AppDecorations.buttonDecoration(Colors.white),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(orderProvider.order.recipientName,
                      style: AppTextStyles.blackColorS2Bold),
                  const SizedBox(height: 4),
                  Text(orderProvider.order.recipientPhone,
                      style: AppTextStyles.blackColorB2),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text("배송지 정보", style: AppTextStyles.blackColorB1Bold),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: AppDecorations.buttonDecoration(Colors.white),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "${orderProvider.order.recipientAddress["addressName"]}",
                          style: AppTextStyles.blackColorS2Bold)
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text("${orderProvider.order.recipientAddress["address"]}",
                      style: AppTextStyles.blackColorB2),
                  Text(
                      "${orderProvider.order.recipientAddress["detailedAddress"]}",
                      style: AppTextStyles.blackColorB2),
                  const SizedBox(height: 4),
                  Text(
                      "공동 현관 비밀번호 : ${FormatUtil.securityFormat("${orderProvider.order.recipientAddress["securityCode"]}")}",
                      style: AppTextStyles.grey600ColorC1),
                  const SizedBox(height: 12),
                  Text("추가 요청사항 : ${orderProvider.order.request}",
                      style: AppTextStyles.grey600ColorC1),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "주문 상품",
                  style: AppTextStyles.blackColorB1Bold,
                ),
                const SizedBox(width: 8),
                Text(
                  "${orderProvider.order.goodsList.length}",
                  style: AppTextStyles.bbibicColorS1Bold,
                )
              ],
            ),
            const SizedBox(height: 8),
            for (int i = 0; i < orderProvider.order.goodsList.length; i++) ...[
              _cardHelper(context, orderProvider, i),
            ],
            Row(
              children: [
                Text("총 결제 금액", style: AppTextStyles.blackColorB2),
                const Spacer(),
                Text(FormatUtil.priceFormat(orderProvider.order.totalPrice),
                    style: AppTextStyles.blackColorH1Bold),
              ],
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "주문 취소 신청",
                style: AppTextStyles.underlineGrey600C1,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _cardHelper(
      BuildContext context, OrderProvider orderProvider, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: AppDecorations.buttonDecoration(Colors.white),
        width: double.infinity,
        child: Row(
          children: [
            Image.network(
              orderProvider.order.goodsList[index]["goodsImage"]!,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(orderProvider.order.goodsList[index]["goodsName"]!,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.blackColorS2Bold),
                  Text(
                      FormatUtil.priceFormat(
                          orderProvider.order.goodsList[index]["goodsPrice"]!),
                      style: AppTextStyles.blackColorB2),
                ],
              ),
            ),
            Text("${orderProvider.order.goodsList[index]["count"]}개"),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}

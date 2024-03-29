import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../configs/router/route_names.dart';
import '../../../models/order.dart';
import '../../../providers/order_provider.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_sizes.dart';
import '../../../theme/app_text_styles.dart';
import '../../../util/format_util.dart';
import '../../widgets/my_app_bar.dart';

class PurchaseListScreen extends StatelessWidget {
  const PurchaseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar.basicAppBar(context, '구매/배송 목록', null),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    for (Order order in orderProvider.orderList) ...[
                      GestureDetector(
                        onTap: () {
                          orderProvider.set(order);
                          context.pushNamed(RouteNames.purchaseItemDetail);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          order.recipientName,
                                          style: AppTextStyles.blackColorB1Bold,
                                        ),
                                        Text(
                                          order.recipientPhone,
                                          style: AppTextStyles.blackColorB1,
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.navigate_next_rounded,
                                        size: 36),
                                  ],
                                ),
                                Text(
                                  "배송 준비중",
                                  style: AppTextStyles.redColorB1,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "주소 : ",
                                      style: AppTextStyles.blackColorB2,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          order.recipientAddress["address"]!,
                                          style: AppTextStyles.blackColorB2,
                                        ),
                                        Text(
                                          order.recipientAddress[
                                              "detailedAddress"]!,
                                          style: AppTextStyles.blackColorB2,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  "요청사항 : ${order.request}",
                                  style: AppTextStyles.blackColorB2,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "구매 목록",
                                  style: AppTextStyles.blackColorB1Bold,
                                ),
                                const SizedBox(height: 8),
                                for (Map<String, dynamic> goods
                                    in order.goodsList) ...[
                                  Row(
                                    children: [
                                      Image.network(
                                        goods["goodsImage"],
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.contain,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(goods["goodsName"],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyles
                                                        .blackColorB2Bold),
                                                Text(
                                                    FormatUtil.priceFormat(
                                                        goods["goodsPrice"]),
                                                    style: AppTextStyles
                                                        .blackColorC1),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "${goods["count"]} 개",
                                          style: AppTextStyles.blackColorB2Bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 1,
                                    width:
                                        AppSizes.ratioOfHorizontal(context, 1),
                                    decoration: const BoxDecoration(
                                        color: AppColors.grey300),
                                  ),
                                ],
                                const SizedBox(height: 20),
                                Text(
                                  "총 결제 금액 : ${FormatUtil.priceFormat(order.totalPrice)}",
                                  style: AppTextStyles.blackColorB2Bold,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "결제 일자 : ${order.orderDate}",
                                  style: AppTextStyles.grey600ColorC1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

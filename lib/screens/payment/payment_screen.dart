import 'package:bbibic_store/providers/goods_provider.dart';
import 'package:bbibic_store/providers/order_provider.dart';
import 'package:bbibic_store/theme/app_sizes.dart';
import 'package:bbibic_store/util/toast_util.dart';
import 'package:bootpay/model/payload.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../configs/router/route_names.dart';
import '../../models/goods.dart';
import '../../models/order.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_decorations.dart';
import '../../theme/app_text_styles.dart';
import '../../util/date_util.dart';
import '../../util/format_util.dart';
import '../widgets/my_app_bar.dart';

class PayMentScreen extends StatefulWidget {
  PayMentScreen({super.key});

  @override
  State<PayMentScreen> createState() => _PayMentScreenState();
}

class _PayMentScreenState extends State<PayMentScreen> {
  Payload payload = Payload();
  final controllerRequest = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerRequest.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyAppBar.basicAppBar(context, "결제하기", null),
                goodsListHelper(context),
                _buyButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget goodsListHelper(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "받는 사람",
            style: AppTextStyles.blackColorB1Bold,
          ),
          SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: AppDecorations.buttonDecoration(Colors.white),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("김삐빅", style: AppTextStyles.blackColorS2Bold),
                    SizedBox(height: 4),
                    Text("01046850272", style: AppTextStyles.blackColorB2),
                  ],
                ),
                Icon(Icons.navigate_next_rounded, size: 28),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text("배송지 정보", style: AppTextStyles.blackColorB1Bold),
          SizedBox(height: 8),
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
                    Text("본가 우리집", style: AppTextStyles.blackColorS2Bold),
                    GestureDetector(
                      onTap: () => context
                          .pushNamed(RouteNames.deliveryAddressManagement),
                      child: Text("변경하기", style: AppTextStyles.underline),
                    )
                  ],
                ),
                SizedBox(height: 4),
                Text("서울시 서초구 남부순환로 2497", style: AppTextStyles.blackColorB2),
                Text("801호", style: AppTextStyles.blackColorB2),
                SizedBox(height: 4),
                Text("공동 현관 비밀번호 : #****", style: AppTextStyles.grey600ColorC1),
                SizedBox(height: 12),
                _requestHelper(),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "주문 상품",
                style: AppTextStyles.blackColorB1Bold,
              ),
              SizedBox(width: 8),
              Text(
                "${orderProvider.totalCount}",
                style: AppTextStyles.bbibicColorS1Bold,
              )
            ],
          ),
          SizedBox(height: 8),
          for (int i = 0; i < orderProvider.orderCartList.length; i++) ...[
            _cardHelper(context, orderProvider, i),
          ],
          Row(
            children: [
              Text("총 결제 예상 금액", style: AppTextStyles.blackColorB2),
              const Spacer(),
              Text(FormatUtil.priceFormat(orderProvider.order.totalPrice),
                  style: AppTextStyles.blackColorH1Bold),
            ],
          ),
        ],
      ),
    );
  }

  Widget _requestHelper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("추가 요청사항", style: AppTextStyles.blackColorB2),
        const SizedBox(height: 4),
        TextFormField(
          decoration: InputDecoration(
              hintText: "추가 요청사항을 입력해주세요.",
              hintStyle: AppTextStyles.grey600ColorB2),
          style: AppTextStyles.blackColorB2,
          controller: controllerRequest,
          minLines: 5,
          maxLines: 5,
          validator: (value) {
            if (value.toString().isEmpty) {
              return '추가 요청사항을 입력해주세요.';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _cardHelper(
      BuildContext context, OrderProvider orderProvider, int index) {
    final goodsProvider = Provider.of<GoodsProvider>(context);
    Goods goods =
        goodsProvider.searchById(orderProvider.orderCartList[index].goodsId);
    final List<String> items = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: AppDecorations.buttonDecoration(Colors.white),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              goods.thumbnailImages![0],
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: AppSizes.ratioOfHorizontal(context, 1) - 164,
                      child: Text("${goods.goodsName}",
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.blackColorS2Bold),
                    ),
                    Text(FormatUtil.priceFormat(goods.goodsPrice!),
                        style: AppTextStyles.blackColorB2),
                    Row(
                      children: [
                        if (goods.categoryId != null) ...[
                          for (String category in goods.categoryId!) ...[
                            Text(" #$category",
                                style: AppTextStyles.grey600ColorC1),
                          ]
                        ]
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: 76,
                  child: DropdownButtonFormField2<String>(
                    value: "${orderProvider.orderCartList[index].count}",
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    hint: Text('0', style: AppTextStyles.blackColorS2Bold),
                    items: items
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: AppTextStyles.blackColorS2Bold,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        orderProvider.changeCount(index, int.parse(value!)),
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.only(right: 8),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 24,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buyButton(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: AppDecorations.buttonDecoration(AppColors.bbibic),
        child: MaterialButton(
          onPressed: () {
            List<Map<String, dynamic>> goodsList = [];
            for (int i = 0; i < orderProvider.orderCartList.length; i++) {
              goodsList.add(orderProvider.orderCartList[i].toMap());
            }
            orderProvider.set(
              Order(
                orderId: '',
                userId: 'test',
                goodsList: goodsList,
                recipientName: '김삐빅',
                recipientAddress: {
                  "addressId": "test",
                  "userId": "test",
                  "addressName": "회사",
                  "address": "서울시 서초구 남부순환로 2497",
                  "detailedAddress": "801호",
                  "securityCode": "#*2231",
                },
                recipientPhone: '01046850272',
                request: controllerRequest.text,
                totalPrice: orderProvider.order.totalPrice,
                orderDate: DateUtil.getToday(),
              ),
            );
            if (orderProvider.order.totalPrice == 0) {
              ToastUtil.basic("구매할 상품이 존재하지 않습니다.");
            } else {
              orderProvider.bootpayTest(context);
            }
          },
          child: Text("구매하기", style: AppTextStyles.whiteColorB1),
        ),
      ),
    );
  }
}

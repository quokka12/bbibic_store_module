import 'package:bbibic_store/database/firebase/order_firebase.dart';
import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/item.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../configs/router/route_names.dart';
import '../models/cart.dart';
import '../models/goods.dart';
import '../models/order.dart';
import '../theme/app_text_styles.dart';
import 'goods_provider.dart';

class OrderProvider with ChangeNotifier {
  List<Goods> goodsList = [];
  List<Order> orderList = [];
  List<Cart> orderCartList = [];
  Order order = Order(
    orderId: '',
    userId: '',
    goodsList: [],
    recipientName: '',
    recipientAddress: {},
    recipientPhone: '',
    request: '',
    totalPrice: 0,
    orderDate: '',
  );
  int totalCount = 0;
  OrderProvider(BuildContext context) {
    getSelectedItemCount();
    getSelectedItemPrice();
    refresh(context);
  }
  Future add(BuildContext context) async {
    await OrderFirebase.add(context, order);
  }

  Future<List<Order>> getData(BuildContext context,
      {String userId = 'test'}) async {
    Logger().i("data");
    return await OrderFirebase.getData(context, userId);
  }

  void refresh(BuildContext context) {
    getData(context).then((orderList) {
      this.orderList = orderList;
      notifyListeners();
    });
  }

  void setOrderCart(List<Cart> orderCartList) {
    this.orderCartList = orderCartList;
    getSelectedItemCount();
    getSelectedItemPrice();
    notifyListeners();
  }

  void changeCount(int index, int count) {
    orderCartList[index].count = count;
    getSelectedItemCount();
    getSelectedItemPrice();
    notifyListeners();
  }

  void getSelectedItemCount() {
    int total = 0;
    for (Cart cart in orderCartList) {
      if (cart.isSelected) {
        total += cart.count;
      }
    }
    totalCount = total;
  }

  void getSelectedItemPrice() {
    int total = 0;
    for (Cart cart in orderCartList) {
      if (cart.isSelected) {
        total += cart.goodsPrice * cart.count;
      }
    }
    order.totalPrice = total;
  }

  void set(Order order) {
    this.order = order;
    notifyListeners();
  }

  void bootpayTest(BuildContext context) {
    bool isSuccess = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
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
        });
    Payload payload = getPayload(context);
    if (kIsWeb) {
      payload.extra?.openType = "iframe";
    }
    Bootpay().requestPayment(
      context: context,
      payload: payload,
      showCloseButton: false,
      // closeButton: Icon(Icons.close, size: 35.0, color: Colors.black54),
      onCancel: (String data) {
        print('------- onCancel: $data');
      },
      onError: (String data) {
        print('------- onError: $data');
      },
      onClose: () async {
        print('------- onClose');
        Bootpay().dismiss(context); //명시적으로 부트페이 뷰 종료 호출
        //TODO - 원하시는 라우터로 페이지 이동
        if (isSuccess) {
          await add(context);
          refresh(context);
          context.goNamed(RouteNames.paymentSuccessAnimation);
        } else {
          Navigator.pop(context);
        }
      },
      onIssued: (String data) {
        print('------- onIssued: $data');
      },
      onConfirm: (String data) {
        print('------- onConfirm: $data');

        /**
            1. 바로 승인하고자 할 때
            return true;
         **/
        /***
            2. 비동기 승인 하고자 할 때
            checkQtyFromServer(data);
            return false;
         ***/
        /***
            3. 서버승인을 하고자 하실 때 (클라이언트 승인 X)
            return false; 후에 서버에서 결제승인 수행
         */
        // checkQtyFromServer(data);
        return true;
      },
      onDone: (String data) async {
        print('------- onDone: $data');
        isSuccess = true;
      },
    );
  }

  Payload getPayload(BuildContext context) {
    final goodsProvider = Provider.of<GoodsProvider>(context, listen: false);
    String androidApplicationId = '65d2d3c5e57a7e001de3725b';
    Payload payload = Payload();

    List<Item> itemList = [];
    for (Cart cart in orderCartList) {
      Goods goods = goodsProvider.searchById(cart.goodsId);
      Item item = Item();
      item.name = goods.goodsName; // 주문정보에 담길 상품명
      item.qty = cart.count; // 해당 상품의 주문 수량
      item.id = cart.goodsId; // 해당 상품의 고유 키
      item.price = 500; //cart.goodsPrice * 1.0; // 상품의 가격
      itemList.add(item);
    }

    payload.androidApplicationId =
        androidApplicationId; // android application id

    payload.pg = 'KCP';
    // payload.method = '카드';
    payload.orderName = "삐빅 쇼핑몰"; //결제할 상품명
    payload.price = 1000; //order.totalPrice * 1.0; //정기결제시 0 혹은 주석

    payload.orderId = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); //주문번호, 개발사에서 고유값으로 지정해야함

    payload.metadata = {
      "callbackParam1": "value12",
      "callbackParam2": "value34",
      "callbackParam3": "value56",
      "callbackParam4": "value78",
    }; // 전달할 파라미터, 결제 후 되돌려 주는 값
    payload.items = itemList; // 상품정보 배열

    User user = User(); // 구매자 정보
    user.username = "김삐빅";
    user.email = "bb11@bbibic.com";
    user.area = "서울";
    user.phone = "010-1234-5678";
    user.addr = '서울시 동작구 상도로 222';

    Extra extra = Extra(); // 결제 옵션
    extra.appScheme = 'bootpayFlutterExample';
    extra.cardQuota = '3';
    // extra.openType = 'popup';

    payload.user = user;
    payload.extra = extra;
    return payload;
  }
}

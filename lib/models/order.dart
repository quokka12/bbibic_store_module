import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class Order {
  String orderId = '';
  String userId = '';
  List<Map<String, dynamic>> goodsList = [];
  String recipientName = '';
  Map<String, String> recipientAddress = {};
  String recipientPhone = '';
  String request = '';
  int totalPrice = 0;
  String orderDate = '';

  Order({
    required this.orderId,
    required this.userId,
    required this.goodsList,
    required this.recipientName,
    required this.recipientAddress,
    required this.recipientPhone,
    required this.request,
    required this.totalPrice,
    required this.orderDate,
  });

  // 파이어베이스에 저장하기 위해 Map타입으로 바꿔준다.
  Map<String, dynamic> toMap(String orderId) {
    return {
      "orderId": orderId,
      "userId": userId,
      "goodsList": goodsList,
      "recipientName": recipientName,
      "recipientAddress": recipientAddress,
      "recipientPhone": recipientPhone,
      "request": request,
      "totalPrice": totalPrice,
      "orderDate": orderDate,
    };
  }

  // 파이어베이스에서 가져온 Map타입을 풀어준다.
  factory Order.fromMap(Map<String, dynamic> map) {
    Logger().i(map);
    if (map == null)
      return Order(
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
    return Order(
      orderId: map['orderId'],
      userId: map['userId'],
      goodsList: List<Map<String, dynamic>>.from(map['goodsList']),
      recipientName: map['recipientName'],
      recipientAddress: Map<String, String>.from(map['recipientAddress']),
      recipientPhone: map['recipientPhone'],
      request: map['request'] ?? "없음",
      totalPrice: map['totalPrice'],
      orderDate: map['orderDate'],
    );
  }

  // 파이어베이스에서 가져온 documentSnapshot을 풀어준다.
  factory Order.fromSnapshot(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot == null)
      return Order(
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
    return Order(
      orderId: documentSnapshot['orderId'],
      userId: documentSnapshot['userId'],
      goodsList: documentSnapshot['goodsList'],
      recipientName: documentSnapshot['recipientName'],
      recipientAddress: documentSnapshot['name'],
      recipientPhone: documentSnapshot['recipientPhone'],
      request: documentSnapshot['request'],
      totalPrice: documentSnapshot['totalPrice'],
      orderDate: documentSnapshot['orderDate'],
    );
  }
}

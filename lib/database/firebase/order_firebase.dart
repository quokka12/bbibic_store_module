import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../models/order.dart' as order;
import '../../providers/network_provider.dart';

class OrderFirebase {
  OrderFirebase._();
  static CollectionReference<Map<String, dynamic>> _collectionReference =
      FirebaseFirestore.instance.collection("orders");

  /* 데이터 추가 */
  static Future add(BuildContext context, order.Order order) async {
    bool isSuccess = false;
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false)
        .checkNetwork();

    // 인터넷 상태 확인
    if (!isNetwork) return;

    DocumentReference docRef = _collectionReference.doc();

    await docRef.set(order.toMap(docRef.id)).then((value) {
      Logger().i("데이터베이스 저장 성공!");
      isSuccess = true;
    }).onError((e, stackTrace) {
      Logger().e("데이터베이스 저장 실패! \n $e");
    });

    return isSuccess;
  }

  /* 데이터 가져오기 */
  /// @return User
  static Future<List<order.Order>> getData(
      BuildContext context, String uid) async {
    List<order.Order> addressList = [];
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false)
        .checkNetwork();
    try {
      // 인터넷 상태 확인
      if (!isNetwork) return addressList;
      await _collectionReference.where("userId", isEqualTo: "test").get().then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            final data = docSnapshot.data();
            addressList.add(order.Order.fromMap(data));
          }
        },
      );
    } catch (e) {
      Logger().e(e);
    }
    return addressList;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../models/address.dart';
import '../../providers/network_provider.dart';

class AddressFirebase {
  AddressFirebase._();

  //파이어베이스 "address" path 선언
  static CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection("deliveryAddress");

  /* 데이터 추가 */
  static Future<bool> add(BuildContext context, Address address) async {
    bool isSuccessed = false;
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false)
        .checkNetwork();
    try {
      // 인터넷 상태 확인
      if (!isNetwork) return isSuccessed;
      Logger().e("데이터베이스 저장 시작");
      // 파이어베이스 접근 시도
      DocumentReference docRef = collectionReference.doc();
      await docRef.set(address.toMap(docRef.id)).then((value) {
        Logger().i("데이터베이스 저장 성공!");
        // TODO : 저장성공 시 행동
        isSuccessed = true;
      }).onError((error, stackTrace) {
        Logger().e("데이터베이스 저장 실패! \n $error");
      });
    } catch (e) {
      Logger().e(e);
    }

    return isSuccessed;
  }

  /* 데이터 가져오기 */
  /// @return User
  static Future<List<Address>> getData(BuildContext context, String uid) async {
    List<Address> addressList = [];
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false)
        .checkNetwork();
    try {
      // 인터넷 상태 확인
      if (!isNetwork) return addressList;

      await collectionReference.where("userId", isEqualTo: uid).get().then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            final data = docSnapshot.data();
            addressList.add(Address.fromMap(data));
          }
        },
        onError: (e) => Logger().e("Error completing: $e"),
      );
    } catch (e) {
      Logger().e(e);
    }
    return addressList;
  }

  /* 데이터 삭제 */
  static Future<bool> delete(BuildContext context, String id) async {
    bool isSuccessed = false;
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false)
        .checkNetwork();
    try {
      // 인터넷 상태 확인
      if (!isNetwork) return false;
      DocumentReference docRef = collectionReference.doc(id);
      await docRef.delete().then((doc) {
        Logger().i("성공");
        isSuccessed = true;
      });
    } catch (e) {
      Logger().e(e);
    }
    return isSuccessed;
  }
}

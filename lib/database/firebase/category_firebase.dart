import 'package:bbibic_store/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../providers/network_provider.dart';

class CategoryFirebase{
  CategoryFirebase._();

  //파이어베이스 "users" path 선언
  static CollectionReference<Map<String, dynamic>> collectionReference =
  FirebaseFirestore.instance.collection("category");

  /* 데이터 추가 */
  static Future add(BuildContext context, Category category) async {
    bool isSuccessed = false;
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false).checkNetwork();
    try {
      // 인터넷 상태 확인
      if (!isNetwork) return;
      Logger().e("데이터베이스 저장 시작");
      // 파이어베이스 접근 시도
      DocumentReference docRef = collectionReference.doc(category.name);
      await docRef.set(category.toMap(category.name??"")).then((value) {
        Logger().i("데이터베이스 저장 성공!");
        // TODO : 저장성공 시 행동
        isSuccessed = true;
      }).onError((error, stackTrace) {
        Logger().i("데이터베이스 저장 실패! \n $error");
      });
    } catch (e) {
      Logger().e(e);
    }

    return isSuccessed;
  }

  /* 데이터 가져오기 */
  /// @return User
  static Future<List<String>> getData(BuildContext context) async {
    List<String> categoryList= [];
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false).checkNetwork();
    try {
      // 인터넷 상태 확인
      if (!isNetwork) return categoryList;
      await collectionReference.get().then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            categoryList.add(docSnapshot['name']);
          }
        },
        onError: (e) => Logger().e("Error completing: $e"),
      );
    } catch (e) {
      Logger().e(e);
    }
    return categoryList;
  }
  Stream<List<String>> getCategoryListStream(BuildContext context) {
    return Stream.fromFuture(getData(context));
  }

  /* 데이터 삭제 */
  static Future<bool> delete(BuildContext context, String name) async {
    bool isSuccessed = false;
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false).checkNetwork();
    try {
      // 인터넷 상태 확인
      if (!isNetwork) return false;
      DocumentReference docRef = collectionReference.doc(name);
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
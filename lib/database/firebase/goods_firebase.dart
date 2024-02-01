import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../models/goods.dart';
import '../../providers/network_provider.dart';

class GoodsFirebase {
  static CollectionReference<Map<String, dynamic>> _collectionReference =
  FirebaseFirestore.instance.collection("goods");

  static final storage = FirebaseStorage.instance;

  /* 데이터 추가 */
  static Future add(BuildContext context, Goods goods, List<File?> thumbnailImageList,
      List<File?> detailImageList) async {
    bool isSuccess = false;
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false)
        .checkNetwork();
      // 인터넷 상태 확인
      if (!isNetwork) return;
      Logger().e(thumbnailImageList);
      DocumentReference docRef = _collectionReference.doc();
      //Storage에 사진 저장
      for (int i = 0; i < thumbnailImageList.length; i++) {
        await _uploadImageFile(
            docRef.id, 'thumbnailImage$i', thumbnailImageList[i]!).then((value) {
          if (value != null) {
            goods.thumbnailImages?.add(value);
          }
        });
      }
    for (int i = 0; i < detailImageList.length; i++) {
      await _uploadImageFile(
          docRef.id, 'detailImage$i', detailImageList[i]!).then((value) {
        if (value != null) {
          goods.detailImages?.add(value);
        }
      });
    }
      if (goods.detailImages != null){
        Logger().i(goods.detailImages!);
        await docRef.set(goods.toMap(docRef.id)).then((value) {
          Logger().i("데이터베이스 저장 성공!");
          isSuccess = true;
        }).onError((e, stackTrace) {
          Logger().e("데이터베이스 저장 실패! \n $e");
        });
      }

    return isSuccess;
  }

  /* 모든 데이터 가져오기 */
  static Future<List<Goods>> getData(BuildContext context) async {
    List<Goods> goodsList = [];
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false)
        .checkNetwork();
    try {
      // 인터넷 상태 확인
      if (!isNetwork) return goodsList;

      await _collectionReference.orderBy("createdDate").get().then(
            (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            if (docSnapshot.data() == null) {
              return Goods(status: true);
            }
            final data = docSnapshot.data();
            Logger().i(data);
            goodsList.add(Goods.fromMap(data));
          }

        },
        onError: (e) => Logger().e("Error completing: $e"),
      );
    } catch (e) {
      Logger().e(e);
    }
    return goodsList;
  }
  static Stream<List<Goods>> getDataForStream(BuildContext context) {
    return Stream.fromFuture(getData(context));
  }
  /* 최신순 데이터 가져오기 */
  static Future<List<Goods>> getDataSortByCreatedDate(BuildContext context) async {
    List<Goods> goodsList = [];
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false)
        .checkNetwork();
    try {
      // 인터넷 상태 확인
      if (!isNetwork) return goodsList;

      await _collectionReference.where('status',isEqualTo: true).orderBy("createdDate").get().then(
            (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            if (docSnapshot.data() == null) {
              return Goods(status: true);
            }
            final data = docSnapshot.data();
            Logger().i(data);
            goodsList.add(Goods.fromMap(data));
          }

        },
        onError: (e) => Logger().e("Error completing: $e"),
      );
    } catch (e) {
      Logger().e(e);
    }
    return goodsList;
  }
  /* 인기순 데이터 가져오기 */
  static Future<List<Goods>> getDataSortByPopularity(BuildContext context) async {
    List<Goods> goodsList = [];
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false)
        .checkNetwork();
    try {
      // 인터넷 상태 확인
      if (!isNetwork) return goodsList;

      await _collectionReference.where('status',isEqualTo: true).orderBy("goodsSell").get().then(
            (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            if (docSnapshot.data() == null) {
              return Goods(status: true);
            }
            final data = docSnapshot.data();
            Logger().i(data);
            goodsList.add(Goods.fromMap(data));
          }

        },
        onError: (e) => Logger().e("Error completing: $e"),
      );
    } catch (e) {
      Logger().e(e);
    }
    return goodsList;
  }
  static Stream<List<Goods>> getDataSortByPopularityForStream(BuildContext context) {
    return Stream.fromFuture(getDataSortByPopularity(context));
  }
  /* 판매여부 변경 */
  static Future changeStatus(BuildContext context, String goodsId, bool status) async {
    bool isSuccessed = false;
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false)
        .checkNetwork();
    try {
      // 인터넷 상태 확인
      if (!isNetwork) return;

      DocumentReference docRef = _collectionReference.doc(goodsId);
      await docRef.update({"status" : status}).then((doc) {
        Logger().i("데이터베이스 저장 성공!");
        // TODO : 저장성공 시 행동
        isSuccessed = true;
      });
    } catch (e) {
      Logger().e(e);
    }
    return isSuccessed;
  }
  /* 데이터 삭제 */
  static Future delete(BuildContext context, Goods goods) async {
    bool isSuccessed = false;
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false)
        .checkNetwork();
    try {
      // 인터넷 상태 확인
      if (!isNetwork) return;

      //파이어스토리지에 있는 이미지 파일 삭제
      final storageRef = storage.ref();

      //썸네일 이미지 삭제
      for (int i = 0; i < goods.thumbnailImages!.length; i++) {
        final ref = storageRef.child(
            "goods/${goods.goodsId}/thumbnailImage$i.jpg");
        await ref.delete();
      }
      //상세 이미지 삭제
      for (int i = 0; i < goods.detailImages!.length; i++) {
        final ref = storageRef.child(
            "goods/${goods.goodsId}/detailImage$i.jpg");
        await ref.delete();
      }

      DocumentReference docRef = _collectionReference.doc(goods.goodsId);
      await docRef.delete().then((doc) {
        Logger().i("데이터베이스 삭제 성공!");
        // TODO : 저장성공 시 행동
        isSuccessed = true;
      });
    } catch (e) {
      Logger().e(e);
    }
    return isSuccessed;
  }

  static Future _uploadImageFile(String goodsId, String fileType, File file) async {
    try {
      final storageRef = storage.ref();
      final mountainsRef =
      storageRef.child('goods/$goodsId').child('/$fileType.jpg'); //사진 저장 경로
      //Storage에 사진 저장
      UploadTask uploadTask = mountainsRef.putFile(file);

      //해당하는 사진 종류를 찾아 url변수 저장
      String url = await (await uploadTask).ref.getDownloadURL();
      return url;
    } catch (e) {
      Logger().e("데이터베이스 저장 실패! \n $e");
    }

  }
}

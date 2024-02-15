import 'dart:io';

import 'package:bbibic_store/util/date_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../models/ad_banner.dart';
import '../../models/goods.dart';
import '../../providers/network_provider.dart';

class BannerFirebase {
  BannerFirebase._();

  static final CollectionReference<Map<String, dynamic>> _collectionReference =
  FirebaseFirestore.instance.collection("banners");

  static final storage = FirebaseStorage.instance;

  /* 데이터 추가 */
  static Future add(BuildContext context, AdBanner adBanner, File? image) async {
    bool isSuccess = false;
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false)
        .checkNetwork();

    // 인터넷 상태 확인
    if (!isNetwork) return;
    AdBanner banner = AdBanner(bannerId: '', image: '', startDate: DateUtil.getToday());
    DocumentReference docRef = _collectionReference.doc();

    //Storage에 사진 저장
    await _uploadImageFile(docRef.id, image!).then((value) {
          if (value != null) {
            banner.image = value;
          }
    });


    if (banner.image != null){
      await docRef.set(banner.toMap(docRef.id)).then((value) {
        Logger().i("데이터베이스 저장 성공!");
        isSuccess = true;
      }).onError((e, stackTrace) {
        Logger().e("데이터베이스 저장 실패! \n $e");
      });
    }

    return isSuccess;
  }

  /* 모든 데이터 가져오기 */
  static Future<List<AdBanner>> getData(BuildContext context) async {
    List<AdBanner> bannerList = [];
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false)
        .checkNetwork();
    try {
      // 인터넷 상태 확인
      if (!isNetwork) return bannerList;

      await _collectionReference.orderBy("startDate").get().then(
            (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            if (docSnapshot.data() == null) {
              return AdBanner(bannerId: '',image: '',startDate: '');
            }
            final data = docSnapshot.data();
            bannerList.add(AdBanner.fromMap(data));
          }
        },
        onError: (e) => Logger().e("Error completing: $e"),
      );
    } catch (e) {
      Logger().e(e);
    }
    return bannerList;
  }

  /* 데이터 삭제 */
  static Future delete(BuildContext context, String bannerId) async {
    bool isSuccessed = false;
    bool isNetwork = await Provider.of<NetworkProvider>(context, listen: false)
        .checkNetwork();
    try {
      // 인터넷 상태 확인
      if (!isNetwork) return;

      //파이어스토리지에 있는 이미지 파일 삭제
      final storageRef = storage.ref();

      final ref = storageRef.child("banners/${bannerId}.jpg");
      await ref.delete();

      DocumentReference docRef = _collectionReference.doc(bannerId);

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

  static Future _uploadImageFile(String bannerId, File file) async {
    try {
      final storageRef = storage.ref();
      final mountainsRef =
      storageRef.child('banners').child('/$bannerId.jpg'); //사진 저장 경로
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

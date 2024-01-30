import 'package:cloud_firestore/cloud_firestore.dart';

class Goods{
  String? goodsId;
  String? categoryId;
  String? goodsName;
  String? status;
  List<String>? gooodsImages = [];
  int? goodsPrice;
  String? createdDate;
  String? goodsSell; // 판매 수량
  String? views; // 해당 상품 조회 수

  Goods(
      {
        this.goodsId,
        this.categoryId,
        this.goodsName,
        this.status,
        this.gooodsImages,
        this.goodsPrice,
        this.createdDate,
        this.goodsSell,
        this.views,
      });
  // 파이어베이스에 저장하기 위해 Map타입으로 바꿔준다.
  Map<String, dynamic> toMap(String goodsId) {
    return {
      "goodsId": goodsId,
      "categoryId": categoryId,
      "goodsName": goodsName,
      "status": status,
      "gooodsImages": gooodsImages,
      "goodsPrice": goodsPrice,
      "createdDate": createdDate,
      "goodsSell": goodsSell,
      "views": views,
    };
  }

  // 파이어베이스에서 가져온 Map타입을 풀어준다.
  factory Goods.fromMap(Map<String, dynamic> map) {
    if (map == null) return Goods();
    return Goods(
      goodsId: map['goodsId'],
      categoryId: map['userId'],
      goodsName: map['goodsName'],
      status: map['status'],
      gooodsImages: map['gooodsImages'],
      goodsPrice: map['goodsPrice'],
      createdDate: map['createdDate'],
      goodsSell: map['goodsSell'],
      views: map['views'],
    );
  }

  // 파이어베이스에서 가져온 documentSnapshot을 풀어준다.
  factory Goods.fromSnapshot(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot == null) return Goods();
    return Goods(
      goodsId: documentSnapshot['goodsId'],
      categoryId: documentSnapshot['categoryId'],
      goodsName: documentSnapshot['goodsName'],
      status: documentSnapshot['status'],
      gooodsImages: documentSnapshot['imageUrlList'],
      goodsPrice: documentSnapshot['goodsPrice'],
      createdDate: documentSnapshot['createdDate'],
      goodsSell: documentSnapshot['goodsSell'],
      views: documentSnapshot['views'],
    );}
}
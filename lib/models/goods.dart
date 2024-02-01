import 'package:cloud_firestore/cloud_firestore.dart';

class Goods{
  String? goodsId;
  List<String>? categoryId;
  String? goodsName;
  bool status;
  List<String>? thumbnailImages = [];
  List<String>? detailImages = [];
  int? goodsPrice;
  String? createdDate;
  int? goodsSell = 0; // 판매 수량
  int? views = 0; // 해당 상품 조회 수

  Goods(
      {
        this.goodsId,
        this.categoryId,
        this.goodsName,
        required this.status,
        this.thumbnailImages,
        this.detailImages,
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
      "thumbnailImages": thumbnailImages,
      "detailImages": detailImages,
      "goodsPrice": goodsPrice,
      "createdDate": createdDate,
      "goodsSell": goodsSell,
      "views": views,
    };
  }

  // 파이어베이스에서 가져온 Map타입을 풀어준다.
  factory Goods.fromMap(Map<String, dynamic> map) {
    if (map == null) return Goods(status: true);
    return Goods(
      goodsId: map['goodsId'],
      categoryId:List<String>.from(map['categoryId']),
      goodsName: map['goodsName'] ,
      status: map['status'],
      thumbnailImages: List<String>.from(map['thumbnailImages']),
      detailImages: List<String>.from(map['detailImages']),
      goodsPrice: map['goodsPrice'],
      createdDate: map['createdDate'],
      goodsSell: map['goodsSell'],
      views: map['views'],
    );
  }

  // 파이어베이스에서 가져온 documentSnapshot을 풀어준다.
  factory Goods.fromSnapshot(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot == null) return Goods(status: true);
    return Goods(
      goodsId: documentSnapshot['goodsId'],
      categoryId: documentSnapshot['categoryId'],
      goodsName: documentSnapshot['goodsName'],
      status: documentSnapshot['status'],
      thumbnailImages: documentSnapshot['thumbnailImages'],
      detailImages: documentSnapshot['detailImages'],
      goodsPrice: documentSnapshot['goodsPrice'],
      createdDate: documentSnapshot['createdDate'],
      goodsSell: documentSnapshot['goodsSell'],
      views: documentSnapshot['views'],
    );}
}
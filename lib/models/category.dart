import 'package:cloud_firestore/cloud_firestore.dart';

class Category{
  String? name;
  Category({this.name});

  // 파이어베이스에 저장하기 위해 Map타입으로 바꿔준다.
  Map<String, dynamic> toMap(String goodsId) {
    return { "name": name };
  }

  // 파이어베이스에서 가져온 Map타입을 풀어준다.
  factory Category.fromMap(Map<String, dynamic> map) {
    if (map == null) return Category();
    return Category(name: map['name']);
  }

  // 파이어베이스에서 가져온 documentSnapshot을 풀어준다.
  factory Category.fromSnapshot(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot == null) return Category();
    return Category(name: documentSnapshot['name']);
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  String addressId;
  String userId;
  String addressName;
  String address;
  String detailedAddress;
  String securityCode;

  Address({
    required this.addressId,
    required this.userId,
    required this.addressName,
    required this.address,
    required this.detailedAddress,
    required this.securityCode,
  });
  // 파이어베이스에 저장하기 위해 Map타입으로 바꿔준다.
  Map<String, dynamic> toMap(String addressId) {
    return {
      "addressId": addressId,
      "userId": userId,
      "addressName": addressName,
      "address": address,
      "detailedAddress": detailedAddress,
      "securityCode": securityCode,
    };
  }

  // 파이어베이스에서 가져온 Map타입을 풀어준다.
  factory Address.fromMap(Map<String, dynamic> map) {
    if (map == null)
      return Address(
          addressId: '',
          userId: '',
          addressName: '',
          address: '',
          detailedAddress: '',
          securityCode: '');
    return Address(
      addressId: map['addressId'],
      userId: map['userId'],
      addressName: map['addressName'],
      address: map['address'],
      detailedAddress: map['detailedAddress'],
      securityCode: map['securityCode'],
    );
  }

  // 파이어베이스에서 가져온 documentSnapshot을 풀어준다.
  factory Address.fromSnapshot(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot == null)
      return Address(
          addressId: '',
          userId: '',
          addressName: '',
          address: '',
          detailedAddress: '',
          securityCode: '');
    return Address(
      addressId: documentSnapshot['addressId'],
      userId: documentSnapshot['userId'],
      addressName: documentSnapshot['addressName'],
      address: documentSnapshot['address'],
      detailedAddress: documentSnapshot['detailedAddress'],
      securityCode: documentSnapshot['securityCode'],
    );
  }
}

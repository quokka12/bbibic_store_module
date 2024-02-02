import 'package:cloud_firestore/cloud_firestore.dart';

class AdBanner{
  String bannerId = '';
  String image ='';
  String startDate = '';

  AdBanner({required this.bannerId, required this.image, required this.startDate});

  // 파이어베이스에 저장하기 위해 Map타입으로 바꿔준다.
  Map<String, dynamic> toMap(String bannerId) {
    return {
      "bannerId": bannerId,
      "image": image,
      "startDate": startDate,
    };
  }

  // 파이어베이스에서 가져온 Map타입을 풀어준다.
  factory AdBanner.fromMap(Map<String, dynamic> map) {
    if (map == null) return AdBanner(bannerId: '', image: '', startDate:'');
    return AdBanner(
      bannerId: map['bannerId'],
      image: map['image'],
      startDate: map['startDate'],
    );
  }

  // 파이어베이스에서 가져온 documentSnapshot을 풀어준다.
  factory AdBanner.fromSnapshot(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot == null) return AdBanner(bannerId: '', image: '', startDate:'');
    return AdBanner(
      bannerId: documentSnapshot['bannerId'],
      image: documentSnapshot['image'],
      startDate: documentSnapshot['startDate'],
    );
  }
}
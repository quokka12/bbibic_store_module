import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../pakages/camera_pakage.dart';

class PhotoProvider with ChangeNotifier {
  //사진 저장하는 배열
  List<File?> thumbnailList = <File?>[];
  List<File?> detailList = <File?>[];

  Future addThumbnail() async {
    thumbnailList.addAll((await CameraPakage.getImages(thumbnailList)));
    notifyListeners();
  }
  Future addDetail() async {
    detailList.addAll((await CameraPakage.getImagesNoCrop(detailList)));
    notifyListeners();
  }


  void removeThumbnail(int index) {
    thumbnailList.removeAt(index);
    notifyListeners();
  }
  void removeDetail(int index) {
    detailList.removeAt(index);
    notifyListeners();
  }

  void clear() {
    thumbnailList.clear();
    detailList.clear();
    notifyListeners();
  }
}

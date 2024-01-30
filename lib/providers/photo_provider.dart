import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../pakages/camera_pakage.dart';

class PhotoProvider with ChangeNotifier {
  //사진 저장하는 배열
  List<File?> photoList = <File?>[];

  Future addPhotos() async {
    photoList.addAll((await CameraPakage.getImages(photoList)));
    notifyListeners();
  }

  void removePhotos(int index) {
    photoList.removeAt(index);
    notifyListeners();
  }

  void clearPhotoList() {
    photoList.clear();
    notifyListeners();
  }
  void clear(){
    photoList.clear();
    notifyListeners();
  }
}

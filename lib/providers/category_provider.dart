import 'package:bbibic_store/database/firebase/category_firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import '../models/category.dart';

class CategoryProvider with ChangeNotifier {
  List<String> selectedCategoryList = [];
  List<String> categoryList = [];
  void refresh(List<String> category){
    categoryList = category;
    notifyListeners();
  }
  Future addCategory(BuildContext context, String name) async {
    Category category = Category(name : name);
    bool isSuccess = await CategoryFirebase.add(context, category);
    notifyListeners();
    return isSuccess;
  }
  Future<bool> deletedCategory(BuildContext context, String name) async {
    bool isSuccess = await CategoryFirebase.delete(context, name)!;
    notifyListeners();
    return isSuccess;
  }
  void selectTag(tagName) {
    if(selectedCategoryList.length <4){
      selectedCategoryList.add(tagName);
    }
    notifyListeners();
  }

  void unselectTag(tagName) {
    selectedCategoryList.remove(tagName);
    notifyListeners();
  }

  void clear(){
    selectedCategoryList.clear();
    notifyListeners();
  }

}
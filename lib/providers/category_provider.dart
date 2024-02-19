import 'package:bbibic_store/database/firebase/category_firebase.dart';
import 'package:bbibic_store/screens/widgets/loading_bar.dart';
import 'package:flutter/cupertino.dart';

import '../models/category.dart';
import '../util/toast_util.dart';

class CategoryProvider with ChangeNotifier {
  List<String> selectedCategoryList = [];
  List<String> categoryList = [];

  Future<List<String>> getData(BuildContext context) async {
    return await CategoryFirebase.getData(context);
  }

  void refresh(BuildContext context) {
    getData(context).then((categoryList) {
      this.categoryList = categoryList;
      notifyListeners();
    });
  }

  CategoryProvider(BuildContext context) {
    refresh(context);
  }

  Future add(BuildContext context, String name) async {
    Category category = Category(name: name);
    AppLoadingBar.addDataLoading(context);

    bool isSuccess = await CategoryFirebase.add(context, category);
    Navigator.pop(context);
    if (isSuccess) {
      ToastUtil.basic("저장 완료");
      refresh(context);
    }
  }

  Future<bool> deleted(BuildContext context, String name) async {
    bool isSuccess = await CategoryFirebase.delete(context, name)!;
    refresh(context);
    notifyListeners();
    return isSuccess;
  }

  void selectTag(tagName) {
    if (selectedCategoryList.length < 4) {
      selectedCategoryList.add(tagName);
      notifyListeners();
    }
  }

  void unselectTag(tagName) {
    selectedCategoryList.remove(tagName);
    notifyListeners();
  }

  void clear() {
    selectedCategoryList.clear();
    notifyListeners();
  }
}

import 'package:bbibic_store/database/firebase/address_firebase.dart';
import 'package:bbibic_store/util/toast_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../models/address.dart';
import '../screens/widgets/loading_bar.dart';

class AddressProvider with ChangeNotifier {
  List<Address> addressList = [];

  Future add(BuildContext context, Address address) async {
    if (address.addressName.isEmpty) {
      ToastUtil.basic("배송지명을 입력해주세요.");
      return;
    }
    if (address.address.isEmpty) {
      ToastUtil.basic("주소를 입력해주세요.");
      return;
    }
    if (address.detailedAddress.isEmpty) {
      ToastUtil.basic("상세 주소를 입력해주세요.");
      return;
    }
    if (address.securityCode.isEmpty) {
      address.securityCode = '없음';
    }
    AppLoadingBar.addDataLoading(context);
    bool isSuccess = await AddressFirebase.add(context, address);
    Navigator.pop(context);
    if (isSuccess) {
      ToastUtil.basic("저장 완료");
      context.pop();
    } else {
      ToastUtil.basic("저장 실패. 다시 시도해주세요.");
    }
    notifyListeners();
  }

  Future getData(BuildContext context) async {
    addressList = await AddressFirebase.getData(context, 'test');
    notifyListeners();
  }

  Future delete(BuildContext context, String addressId) async {
    bool isSuccess = await AddressFirebase.delete(context, addressId);
    if (isSuccess) {
      ToastUtil.basic("삭제 완료");
    } else {
      ToastUtil.basic("삭제 실패. 다시 시도해주세요.");
    }
    notifyListeners();
  }
}

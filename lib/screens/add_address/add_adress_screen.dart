import 'package:bbibic_store/models/address.dart';
import 'package:bbibic_store/providers/address_provider.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_decorations.dart';
import '../../theme/app_text_styles.dart';
import '../widgets/my_app_bar.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final controllerAddressName = TextEditingController();
  final controllerAddress = TextEditingController();
  final controllerDetailedAddress = TextEditingController();
  final controllerSecurityCode = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerAddressName.dispose();
    controllerAddress.dispose();
    controllerDetailedAddress.dispose();
    controllerSecurityCode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              MyAppBar.basicAppBar(
                  context, "배송지 추가", () => Navigator.pop(context)),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _nameHelper(),
                        _addressHelper(),
                        _securityCodeHelper(),
                      ],
                    ),
                  ),
                ),
              ),
              _addButton(addressProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nameHelper() {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("배송지명", style: AppTextStyles.blackColorS1Bold),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              hintText: "배송지명 입력",
              hintStyle: AppTextStyles.grey600ColorB1,
              prefixIcon: Icon(Icons.tag_rounded, color: AppColors.grey600),
            ),
            style: AppTextStyles.blackColorB1,
            showCursor: true,
            controller: controllerAddressName,
            minLines: 1,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _addressHelper() {
    getAddressFromAPI() async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => KpostalView(
            useLocalServer: true,
            localPort: 1024,
            // kakaoKey: '{Add your KAKAO DEVELOPERS JS KEY}',
            callback: (Kpostal result) {
              controllerAddress.text =
                  '${result.address} ${result.buildingName}';
            },
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("주소 등록", style: AppTextStyles.blackColorS1Bold),
          SizedBox(height: 12),
          GestureDetector(
            onTap: () => getAddressFromAPI(),
            child: TextFormField(
              autofocus: false,
              minLines: 1,
              maxLines: 2,
              enabled: false,
              decoration: InputDecoration(
                hintText: '주소 검색',
                hintStyle: AppTextStyles.grey600ColorB1,
                prefixIcon: Icon(Icons.home_outlined, color: AppColors.grey600),
              ),
              controller: controllerAddress,
            ),
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              hintText: "상세 주소 입력",
              hintStyle: AppTextStyles.grey600ColorB1,
              prefixIcon:
                  Icon(Icons.add_home_outlined, color: AppColors.grey600),
            ),
            style: AppTextStyles.blackColorB1,
            showCursor: true,
            controller: controllerDetailedAddress,
            minLines: 1,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _securityCodeHelper() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("공동 현관 비밀번호", style: AppTextStyles.blackColorS1Bold),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              hintText: "공동 현관 비밀번호 입력",
              hintStyle: AppTextStyles.grey600ColorB1,
              prefixIcon:
                  Icon(Icons.lock_outline_rounded, color: AppColors.grey600),
            ),
            style: AppTextStyles.blackColorB1,
            showCursor: true,
            controller: controllerSecurityCode,
            minLines: 1,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _addButton(AddressProvider addressProvider) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: AppDecorations.buttonDecoration(AppColors.bbibic),
        child: MaterialButton(
          onPressed: () => addressProvider.add(
            context,
            Address(
              addressId: '',
              userId: 'test',
              addressName: controllerAddressName.text,
              address: controllerAddress.text,
              detailedAddress: controllerDetailedAddress.text,
              securityCode: controllerSecurityCode.text,
            ),
          ),
          child: Text("배송지 추가하기", style: AppTextStyles.whiteColorB1),
        ),
      ),
    );
  }
}

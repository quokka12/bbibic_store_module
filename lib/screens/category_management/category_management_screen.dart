import 'package:bbibic_store/screens/widgets/my_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../database/firebase/category_firebase.dart';
import '../../providers/category_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_decorations.dart';
import '../../theme/app_text_styles.dart';
import '../widgets/my_app_bar.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({Key? key}) : super(key: key);

  @override
  State<CategoryManagementScreen> createState() => _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  final categoryNameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    categoryNameController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return  GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyAppBar.basicAppBar(context,"카테고리 관리", null),
              _addCategoryHelper(categoryProvider),
              _categoryHelper(categoryProvider),
            ],
          ),
        ),
      ),
    );
  }
  Widget _addCategoryHelper(CategoryProvider categoryProvider){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("카테고리 추가",style: AppTextStyles.blackColorH2Bold),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child:Container(
                  padding: const EdgeInsets.only(top: 18),
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.grey200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                      controller: categoryNameController,
                      decoration: const InputDecoration(
                        hintText: '추가할 카테고리명을 작성해주세요.',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                      ),
                    maxLines: 1,
                    minLines: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Container(
                  height: 40,
                  decoration: AppDecorations.buttonDecoration(AppColors.black),
                  child: MaterialButton(
                    onPressed: (){
                      if(categoryNameController.text.length < 1){
                        Fluttertoast.showToast(
                          msg: "카테고리명을 작성해주세요.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          fontSize: AppTextStyles.B1,
                        );
                      }else{
                        categoryProvider.addCategory(context, categoryNameController.text);
                        categoryNameController.clear();
                      }
                    },
                    child: Text("추가하기",style: AppTextStyles.whiteColorB1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _categoryHelper(CategoryProvider categoryProvider){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("카테고리",style: AppTextStyles.blackColorH2Bold),
          _categoryRemoveInfoHelper(),
          SizedBox(height: 8),
          _categoryList(categoryProvider),
        ],
      ),
    );
  }
  Widget _categoryList(CategoryProvider categoryProvider) {
    return FutureBuilder<List<String>>(
      future: CategoryFirebase.getData(context),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(); // 데이터 로딩 중에 보여줄 위젯
        } else if (snapshot.hasError) {
          Fluttertoast.showToast(
            msg: "데이터를 불러올 수 없습니다. 다시 시도해주세요.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: AppTextStyles.B1,
          );
          return SizedBox(); // 에러 발생 시 보여줄 위젯
        } else {
          List<String>? categoryList = snapshot.data; // List<String> 형태의 데이터 추출
          // 추출한 데이터를 활용하여 UI를 구성하거나 다른 작업을 수행할 수 있습니다.
          return Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: 4,
            runSpacing: 4,
            children: [
              for(int i =0; i<categoryList!.length;i++)
                _categoryCard(categoryList[i], categoryProvider),
            ],
          );
        }
      },
    );
  }

  Widget _categoryCard(String name, CategoryProvider categoryProvider) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: InkWell(
        onTap: () {
          MyDialog.categoryDeleteDialog(context,categoryProvider,name);
          CategoryFirebase.getData(context).then((value) {
            categoryProvider.refresh(value);
          });
        },
        child: UnconstrainedBox(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: AppDecorations.tagDecoration(),
            child: Text(
              "#$name",
              style: AppTextStyles.grey600ColorB1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _categoryRemoveInfoHelper() {
    return Row(
      children: [
        const Icon(
          Icons.info_outline,
          size: 16,
          color: AppColors.grey600,
        ),
        const SizedBox(width: 4),
        Text(
          "카테고리는 터치해서 삭제할 수 있어요!",
          style: AppTextStyles.grey600ColorB2,
        ),
      ],
    );
  }
}

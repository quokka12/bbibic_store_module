
import 'package:bbibic_store/configs/router/route_names.dart';
import 'package:bbibic_store/models/goods.dart';
import 'package:bbibic_store/providers/photo_provider.dart';
import 'package:bbibic_store/screens/admin/add_goods/widgets/category_widget.dart';
import 'package:bbibic_store/screens/admin/add_goods/widgets/detail_image_widget.dart';
import 'package:bbibic_store/screens/admin/add_goods/widgets/thumbnail_widget.dart';
import 'package:bbibic_store/screens/admin/components/photo_component.dart';
import 'package:bbibic_store/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/goods_provider.dart';
import '../../../theme/app_decorations.dart';
import '../../../theme/app_text_styles.dart';
import '../../../util/date_util.dart';
import '../../widgets/my_app_bar.dart';

class AddGoodsScreen extends StatefulWidget {
  const AddGoodsScreen({Key? key}) : super(key: key);

  @override
  State<AddGoodsScreen> createState() => _AddGoodsScreenState();
}

class _AddGoodsScreenState extends State<AddGoodsScreen> {
  final controllerName = TextEditingController();
  final controllerPrice = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerName.dispose();
    controllerPrice.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final photoProvider = Provider.of<PhotoProvider>(context);
    final goodsProvider = Provider.of<GoodsProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              MyAppBar.basicAppBar(
                context,
                "상품 추가",
                (){
                  categoryProvider.clear();
                  photoProvider.clear();
                  Navigator.pop(context);
                }
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ThumbnailWidget(),
                      const DetailImageWidget(),
                      PhotoComponent.photoRemoveInfoHelper(),
                      _nameHelper(),
                      _priceHelper(),
                      const CategoryWidget(),
                    ],
                  ),
                ),
              ),
              _addButton(goodsProvider, photoProvider, categoryProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nameHelper() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("상품 이름",style: AppTextStyles.blackColorH2Bold),
          SizedBox(height: 12),
          TextField(
            decoration:
            InputDecoration(hintText: "상품 이름을 입력해주세요.", hintStyle: AppTextStyles.grey600ColorB1),
            style: AppTextStyles.blackColorB1,
            showCursor: true,
            controller: controllerName,
            minLines: 1,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _priceHelper() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("상품 가격",style: AppTextStyles.blackColorH2Bold),
          SizedBox(height: 12),
          TextField(
            keyboardType: TextInputType.number,
            decoration:
              InputDecoration(hintText: "가격을 입력해주세요.", hintStyle: AppTextStyles.grey600ColorB1),
            style: AppTextStyles.blackColorB1,
            showCursor: true,
            controller: controllerPrice,
            minLines: 1,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _addButton(GoodsProvider goodsProvider, PhotoProvider photoProvider, CategoryProvider categoryProvider){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: AppDecorations.buttonDecoration(AppColors.black),
        child: MaterialButton(
          onPressed: () async{
            await goodsProvider.add(
              context,
              Goods(
                categoryId: categoryProvider.selectedCategoryList,
                goodsName: controllerName.text,
                goodsPrice: int.tryParse(controllerPrice.text) ?? 0,
                status: true,
                goodsSell: 0,
                views: 0,
                createdDate: DateUtil.getToday(),
                thumbnailImages: [],
                detailImages: [],
              ),
              photoProvider.thumbnailList, photoProvider.detailList,
            );
          },
          child: Text("상품 추가하기",style: AppTextStyles.whiteColorB1),
        ),
      ),
    );
  }
}

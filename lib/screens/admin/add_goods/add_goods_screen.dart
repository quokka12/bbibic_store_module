import 'package:bbibic_store/providers/photo_provider.dart';
import 'package:bbibic_store/screens/admin/add_goods/widgets/add_goods_category_widget.dart';
import 'package:bbibic_store/screens/admin/add_goods/widgets/detail_image_widget.dart';
import 'package:bbibic_store/screens/admin/add_goods/widgets/thumbnail_widget.dart';
import 'package:bbibic_store/theme/app_colors.dart';
import 'package:bbibic_store/util/format_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../models/goods.dart';
import '../../../providers/category_provider.dart';
import '../../../providers/goods_provider.dart';
import '../../../theme/app_decorations.dart';
import '../../../theme/app_text_styles.dart';
import '../../../util/date_util.dart';
import '../../widgets/my_app_bar.dart';
import '../components/photo_component.dart';

class AddGoodsScreen extends StatefulWidget {
  const AddGoodsScreen({Key? key}) : super(key: key);

  @override
  State<AddGoodsScreen> createState() => _AddGoodsScreenState();
}

class _AddGoodsScreenState extends State<AddGoodsScreen> {
  final _formKey = GlobalKey<FormState>();
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                MyAppBar.basicAppBar(
                  context,
                  "상품 추가",
                  () {
                    categoryProvider.clear();
                    photoProvider.clear();
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ThumbnailWidget(),
                        const DetailImageWidget(),
                        const SizedBox(height: 12),
                        PhotoComponent.photoRemoveInfoHelper(),
                        _nameHelper(),
                        _priceHelper(),
                        const AddGoodsCategoryWidget(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                _addButton(goodsProvider, photoProvider, categoryProvider),
              ],
            ),
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
          Text("상품 이름", style: AppTextStyles.blackColorH2Bold),
          const SizedBox(height: 12),
          TextFormField(
            decoration: InputDecoration(
                hintText: "상품 이름을 입력해주세요.",
                hintStyle: AppTextStyles.grey600ColorB1),
            style: AppTextStyles.blackColorB1,
            controller: controllerName,
            minLines: 1,
            maxLines: 1,
            validator: (value) {
              if (value.toString().isEmpty) {
                return '상품 이름을 입력해주세요.';
              }
              return null;
            },
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
          Text("상품 가격", style: AppTextStyles.blackColorH2Bold),
          const SizedBox(height: 12),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "상품 가격을 입력해주세요.",
                hintStyle: AppTextStyles.grey600ColorB1),
            style: AppTextStyles.blackColorB1,
            controller: controllerPrice,
            minLines: 1,
            maxLines: 1,
            validator: (value) {
              if (value.toString().isEmpty) {
                return '상품 가격을 입력해주세요.';
              }
              return null;
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TextInputFormatter.withFunction((oldValue, newValue) {
                final int? parsedValue = int.tryParse(newValue.text);
                if (parsedValue != null) {
                  final formattedValue = FormatUtil.priceFormat(parsedValue);
                  return TextEditingValue(
                    text: formattedValue,
                    selection:
                        TextSelection.collapsed(offset: formattedValue.length),
                  );
                }
                return newValue;
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _addButton(GoodsProvider goodsProvider, PhotoProvider photoProvider,
      CategoryProvider categoryProvider) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: AppDecorations.buttonDecoration(AppColors.bbibic),
        child: MaterialButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() != true) return;
            await goodsProvider.add(
              context,
              Goods(
                categoryId: categoryProvider.selectedCategoryList,
                goodsName: controllerName.text,
                goodsPrice: int.tryParse(
                        FormatUtil.priceDataFormat(controllerPrice.text)) ??
                    0,
                status: true,
                goodsSell: 0,
                views: 0,
                createdDate: DateUtil.getToday(),
                thumbnailImages: [],
                detailImages: [],
              ),
              photoProvider.thumbnailList,
              photoProvider.detailList,
            );
          },
          child: Text("상품 추가하기", style: AppTextStyles.whiteColorB1),
        ),
      ),
    );
  }
}

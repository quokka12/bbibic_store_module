import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddGoodsAppBar extends StatelessWidget {
  const AddGoodsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(left: 12, right: 20, top: 10, bottom: 10),
      alignment: Alignment.centerLeft,
      height: 56,
      child: GestureDetector(
        onTap: () => context.pop(),
        child: Icon(Icons.arrow_back_ios_rounded,size: 24),
      )
    );
  }
}

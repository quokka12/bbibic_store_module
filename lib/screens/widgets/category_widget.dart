import 'package:flutter/cupertino.dart';

import '../../theme/app_decorations.dart';
import '../../theme/app_text_styles.dart';

Widget categoryCard(String name) {
  return Padding(
    padding: const EdgeInsets.all(6),
    child: UnconstrainedBox(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: AppDecorations.tagDecoration(),
        child: Text("#$name", style: AppTextStyles.blackColorB1),
      ),
    ),
  );
}

import 'package:flutter/cupertino.dart';

import '../../theme/app_text_styles.dart';

class CompanyInfoWidget extends StatelessWidget {
  const CompanyInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("(주)에스지엘 | 대표 김선명", style: AppTextStyles.grey600ColorC1),
            Text("사업자등록번호 : 537-86-02993", style: AppTextStyles.grey600ColorC2),
            Text("주소 : 서울시 서초구 남부순환로 2497",
                style: AppTextStyles.grey600ColorC2),
            Text("통신판매 : 제 2023-서울서초-3702호",
                style: AppTextStyles.grey600ColorC2),
            Text("FAX : 0504-423-0034 | EMAIL : bb@bbibic.com",
                style: AppTextStyles.grey600ColorC2),
          ],
        ),
      ),
    );
  }
}

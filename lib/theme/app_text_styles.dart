import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static final H1 = 24.0;
  static final H2 = 20.0;
  static final S1 = 18.0;
  static final S2 = 16.0;
  static final S3 = 14.0;
  static final S4 = 12.0;
  static final B1 = 16.0;
  static final B2 = 14.0;
  static final C1 = 12.0;
  static final C2 = 10.0;
  /* bbibicColor */
  static final bbibicColorH1 = TextStyle(color: AppColors.bbibic, fontSize: S1);

  /* whiteColor */
  static final whiteColorB1 =
      TextStyle(color: Colors.white, fontSize: B1, height: 1.5);
  static final whiteColorB2 =
      TextStyle(color: Colors.white, fontSize: B2, height: 1.5);

  /* blackColor */
  static final blackColorH1 =
  TextStyle(color: Colors.black, fontSize: H1, height: 1.5);
  static final blackColorH2Bold = TextStyle(
    color: Colors.black,
    fontSize: H2,
    height: 1.5,
    fontWeight: FontWeight.bold,
  );

  static final blackColorS1Bold =
  TextStyle(color: Colors.black, fontSize: S1, height: 1.5,
    fontWeight: FontWeight.bold,);
  static final blackColorS1 =
  TextStyle(color: Colors.black, fontSize: S1, height: 1.5);
  static final blackColorS2 =
  TextStyle(color: Colors.black, fontSize: S2, height: 1.5);
  static final blackColorS2Bold = TextStyle(
    color: Colors.black,
    fontSize: S2,
    height: 1.5,
    fontWeight: FontWeight.bold,
  );
  static final blackColorB1Bold = TextStyle(
    color: Colors.black,
    fontSize: B1,
    height: 1.5,
    fontWeight: FontWeight.bold,
  );
  static final blackColorB1 =
      TextStyle(color: Colors.black, fontSize: B1, height: 1.5);
  static final blackColorB2Bold = TextStyle(
    color: Colors.black,
    fontSize: B2,
    height: 1.5,
    fontWeight: FontWeight.bold,
  );
  static final blackColorB2 =
  TextStyle(color: Colors.black, fontSize: B2, height: 1.5);

  /* grey600Color */
  static final grey600ColorB1 =
      TextStyle(color: AppColors.grey600, fontSize: B1, height: 1.5);
  static final grey600ColorB2 =
  TextStyle(color: AppColors.grey600, fontSize: B2, height: 1.5);
  static final grey600ColorC1 =
      TextStyle(color: AppColors.grey600, fontSize: C1, height: 1.5);

  /* redColor */
  static final redColorB1 =
  TextStyle(color: Colors.redAccent, fontSize: B1, height: 1.5);


  /* blueColor */
  static final blueColorB1 =
  TextStyle(color: Colors.blueAccent, fontSize: B1, height: 1.5);

  /* underline */
  static final underline =
  TextStyle(color: Colors.black, fontSize: B2,height: 1.5,decoration: TextDecoration.underline,decorationColor: Colors.black);
}

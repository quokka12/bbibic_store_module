import 'package:bbibic_store/providers/address_provider.dart';
import 'package:bbibic_store/providers/banner_provider.dart';
import 'package:bbibic_store/providers/cart_provider.dart';
import 'package:bbibic_store/providers/category_provider.dart';
import 'package:bbibic_store/providers/goods_provider.dart';
import 'package:bbibic_store/providers/network_provider.dart';
import 'package:bbibic_store/providers/order_provider.dart';
import 'package:bbibic_store/providers/photo_provider.dart';
import 'package:bbibic_store/theme/app_themes.dart';
import 'package:bbibic_store/view_model/goods_detail_tab_bar_view_model.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'configs/router/app_router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PhotoProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider(context)),
        ChangeNotifierProvider(create: (context) => NetworkProvider()),
        ChangeNotifierProvider(create: (context) => GoodsProvider(context)),
        ChangeNotifierProvider(
            create: (context) => GoodsDetailTabBarViewModel()),
        ChangeNotifierProvider(create: (context) => BannerProvider(context)),
        ChangeNotifierProvider(create: (context) => CartProvider(context)),
        ChangeNotifierProvider(create: (context) => AddressProvider(context)),
        ChangeNotifierProvider(create: (context) => OrderProvider(context)),
      ],
      child: MaterialApp.router(
        theme: AppThemes.mainTheme(),
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

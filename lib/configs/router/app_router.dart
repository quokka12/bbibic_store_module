import 'package:bbibic_store/configs/router/route_names.dart';
import 'package:bbibic_store/configs/router/screen_transition.dart';
import 'package:bbibic_store/screens/add_address/add_adress_screen.dart';
import 'package:bbibic_store/screens/address_management/address_management_screen.dart';
import 'package:bbibic_store/screens/admin/add_banner/add_banner_screen.dart';
import 'package:bbibic_store/screens/cart/cart_screen.dart';
import 'package:bbibic_store/screens/goods_detail/goods_detail_screen.dart';
import 'package:bbibic_store/screens/service_web_view/service_center_screen.dart';
import 'package:go_router/go_router.dart';

import '../../screens/admin/add_goods/add_goods_screen.dart';
import '../../screens/admin/banner_management/banner_management_screen.dart';
import '../../screens/admin/category_management/category_management_screen.dart';
import '../../screens/admin/goods_management/goods_management_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/my_info/my_info_screen.dart';
import '../../screens/service_web_view/privacy_policy_screen.dart';
import '../../screens/service_web_view/terms_of_use_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: RouteNames.home,
        path: '/',
        pageBuilder: (context, state) =>
            ScreenTrainsition.fadeTransition(state, const HomeScreen()),
        routes: [
          GoRoute(
            name: RouteNames.goodsDetail,
            path: RouteNames.goodsDetail,
            builder: (context, state) => const GoodsDetailScreen(),
          ),
          GoRoute(
            name: RouteNames.cart,
            path: RouteNames.cart,
            builder: (context, state) => const CartScreen(),
          ),
          GoRoute(
            name: RouteNames.myInfo,
            path: RouteNames.myInfo,
            builder: (context, state) => const MyInfoScreen(),
            routes: [
              GoRoute(
                name: RouteNames.goodsManagement,
                path: RouteNames.goodsManagement,
                builder: (context, state) => const GoodsManagementScreen(),
                routes: [
                  GoRoute(
                    name: RouteNames.addGoods,
                    path: RouteNames.addGoods,
                    builder: (context, state) => const AddGoodsScreen(),
                  ),
                ],
              ),
              GoRoute(
                name: RouteNames.categoryManagement,
                path: RouteNames.categoryManagement,
                builder: (context, state) => const CategoryManagementScreen(),
              ),
              GoRoute(
                name: RouteNames.bannerManagement,
                path: RouteNames.bannerManagement,
                builder: (context, state) => const BannerManagementScreen(),
                routes: [
                  GoRoute(
                    name: RouteNames.addBanner,
                    path: RouteNames.addBanner,
                    builder: (context, state) => const AddBannerScreen(),
                  ),
                ],
              ),
              GoRoute(
                name: RouteNames.serviceCenter,
                path: RouteNames.serviceCenter,
                builder: (context, state) => const ServiceCenterScreen(),
              ),
              GoRoute(
                name: RouteNames.termOfUser,
                path: RouteNames.termOfUser,
                builder: (context, state) => const TermOfUserScreen(),
              ),
              GoRoute(
                name: RouteNames.privacyPolicy,
                path: RouteNames.privacyPolicy,
                builder: (context, state) => const PrivacyPolicyScreen(),
              ),
              GoRoute(
                name: RouteNames.deliveryAddressManagement,
                path: RouteNames.deliveryAddressManagement,
                builder: (context, state) => const AddressManagementScreen(),
                routes: [
                  GoRoute(
                    name: RouteNames.addAddress,
                    path: RouteNames.addAddress,
                    builder: (context, state) => const AddAddressScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

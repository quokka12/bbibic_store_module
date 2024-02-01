import 'package:bbibic_store/configs/router/route_names.dart';
import 'package:bbibic_store/configs/router/screen_transition.dart';
import 'package:bbibic_store/screens/goods_detail/goods_detail_screen.dart';
import 'package:go_router/go_router.dart';

import '../../screens/admin/add_goods/add_goods_screen.dart';
import '../../screens/admin/category_management/category_management_screen.dart';
import '../../screens/admin/goods_management/goods_management_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/my_info/my_info_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: RouteNames.home,
        path: '/',
        pageBuilder: (context, state) => ScreenTrainsition.fadeTransition(state, HomeScreen()),
        routes: [
          GoRoute(
            name: RouteNames.goodsDetail,
            path: RouteNames.goodsDetail,
            builder: (context, state) => GoodsDetailScreen(),
          ),
          GoRoute(
            name: RouteNames.myInfo,
            path: RouteNames.myInfo,
            builder: (context, state) => MyInfoScreen(),
            routes: [
              GoRoute(
                  name: RouteNames.addGoods,
                  path: RouteNames.addGoods,
                  builder: (context, state) => AddGoodsScreen(),
              ),GoRoute(
                  name: RouteNames.goodsManagement,
                  path: RouteNames.goodsManagement,
                  builder: (context, state) => GoodsManagementScreen(),
              ),
              GoRoute(
                name: RouteNames.categoryManagement,
                path: RouteNames.categoryManagement,
                builder: (context, state) => CategoryManagementScreen(),
              ),
            ]
          ),

        ]
      ),

    ],
  );
}
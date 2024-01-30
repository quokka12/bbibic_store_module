import 'package:bbibic_store/configs/router/route_names.dart';
import 'package:bbibic_store/configs/router/screen_transition.dart';
import 'package:bbibic_store/screens/category_management/category_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../screens/add_goods/add_goods_screen.dart';
import '../../screens/home/home_screen.dart';

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
            name: RouteNames.addGoods,
            path: RouteNames.addGoods,
            builder: (context, state) => AddGoodsScreen(),
            routes: [
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
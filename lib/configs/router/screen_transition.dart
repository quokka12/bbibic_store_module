import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class ScreenTrainsition {
  static CustomTransitionPage fadeTransition(GoRouterState state, Widget page) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }
}
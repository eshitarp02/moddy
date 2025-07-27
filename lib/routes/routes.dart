import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/domain/repositories/auth/auth_repository.dart';
import 'package:to_do_app/presentation/pages/home/home_page.dart';
import 'package:to_do_app/presentation/pages/login/login_page.dart';
import 'package:to_do_app/routes/route_observer.dart';

import '../presentation/pages/sign_up/sign_up_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  observers: [AppRouteObserver()],
  navigatorKey: navigatorKey,
  redirect: (context, state) async {
    final auth = GetIt.I<AuthRepository>();
    final isLoggedIn = await auth.hasCompletedLogin() ?? false;
    final isLoggingIn = state.fullPath == Routes.login.path;

    if (isLoggedIn && isLoggingIn) {
      return Routes.home.path;
    }

    return null;
  },
  debugLogDiagnostics: true,
  initialLocation: Routes.login.path,
  errorBuilder: (context, state) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.goNamed(Routes.home.name);
    });
    return const Scaffold();
  },
  routes: [
    GoRoute(
      name: Routes.login.name,
      path: Routes.login.path,
      pageBuilder: Routes.login.pageBuilder,
    ),
    GoRoute(
      name: Routes.signUp.name,
      path: Routes.signUp.path,
      pageBuilder: Routes.signUp.pageBuilder,
    ),
    GoRoute(
      name: Routes.home.name,
      path: Routes.home.path,
      pageBuilder: Routes.home.pageBuilder,
    ),
  ],
);

/// Provides information need for the navigation for routing
class RouteInfo {
  /// name of the Route used for navigating using [context.goNamed]
  final String name;

  /// path that will be added to the pathName that is added in the location URI
  final String path;

  /// pageBuilder allows for adding custom transition animations
  final GoRouterPageBuilder pageBuilder;

  RouteInfo({
    required this.name,
    required this.path,
    required this.pageBuilder,
  });
}

class Routes {
  static RouteInfo login = RouteInfo(
    name: 'login',
    path: '/login',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const LoginPage(),
    ),
  );
  static RouteInfo signUp = RouteInfo(
    name: 'signUp',
    path: '/signUp',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const SignUpPage(),
    ),
  );
  static RouteInfo home = RouteInfo(
    name: 'home',
    path: '/home',
    pageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: const HomePage(),
    ),
  );
}

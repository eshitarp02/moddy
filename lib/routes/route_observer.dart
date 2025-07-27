import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AppRouteObserver extends NavigatorObserver {
  final log = Logger();

  @override
  void didPush(Route route, Route? previousRoute) {
    log.d('Pushed ${route.settings.name}');
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    log.d('Popped ${route.settings.name}');
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    log.d(
        'Replaced ${oldRoute?.settings.name} with ${newRoute?.settings.name}');
    super.didReplace(oldRoute: oldRoute, newRoute: newRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    log.d(
        'Removed ${previousRoute?.settings.name}, back to ${route.settings.name}');
    super.didRemove(route, previousRoute);
  }
}

import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? to(String routeName)  async{
    return await  navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic>? toWithParameters(String routeName, {required Object args}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  Future<dynamic> replace(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  popUntil(int length) {
    int count = 0;
    navigatorKey.currentState!.popUntil((_) => count++ >= length);
  }

  Future<dynamic> replaceWithParameters(String routeName,
      {required Object args}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: args);
  }

  back() {
    return navigatorKey.currentState!.pop();
  }

  close() {
    return navigatorKey.currentState!.maybePop();
  }

  backWithParameters({required Object args}) {
    return navigatorKey.currentState!.pop(args);
  }

  bool canPop() {
    return navigatorKey.currentState!.canPop();
  }

  clearAllTo(String routeName, {String? predicate}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => predicate == null ? false : route.settings.name == predicate,
    );
  }

  clearAllToWithParameters(String routeName,
      {required Object args, String? predicate}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => predicate == null ? false : route.settings.name == predicate,
      arguments: args,
    );
  }
}

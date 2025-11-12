import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

String? get _userId => LocalStorage.getData(key: LocalStorageKey.userId);

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (_userId == null) return _redirectTo(RouteGenerator.login);
    return null;
  }

  RouteSettings _redirectTo(String routeName) {
    return RouteSettings(name: routeName);
  }
}
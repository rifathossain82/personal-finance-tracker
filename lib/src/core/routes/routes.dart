import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteGenerator {
  static const String dashboard = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String home = '/home';

  static final routes = [
    GetPage(
      name: RouteGenerator.dashboard,
      page: () => Scaffold(appBar: AppBar(),),
    ),
    GetPage(
      name: RouteGenerator.login,
      page: () => Scaffold(appBar: AppBar(),),
    ),
  ];
}

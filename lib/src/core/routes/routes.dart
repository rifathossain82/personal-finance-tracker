import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/features/auth/view/pages/forgot_password_page.dart';
import 'package:personal_finance_tracker/src/features/auth/view/pages/login_page.dart';
import 'package:personal_finance_tracker/src/features/auth/view/pages/register_page.dart';
import 'package:personal_finance_tracker/src/features/auth/view/pages/reset_password_page.dart';

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
      page: () => const LoginPage(),
    ),
    GetPage(
      name: RouteGenerator.register,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: RouteGenerator.forgotPassword,
      page: () => const ForgotPasswordPage(),
    ),
    GetPage(
      name: RouteGenerator.resetPassword,
      page: () => const ResetPasswordPage(),
    ),
  ];
}

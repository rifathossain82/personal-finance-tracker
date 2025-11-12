import 'package:personal_finance_tracker/src/features/auth/view/widgets/register_redirect_button.dart';
import 'package:personal_finance_tracker/src/features/auth/view/widgets/resend_email_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:personal_finance_tracker/src/features/auth/controller/auth_controller.dart';
import 'package:personal_finance_tracker/src/features/auth/view/widgets/forgot_password_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authController = Get.find<AuthController>();
  final loginFormKey = GlobalKey<FormState>();
  late final TextEditingController emailTextController;
  late final TextEditingController passwordTextController;

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();

    /// Listener to validate the email status in authController
    emailTextController.addListener(() {
      authController.recheckLoginEmailValidity(emailTextController.text);
    });
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _buildLoginForm(),
            Positioned(
              left: 20,
              child: CustomBackButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Obx(() {
      return StretchingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 20,
              top: 10,
            ),
            child: Form(
              key: loginFormKey,
              child: Column(
                children: [
                  KLogo(),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      authController.canResendEmail()
                          ? 'অনুগ্রহ করে আপনার ইমেইল চেক করুন এবং ভেরিফিকেশন সম্পন্ন করে লগইন করুন'
                          : 'আপনার অ্যাকাউন্টে লগইন করুন',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  KTextFormFieldBuilderWithTitle(
                    controller: emailTextController,
                    validator: Validators.emailValidator,
                    hintText: 'আপনার ই-মেইল লিখুন',
                    title: 'ই-মেইল',
                    prefixIconData: Icons.mail_outline_rounded,
                    suffixIconData: authController.isLoginEmailValid.value
                        ? Icons.check
                        : null,
                    suffixColor: kPrimaryColor,
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                  ),
                  KTextFormFieldBuilderWithTitle(
                    controller: passwordTextController,
                    validator: Validators.passwordValidator,
                    hintText: 'আপনার পাসওয়ার্ড লিখুন',
                    title: 'পাসওয়ার্ড',
                    prefixIconData: Icons.lock_outline_rounded,
                    suffixIconData:
                        authController.isLoginPasswordVisibility.isTrue
                            ? Icons.visibility_off
                            : Icons.visibility_rounded,
                    onTapSuffix: authController.toggleLoginPasswordVisibility,
                    inputType: TextInputType.visiblePassword,
                    inputAction: TextInputAction.done,
                    obscureText: authController.isLoginPasswordVisibility.value,
                    bottomPadding: 8,
                  ),
                  ForgotPasswordButton(),
                  const SizedBox(height: 30),
                  KButton(
                    onPressed: onPressedLogin,
                    child: authController.isLoginLoading.isTrue
                        ? const KButtonProgressIndicator()
                        : Text(
                            'লগইন করুন',
                            style: context.buttonTextStyle(),
                          ),
                  ),
                  const SizedBox(height: 24),
                  RegisterRedirectButton(),
                  if (authController.canResendEmail()) ...[
                    const SizedBox(height: 12),
                    ResendEmailButton(authController: authController),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void onPressedLogin() {
    if (loginFormKey.currentState!.validate()) {
      authController.login(
        email: emailTextController.text.trim(),
        password: passwordTextController.text.trim(),
      );
    }
  }
}

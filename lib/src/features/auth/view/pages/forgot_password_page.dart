import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:personal_finance_tracker/src/features/auth/controller/auth_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final authController = Get.find<AuthController>();
  final forgotFormKey = GlobalKey<FormState>();
  late final TextEditingController emailTextController;

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();

    /// Listener to validate the email status in authController
    emailTextController.addListener(() {
      authController.recheckForgotPasswordEmailValidity(
        emailTextController.text,
      );
    });
  }

  @override
  void dispose() {
    emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _buildForgotPasswordForm(),
            Positioned(
              left: 20,
              child: CustomBackButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPasswordForm() {
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
              key: forgotFormKey,
              child: Column(
                children: [
                  KLogo(),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: const Text(
                      'আপনার পাসওয়ার্ড পুনরুদ্ধার করুন',
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
                    suffixIconData:
                        authController.isForgotPasswordEmailValid.value
                            ? Icons.check
                            : null,
                    suffixColor: kPrimaryColor,
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 30),
                  KButton(
                    onPressed: onPressedForgotPassword,
                    child: authController.isForgotPasswordLoading.isTrue
                        ? const KButtonProgressIndicator()
                        : Text(
                            'সাবমিট করুন',
                            style: context.buttonTextStyle(),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void onPressedForgotPassword() {
    if (forgotFormKey.currentState!.validate()) {
      authController.forgotPassword(
        emailTextController.text.trim(),
      );
    }
  }
}

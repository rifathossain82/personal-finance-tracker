import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:personal_finance_tracker/src/features/auth/controller/auth_controller.dart';

class CreateNewPasswordPage extends StatefulWidget {
  const CreateNewPasswordPage({super.key});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  final authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  late final TextEditingController passwordTextController;
  late final TextEditingController confirmPasswordTextController;

  @override
  void initState() {
    super.initState();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
  }

  @override
  void dispose() {
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create New Password',
                      style: context.titleLarge(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Create your new password to login',
                      textAlign: TextAlign.start,
                      style: context.bodyLarge(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 32),
                    KTextFormFieldBuilder(
                      controller: passwordTextController,
                      validator: Validators.passwordValidator,
                      hintText: 'Enter your password',
                      prefixIconData: Icons.lock_outline_rounded,
                      suffixIconData: authController.isPasswordVisibility.isTrue
                          ? Icons.visibility_off
                          : Icons.visibility_rounded,
                      onTapSuffix: authController.togglePasswordVisibility,
                      inputType: TextInputType.visiblePassword,
                      inputAction: TextInputAction.next,
                      obscureText: authController.isPasswordVisibility.value,
                    ),
                    KTextFormFieldBuilder(
                      controller: confirmPasswordTextController,
                      validator: (value) => Validators.confirmPasswordValidator(
                        value,
                        passwordTextController.text.trim(),
                      ),
                      hintText: 'Confirm your password',
                      prefixIconData: Icons.lock_outline_rounded,
                      suffixIconData:
                          authController.isConfirmPasswordVisibility.isTrue
                              ? Icons.visibility_off
                              : Icons.visibility_rounded,
                      onTapSuffix: authController.toggleConfirmPasswordVisibility,
                      inputType: TextInputType.visiblePassword,
                      inputAction: TextInputAction.done,
                      obscureText:
                          authController.isConfirmPasswordVisibility.value,
                      bottomPadding: 8,
                    ),
                    const SizedBox(height: 30),
                    KButton(
                      onPressed: onPressedCreatePassword,
                      child: Text(
                        'Create Password',
                        style: context.buttonTextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void onPressedCreatePassword() {
    if (formKey.currentState!.validate()) {

    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:personal_finance_tracker/src/features/auth/controller/auth_controller.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final authController = Get.find<AuthController>();
  final resetPasswordFormKey = GlobalKey<FormState>();

  late final TextEditingController oldPasswordTextController;
  late final TextEditingController newPasswordTextController;
  late final TextEditingController confirmPasswordTextController;

  bool oldPasswordVisibility = true;
  bool newPasswordVisibility = true;
  bool confirmPasswordVisibility = true;

  @override
  void initState() {
    super.initState();
    oldPasswordTextController = TextEditingController();
    newPasswordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
  }

  @override
  void dispose() {
    oldPasswordTextController.dispose();
    newPasswordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text(
          'পাসওয়ার্ড পরিবর্তন করুন',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: resetPasswordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KTextFormFieldBuilderWithTitle(
                    controller: oldPasswordTextController,
                    validator: Validators.passwordValidator,
                    hintText: 'পুরাতন পাসওয়ার্ড লিখুন',
                    title: 'পুরাতন পাসওয়ার্ড',
                    prefixIconData: Icons.lock_outline_rounded,
                    obscureText: oldPasswordVisibility,
                    suffixIconData: oldPasswordVisibility
                        ? Icons.visibility_off
                        : Icons.visibility_rounded,
                    onTapSuffix: () {
                      setState(() {
                        oldPasswordVisibility = !oldPasswordVisibility;
                      });
                    },
                    inputType: TextInputType.visiblePassword,
                    inputAction: TextInputAction.done,
                    bottomPadding: 8,
                  ),
                  KTextFormFieldBuilderWithTitle(
                    controller: newPasswordTextController,
                    validator: Validators.passwordValidator,
                    hintText: 'নতুন পাসওয়ার্ড লিখুন',
                    title: 'নতুন পাসওয়ার্ড',
                    prefixIconData: Icons.lock_outline_rounded,
                    obscureText: newPasswordVisibility,
                    suffixIconData: newPasswordVisibility
                        ? Icons.visibility_off
                        : Icons.visibility_rounded,
                    onTapSuffix: () {
                      setState(() {
                        newPasswordVisibility = !newPasswordVisibility;
                      });
                    },
                    inputType: TextInputType.visiblePassword,
                    inputAction: TextInputAction.done,
                    bottomPadding: 8,
                  ),
                  KTextFormFieldBuilderWithTitle(
                    controller: confirmPasswordTextController,
                    validator: (value) => Validators.confirmPasswordValidator(
                      value,
                      newPasswordTextController.text.trim(),
                    ),
                    hintText: 'নতুন পাসওয়ার্ডটি আবার লিখুন',
                    title: 'নতুন পাসওয়ার্ড নিশ্চিত করুন',
                    prefixIconData: Icons.lock_outline_rounded,
                    obscureText: confirmPasswordVisibility,
                    suffixIconData: confirmPasswordVisibility
                        ? Icons.visibility_off
                        : Icons.visibility_rounded,
                    onTapSuffix: () {
                      setState(() {
                        confirmPasswordVisibility = !confirmPasswordVisibility;
                      });
                    },
                    inputType: TextInputType.visiblePassword,
                    inputAction: TextInputAction.done,
                    bottomPadding: 8,
                  ),
                  const SizedBox(height: 30),
                  Obx(() {
                    return KButton(
                      onPressed: onPressedReset,
                      child: authController.isChangePasswordLoading.isTrue
                          ? const KButtonProgressIndicator()
                          : Text(
                              'পরিবর্তন করুন',
                              style: context.buttonTextStyle(),
                            ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onPressedReset() async {
    if (resetPasswordFormKey.currentState!.validate()) {
      await authController.changePassword(
        oldPassword: oldPasswordTextController.text.trim(),
        newPassword: newPasswordTextController.text.trim(),
      );
    }
  }
}

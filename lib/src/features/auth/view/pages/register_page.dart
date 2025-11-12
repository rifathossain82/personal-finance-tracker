import 'package:personal_finance_tracker/src/features/auth/view/widgets/login_redirect_button.dart';
import 'package:personal_finance_tracker/src/features/auth/view/widgets/privacy_policy_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:personal_finance_tracker/src/features/auth/controller/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final authController = Get.find<AuthController>();
  final registerFormKey = GlobalKey<FormState>();
  late final TextEditingController nameTextController;
  late final TextEditingController phoneTextController;
  late final TextEditingController emailTextController;
  late final TextEditingController passwordTextController;
  late final TextEditingController confirmPasswordTextController;

  @override
  void initState() {
    super.initState();
    nameTextController = TextEditingController();
    phoneTextController = TextEditingController();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();

    /// Listener to validate the email status in authController
    emailTextController.addListener(() {
      authController.recheckRegisterEmailValidity(emailTextController.text);
    });
  }

  @override
  void dispose() {
    nameTextController.dispose();
    phoneTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _buildForm(),
            Positioned(
              left: 20,
              child: CustomBackButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
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
              key: registerFormKey,
              child: Column(
                children: [
                  KLogo(),
                  const SizedBox(height: 6),
                  Text('আপনার অ্যাকাউন্ট তৈরি করুন'),
                  const SizedBox(height: 20),
                  KTextFormFieldBuilderWithTitle(
                    controller: nameTextController,
                    validator: Validators.emptyValidator,
                    hintText: 'আপনার নাম লিখুন',
                    title: 'নাম',
                    prefixIconData: Icons.person_outline_rounded,
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                  ),
                  KTextFormFieldBuilderWithTitle(
                    title: 'ফোন নম্বর',
                    hintText: 'আপনার ফোন নম্বর লিখুন',
                    validator: Validators.phoneNumberValidator,
                    controller: phoneTextController,
                    prefixIconData: Icons.call,
                    inputType: TextInputType.phone,
                    inputAction: TextInputAction.next,
                  ),
                  KTextFormFieldBuilderWithTitle(
                    controller: emailTextController,
                    validator: Validators.emailValidator,
                    hintText: 'আপনার ই-মেইল লিখুন',
                    title: 'ই-মেইল',
                    prefixIconData: Icons.mail_outline_rounded,
                    suffixIconData: authController.isRegisterEmailValid.value
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
                        authController.isRegisterPasswordVisibility.isTrue
                            ? Icons.visibility_off
                            : Icons.visibility_rounded,
                    onTapSuffix:
                        authController.toggleRegisterPasswordVisibility,
                    inputType: TextInputType.visiblePassword,
                    inputAction: TextInputAction.next,
                    obscureText:
                        authController.isRegisterPasswordVisibility.value,
                    bottomPadding: 8,
                  ),
                  KTextFormFieldBuilderWithTitle(
                    controller: confirmPasswordTextController,
                    validator: (value) => Validators.confirmPasswordValidator(
                      value,
                      passwordTextController.text.trim(),
                    ),
                    hintText: 'পাসওয়ার্ডটি আবার লিখুন',
                    title: 'পাসওয়ার্ড নিশ্চিত করুন',
                    prefixIconData: Icons.lock_outline_rounded,
                    suffixIconData: authController
                            .isRegisterConfirmPasswordVisibility.isTrue
                        ? Icons.visibility_off
                        : Icons.visibility_rounded,
                    onTapSuffix:
                        authController.toggleRegisterConfirmPasswordVisibility,
                    inputType: TextInputType.visiblePassword,
                    inputAction: TextInputAction.done,
                    obscureText: authController
                        .isRegisterConfirmPasswordVisibility.value,
                    bottomPadding: 8,
                  ),
                  const SizedBox(height: 16),
                  PrivacyPolicyWidget(),
                  const SizedBox(height: 30),
                  KButton(
                    onPressed: onPressedSignUp,
                    child: authController.isRegisterLoading.isTrue
                        ? const KButtonProgressIndicator()
                        : Text(
                            'তৈরি করুন',
                            style: context.buttonTextStyle(),
                          ),
                  ),
                  const SizedBox(height: 24),
                  LoginRedirectButton(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void onPressedSignUp() {
    if (!registerFormKey.currentState!.validate()) {
      return;
    }

    if (authController.isPrivacyPolicyChecked.isFalse) {
      SnackBarService.showSnackBar(
        message: 'পরিষেবার শর্তাবলী ও গোপনীয়তা নীতিতে সম্মত থাকলে টিক দিন',
        bgColor: failedColor,
      );
      return;
    }

    authController.register(
      name: nameTextController.text.trim(),
      phone: phoneTextController.text.trim(),
      email: emailTextController.text.trim(),
      password: passwordTextController.text.trim(),
    );
  }
}

import 'package:personal_finance_tracker/src/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class ResendEmailButton extends StatelessWidget {
  final AuthController authController;

  const ResendEmailButton({
    super.key,
    required this.authController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't receive the verification email?",
          style: context.bodyLarge(
            color: kGrey,
          ),
        ),
        const SizedBox(width: 6),
        Obx(() {
          return GestureDetector(
            onTap: () => authController.resendVerificationEmail(),
            behavior: HitTestBehavior.opaque,
            child: authController.isResendVerifyEmailLoading.isTrue
                ? CircularProgressIndicator()
                : Text(
                    "Resend",
                    style: context.bodyLarge(color: kPrimaryColor),
                  ),
          );
        }),
      ],
    );
  }
}

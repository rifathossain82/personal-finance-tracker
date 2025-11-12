import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class LoginRedirectButton extends StatelessWidget {
  const LoginRedirectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: context.bodyLarge(
            color: kGrey,
          ),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: () => Get.back(),
          behavior: HitTestBehavior.opaque,
          child: Text(
            "Login",
            style: context.bodyLarge(
              color: kPrimaryColor
            ),
          ),
        ),
      ],
    );
  }
}

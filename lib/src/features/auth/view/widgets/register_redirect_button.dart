import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class RegisterRedirectButton extends StatelessWidget {
  const RegisterRedirectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: context.bodyLarge(
            color: kGrey,
          ),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: () => Get.toNamed(RouteGenerator.register),
          behavior: HitTestBehavior.opaque,
          child: Text(
            "Create Account",
            style: context.bodyLarge(
              color: kPrimaryColor
            ),
          ),
        ),
      ],
    );
  }
}

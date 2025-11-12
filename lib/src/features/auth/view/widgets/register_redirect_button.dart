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
          "কোন অ্যাকাউন্ট নেই?",
          style: context.bodyLarge(
            color: kGrey,
          ),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: () => Get.toNamed(RouteGenerator.register),
          behavior: HitTestBehavior.opaque,
          child: Text(
            "তৈরি করুন",
            style: context.bodyLarge(
              color: kPrimaryColor
            ),
          ),
        ),
      ],
    );
  }
}

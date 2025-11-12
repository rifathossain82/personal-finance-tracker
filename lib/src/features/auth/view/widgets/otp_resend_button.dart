import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class OtpResendButton extends StatelessWidget {
  final VoidCallback onResend;

  const OtpResendButton({
    super.key,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn’t receive the code?",
          style: context.bodyLarge(
            color: kGrey,
          ),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: onResend,
          behavior: HitTestBehavior.opaque,
          child: Text(
            "Resend",
            style: context.bodyLarge(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}

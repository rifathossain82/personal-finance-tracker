import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class CallNowButton extends StatelessWidget {
  final String? phone;
  final String? label;
  final double height;
  final double borderRadius;

  const CallNowButton({
    super.key,
    required this.phone,
    this.label,
    this.height = 30,
    this.borderRadius = 6,
  });

  @override
  Widget build(BuildContext context) {
    if (phone == null || (phone?.isEmpty ?? false)) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () => UrlLauncherServices.makeCall(phoneNumber: phone!),
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: appGradient(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.call,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 6),
            Text(
              label ?? "কল করুন",
              style: context.buttonTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}

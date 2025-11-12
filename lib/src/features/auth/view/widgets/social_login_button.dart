import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class SocialLoginButton extends StatelessWidget {
  final String svgPath;
  final String btnName;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.svgPath,
    required this.btnName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return KOutlinedButton(
      borderColor: kBorderColor,
      onPressed: onPressed,
      child: SizedBox(
        width: context.screenWidth,
        child: Stack(
          children: [
            Center(
              child: Text(
                btnName,
                style: context.titleMedium(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              left: 8,
              child: SvgPicture.asset(
                svgPath,
                height: 20,
                width: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

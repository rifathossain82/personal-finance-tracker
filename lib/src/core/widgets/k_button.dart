import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/material.dart';

class KButton extends StatelessWidget {
  const KButton({
    super.key,
    this.onPressed,
    required this.child,
    this.borderRadius = 10,
    this.height = 52,
    this.width,
    this.btnColor = kPrimaryColor,
    this.gradient,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final double borderRadius;
  final double height;
  final double? width;
  final Color btnColor;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient ?? appGradient(),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        color: Colors.transparent, // Make button transparent
        height: height,
        minWidth: width ?? context.screenWidth,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        elevation: 0,
        child: child,
      ),
    );
  }
}

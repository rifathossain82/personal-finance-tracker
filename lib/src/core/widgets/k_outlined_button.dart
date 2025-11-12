import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class KOutlinedButton extends StatelessWidget {
  const KOutlinedButton({
    super.key,
    this.onPressed,
    required this.child,
    this.borderRadius,
    this.borderColor,
    this.bgColor,
    this.height,
    this.width,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final double? borderRadius;
  final Color? borderColor;
  final Color? bgColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor ?? kPrimaryColor),
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
      ),
      color: bgColor ?? kWhite,
      height: height ?? 52,
      minWidth: width ?? context.screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      elevation: 0,
      child: child,
    );
  }
}

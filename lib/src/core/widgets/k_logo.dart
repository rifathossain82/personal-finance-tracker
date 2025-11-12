import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class KLogo extends StatelessWidget {
  final double? height;
  final double? width;

  const KLogo({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'KLogo',
      child: Image.asset(
        AssetPath.appLogo,
        height: height ?? 120,
        width: width ?? 120,
      ),
    );
  }
}

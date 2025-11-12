import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String assetPath;
  final double size;
  final double padding;

  const SvgIconButton({
    super.key,
    required this.onPressed,
    required this.assetPath,
    this.size = 20,
    this.padding = 8,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: SvgPicture.asset(
          assetPath,
          height: size,
          width: size,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class KProfileImage extends StatelessWidget {
  final double height;
  final double width;
  final String imgURL;
  final VoidCallback? onTap;
  final String? errorAssetImgPath;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double opacity;
  final bool showShadow;
  final bool isMale;

  const KProfileImage({
    super.key,
    required this.height,
    required this.width,
    required this.imgURL,
    this.onTap,
    this.errorAssetImgPath,
    this.borderColor,
    this.margin,
    this.padding,
    this.opacity = 1,
    this.showShadow = true,
    this.isMale = true,
  });

  @override
  Widget build(BuildContext context) {
    final errorAssetImgPath = AssetPath.person;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: height,
        width: width,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? kGreyLight,
          ),
          boxShadow: [
            if (showShadow)
              BoxShadow(
                color: kBlackLight.withValues(alpha: 0.2),
                offset: const Offset(0.0, 3.0),
                blurRadius: 5,
              )
          ],
        ),
        child: ClipOval(
          child: ExtendedImageBuilder(
            imgURL: imgURL,
            borderRadius: BorderRadius.circular(100),
            height: height,
            width: width,
            fit: BoxFit.cover,
            backgroundColor: kWhite,
            errorAssetPath: errorAssetImgPath,
          ),
        ),
      ),
    );
  }
}

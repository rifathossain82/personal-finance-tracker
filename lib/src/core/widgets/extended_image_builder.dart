import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:personal_finance_tracker/src/core/utils/asset_path.dart';

class ExtendedImageBuilder extends StatelessWidget {
  final String imgURL;
  final BorderRadius borderRadius;
  final double height;
  final double width;
  final BoxFit fit;
  final Color backgroundColor;
  final String? errorAssetPath;

  const ExtendedImageBuilder({
    super.key,
    required this.imgURL,
    required this.borderRadius,
    this.height = 100,
    this.width = double.infinity,
    this.fit = BoxFit.contain,
    this.backgroundColor = Colors.white,
    this.errorAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    /// Handle empty or invalid URL
    if (imgURL.isEmpty ||
        Uri.tryParse(imgURL) == null ||
        !(Uri.tryParse(imgURL)?.hasAbsolutePath ?? false)) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          errorAssetPath ?? AssetPath.placeholder,
          fit: BoxFit.cover,
          height: height,
          width: width,
        ),
      );
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: ExtendedImage.network(
        imgURL,
        height: height,
        width: width,
        fit: fit,
        cache: true,
        loadStateChanged: (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return Image.asset(
                AssetPath.placeholder,
                height: height,
                width: width,
                fit: BoxFit.cover,
              );
            case LoadState.failed:
              return Image.asset(
                errorAssetPath ?? AssetPath.placeholder,
                height: height,
                width: width,
                fit: BoxFit.cover,
              );
            case LoadState.completed:
              return null; // Default completed widget (the loaded image)
          }
        },
      ),
    );
  }
}

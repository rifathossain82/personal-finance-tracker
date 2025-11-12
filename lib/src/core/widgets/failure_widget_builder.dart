import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/extensions/build_context_extension.dart';
import 'package:personal_finance_tracker/src/core/extensions/text_style_extension.dart';
import 'package:personal_finance_tracker/src/core/utils/asset_path.dart';
import 'package:lottie/lottie.dart';

class FailureWidgetBuilder extends StatelessWidget {
  final String? svgIconPath;
  final String? title;
  final double? height;
  final double? width;

  const FailureWidgetBuilder({
    super.key,
    this.svgIconPath,
    this.title,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Lottie.asset(
                  AssetPath.noDataLottie,
                  height: context.screenHeight * 0.27,
                  width: context.screenWidth,
                  alignment: Alignment.center,
                ),
                Positioned(
                  bottom: -10,
                  left: 0,
                  right: 20,
                  child: Text(
                    title ?? 'দুঃখিত! কোনো তথ্য পাওয়া যায়নি',
                    textAlign: TextAlign.center,
                    style: context.bodyMedium(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Navigator.canPop(context)) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () => Get.back(),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: kWhite,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: const Offset(1.0, 1.0),
              color: kItemShadowColor,
              spreadRadius: 0,
              blurRadius: 4,
            )
          ],
        ),
        child: Icon(
          Icons.arrow_back,
          color: kPrimaryColor,
          size: 20,
        ),
      ),
    );
  }
}

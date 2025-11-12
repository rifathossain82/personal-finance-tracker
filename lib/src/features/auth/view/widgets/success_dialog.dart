import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class SuccessDialog {
  static Future<void> show({
    required String title,
    required String content,
    required String btnName,
    required VoidCallback onPressed,
  }) {
    return Get.dialog(
      _DialogWidget(
        title: title,
        content: content,
        btnName: btnName,
        onPressed: onPressed,
      ),
      barrierDismissible: false,
    );
  }
}

class _DialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final String btnName;
  final VoidCallback onPressed;

  const _DialogWidget({
    required this.title,
    required this.content,
    required this.btnName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      title: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kPrimaryColor.withValues(alpha: 0.10),
        ),
        child: Icon(
          Icons.check,
          color: kPrimaryColor,
          size: 56,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: context.titleLarge(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            textAlign: TextAlign.center,
            style: context.bodyLarge(
              fontSize: 16,
            ),
          ),
        ],
      ),
      titlePadding: const EdgeInsets.symmetric(
        vertical: 40,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 20,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.symmetric(
        vertical: 30,
      ),
      actions: [
        KButton(
          onPressed: onPressed,
          width: 185,
          child: Text(
            btnName,
            style: context.buttonTextStyle(),
          ),
        ),
      ],
    );
  }
}

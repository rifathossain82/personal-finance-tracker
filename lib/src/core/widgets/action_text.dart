import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/material.dart';

class ActionText extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String? value;
  final IconData iconData;

  const ActionText({super.key,
    required this.onPressed,
    required this.title,
    required this.value,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    if (value == null || value == '') {
      return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: kPrimaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.bodyMedium(),
                ),
                Text(
                  value ?? "",
                  style: context.titleSmall(),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onPressed,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: appGradient(isCenter: false),
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                size: 16,
                color: kWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
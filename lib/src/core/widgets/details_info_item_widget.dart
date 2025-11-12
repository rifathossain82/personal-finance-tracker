import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/material.dart';

class DetailsInfoItemWidget extends StatelessWidget {
  final String title;
  final String? value;
  final IconData prefixIconData;
  final VoidCallback? onPressed;

  const DetailsInfoItemWidget({
    super.key,
    required this.title,
    required this.value,
    required this.prefixIconData,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (value == null || (value?.isEmpty ?? false)) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.only(
        left: 12,
        top: 8,
        bottom: 8,
      ),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: kPrimaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(
            prefixIconData,
            size: 16,
            color: kPrimaryColor,
          ),
          const SizedBox(width: 12),
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
          if (onPressed != null)
            IconButton(
              onPressed: onPressed,
              visualDensity: VisualDensity(
                vertical: VisualDensity.minimumDensity,
              ),
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                size: 16,
                color: kPrimaryColor,
              ),
            ),
        ],
      ),
    );
  }
}

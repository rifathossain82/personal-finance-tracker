import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class RowIconTextWidget extends StatelessWidget {
  final IconData icon;
  final String? label;
  final int? maxLines;


  const RowIconTextWidget({
    super.key,
    required this.icon,
    required this.label,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: kGreyDark,
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label ?? '',
            maxLines: maxLines,
            style: context.titleSmall(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

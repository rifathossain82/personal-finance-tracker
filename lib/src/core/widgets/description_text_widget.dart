import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  final String? description;

  const DescriptionText({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    if (description?.isEmpty ?? false) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "বিস্তারিত তথ্যঃ",
            style: context.titleMedium(),
          ),
          const SizedBox(height: 4),
          PhoneLinkText(
            text: description ?? "",
            textStyle: context.bodyMedium(),
          ),
        ],
      ),
    );
  }
}

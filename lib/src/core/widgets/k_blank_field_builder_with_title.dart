import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/material.dart';

class KBlankFieldBuilderWithTitle extends StatelessWidget {
  final String title;
  final Widget content;
  final FormFieldValidator? validator;
  final double borderRadius;

  const KBlankFieldBuilderWithTitle({
    super.key,
    required this.title,
    required this.content,
    this.validator,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: RichText(
            maxLines: 1,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: context.titleSmall(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (validator != null)
                  TextSpan(
                    text: ' *',
                    style: context.titleSmall(
                      fontWeight: FontWeight.w600,
                      color: kRed,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kTextFieldFillColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: 1,
              color: kBorderColor,
            ),
          ),
          child: content,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
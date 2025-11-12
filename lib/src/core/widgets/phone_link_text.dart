import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PhoneLinkText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  PhoneLinkText({
    super.key,
    required this.text,
    this.textStyle,
  });

  final RegExp phoneRegex = RegExp(r'(\+?\d[\d\s\-]{7,}\d)');

  @override
  Widget build(BuildContext context) {
    final spans = <TextSpan>[];
    final matches = phoneRegex.allMatches(text);

    int currentIndex = 0;

    for (final match in matches) {
      if (match.start > currentIndex) {
        spans.add(
          TextSpan(
            text: text.substring(currentIndex, match.start),
            style: textStyle,
          ),
        );
      }

      final phoneNumber = match.group(0)!;

      spans.add(
        TextSpan(
          text: phoneNumber,
          style: textStyle?.copyWith(
            color: kPrimaryColor,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              UrlLauncherServices.makeCall(phoneNumber: phoneNumber);
            },
        ),
      );

      currentIndex = match.end;
    }

    if (currentIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(currentIndex),
          style: textStyle,
        ),
      );
    }

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: spans,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class OrTextWidget extends StatelessWidget {
  const OrTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 24,
      ),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: kBorderColor,
              height: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Text(
              'অথবা',
              style: context.titleSmall(
                color: kGreyTextColor,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: kBorderColor,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class StatusBuilder extends StatelessWidget {
  final String status;
  final Color statusColor;

  const StatusBuilder({
    super.key,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        status,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: context.bodyMedium(
          fontWeight: FontWeight.bold,
          color: kWhite,
          fontSize: 8,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class ExtendedFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color bgColor;
  final bool offstage;
  final IconData? iconData;

  const ExtendedFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.bgColor = kPrimaryColor,
    this.offstage = false,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: offstage,
      child: Container(
        decoration: BoxDecoration(
          gradient: appGradient(isCenter: false),
          borderRadius: BorderRadius.circular(50), // Match FAB's shape
        ),
        child: FloatingActionButton.extended(
          onPressed: onPressed,
          backgroundColor: Colors.transparent, // Make button transparent
          elevation: 0, // Remove default shadow
          label: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconData != null
                  ? Icon(
                      iconData!,
                      color: kWhite,
                    )
                  : Image.asset(
                      AssetPath.plusIcon,
                      color: kWhite, // Ensure icon color matches text
                    ),
              const SizedBox(width: 9),
              Text(
                label,
                style: context.titleMedium(
                  color: kWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

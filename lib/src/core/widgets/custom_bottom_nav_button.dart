import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/material.dart';

class CustomBottomNavButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String btnName;

  const CustomBottomNavButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.btnName,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kWhite,
          boxShadow: [
            KBoxShadow.top(),
          ],
        ),
        child: KButton(
          onPressed: onPressed,
          child: isLoading
              ? const KButtonProgressIndicator()
              : Text(
                  btnName,
                  style: context.buttonTextStyle(),
                ),
        ),
      ),
    );
  }
}

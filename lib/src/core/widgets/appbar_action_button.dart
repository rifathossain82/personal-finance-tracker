import 'package:flutter/material.dart';

class AppBarActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  final Color? color;

  const AppBarActionButton({
    super.key,
    required this.onPressed,
    required this.iconData,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          iconData,
          color: color,
        ),
      ),
    );
  }
}

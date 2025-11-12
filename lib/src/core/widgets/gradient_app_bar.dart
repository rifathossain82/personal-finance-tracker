import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final double? leadingWidth;
  final double? titleSpacing;
  final bool? centerTitle;
  final List<Widget>? actions;

  const GradientAppBar({
    super.key,
    required this.title,
    this.leading,
    this.leadingWidth,
    this.titleSpacing,
    this.centerTitle,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      leadingWidth: leadingWidth,
      titleSpacing: titleSpacing,
      centerTitle: centerTitle,
      title: title,
      actions: actions,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: appGradient(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

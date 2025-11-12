import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridViewWidgetBuilder extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final EdgeInsetsGeometry padding;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final int crossAxisCount;
  final bool isScrollable;
  final Color? bgColor;
  final ScrollController? controller;

  const GridViewWidgetBuilder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.padding = const EdgeInsets.all(0),
    this.mainAxisSpacing = 15,
    this.crossAxisSpacing = 15,
    this.crossAxisCount = 3,
    this.isScrollable = true,
    this.bgColor = Colors.white,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: MasonryGridView.count(
        padding: padding,
        shrinkWrap: isScrollable ? false : true,
        controller: controller,
        physics: isScrollable
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        crossAxisCount: crossAxisCount,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}

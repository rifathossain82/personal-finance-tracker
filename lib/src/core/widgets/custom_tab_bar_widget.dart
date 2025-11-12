import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/material.dart';

class CustomTabBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<String> tabItems;
  final void Function(int) onTabChanged;

  const CustomTabBarWidget({
    super.key,
    required this.selectedIndex,
    required this.tabItems,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: StretchingOverscrollIndicator(
        axisDirection: AxisDirection.right,
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.horizontal,
          itemCount: tabItems.length + 1,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final label = index == 0 ? 'সবগুলো' : tabItems[index - 1];
            return _TabBarItemWidget(
              label: label,
              isSelected: selectedIndex == index,
              onTap: () => onTabChanged(index),
            );
          },
        ),
      ),
    );
  }
}

class _TabBarItemWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final bool isSelected;

  const _TabBarItemWidget({
    required this.onTap,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? kPrimaryColor : kWhite,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            width: 1.5,
            color: isSelected ? kPrimaryColor : kBorderColor,
          ),
        ),
        child: Text(
          label,
          style: context.bodyMedium(
            color: isSelected ? kWhite : kBlackLight,
          ),
        ),
      ),
    );
  }
}

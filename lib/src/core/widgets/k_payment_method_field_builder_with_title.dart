import 'package:personal_finance_tracker/src/core/extensions/build_context_extension.dart';
import 'package:personal_finance_tracker/src/core/utils/color.dart';
import 'package:personal_finance_tracker/src/core/widgets/selectable_container.dart';
import 'package:flutter/material.dart';

class KPaymentMethodFieldBuilderWithTitle<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final T? selectedItem;
  final String Function(T?) itemBuilder;
  final Function(T value) onItemChanged;
  final bool hasValidator;
  final double bottomPadding;

  const KPaymentMethodFieldBuilderWithTitle({
    Key? key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.itemBuilder,
    required this.onItemChanged,
    this.hasValidator = true,
    this.bottomPadding = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                'Payment Method',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.appTextTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (hasValidator)
              Text(
                ' *',
                style: context.appTextTheme.titleSmall?.copyWith(
                  color: kRed,
                ),
              ),
          ],
        ),
        const SizedBox(height: 5),
        Wrap(
          alignment: WrapAlignment.start,
          children: [
            Wrap(
              children: items
                  .map(
                    (item) => SelectableContainer(
                      onTap: () => onItemChanged(item),
                      isSelected: selectedItem == item,
                      borderRadius: 30,
                      margin: const EdgeInsets.only(
                        right: 8,
                        bottom: 10,
                      ),
                      child: Text(
                        itemBuilder(item),
                        textAlign: TextAlign.center,
                        style: context.appTextTheme.bodySmall?.copyWith(
                          color: selectedItem == item ? kWhite : kBlackLight,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        SizedBox(height: bottomPadding),
      ],
    );
  }
}

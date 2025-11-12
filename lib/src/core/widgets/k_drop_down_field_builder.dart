import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class KDropDownFieldBuilder<T> extends StatelessWidget {
  final String? hintText;
  final dynamic value;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final Future<List<T>> Function(String? value)? onFind;
  final String Function(T?) itemAsString;
  final List<T>? items;
  final bool Function(T?, T?)? compareFn;
  final bool showSelectedItem;
  final bool showSearchBox;
  final bool isFilteredOnline;

  const KDropDownFieldBuilder({
    super.key,
    required this.value,
    required this.onChanged,
    required this.itemAsString,
    this.hintText = "Select One",
    this.validator,
    this.onFind,
    this.items,
    this.compareFn,
    this.showSelectedItem = true,
    this.showSearchBox = true,
    this.isFilteredOnline = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownSearch<T>(
          compareFn: compareFn ?? (t1, t2) => t1 == t2,
          itemAsString: itemAsString,
          onChanged: onChanged,
          selectedItem: value,
          validator: validator,
          items: (f, cs) => onFind!(f),
          // suffixProps: const DropdownSuffixProps(
          //   clearButtonProps: ClearButtonProps(
          //     isVisible: true,
          //     iconSize: 16,
          //     icon: Icon(
          //       Icons.close,
          //       size: 16,
          //     ),
          //   ),
          // ),
          decoratorProps: DropDownDecoratorProps(
            decoration: _buildInputDecoration(context),
          ),
          popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            showSearchBox: showSearchBox,
            showSelectedItems: showSelectedItem,
            disableFilter: true,
            searchFieldProps: TextFieldProps(
              decoration: _buildInputDecoration(context),
            ),
            errorBuilder: (context, value, __) {
              return const FailureWidgetBuilder();
            },
            emptyBuilder: (context, value) {
              return const FailureWidgetBuilder();
            },
            itemBuilder: (ctx, item, isDisabled, isSelected) {
              return ListTile(
                selected: isSelected,
                title: Text(itemAsString(item)),
              );
            },
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }


  InputDecoration _buildInputDecoration(BuildContext context) => InputDecoration(
    hintText: hintText,
    hintStyle: context.bodyLarge(),
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 12,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: kBorderColor,
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: kBorderColor,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: kBorderColor,
        width: 1,
      ),
    ),
  );
}

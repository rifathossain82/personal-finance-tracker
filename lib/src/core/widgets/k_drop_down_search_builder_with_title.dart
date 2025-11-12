import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class KDropDownSearchBuilderWithTitle<T> extends StatelessWidget {
  final String title;
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
  final double bottomPadding;
  final double borderRadius;
  final Color? fillColor;
  final bool isFilled;

  const KDropDownSearchBuilderWithTitle({
    super.key,
    required this.title,
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
    this.bottomPadding = 15,
    this.borderRadius = 10,
    this.fillColor = kTextFieldFillColor,
    this.isFilled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: RichText(
              maxLines: 1,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: context.titleSmall(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (validator != null)
                    TextSpan(
                      text: ' *',
                      style: context.titleSmall(
                        fontWeight: FontWeight.w600,
                        color: kRed,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          DropdownSearch<T>(
            compareFn: compareFn ?? (t1, t2) => t1 == t2,
            itemAsString: itemAsString,
            onChanged: onChanged,
            selectedItem: value,
            validator: validator,
            items: (f, cs) => isFilteredOnline ? onFind!(f) : items!,
            decoratorProps: DropDownDecoratorProps(
              decoration: _buildInputDecoration(context),
            ),
            popupProps: PopupProps.menu(
              fit: FlexFit.loose,
              showSearchBox: isFilteredOnline ? showSearchBox : false,
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
              menuProps: MenuProps(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              itemBuilder: (ctx, item, isDisabled, isSelected) {
                return ListTile(
                  tileColor: isSelected ? kPrimaryColor : Colors.transparent,
                  dense: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  title: Text(
                    itemAsString(item),
                    style: context.titleSmall(
                      color: isSelected ? kWhite : kBlackLight,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) =>
      InputDecoration(
        hintText: hintText,
        hintStyle: context.bodyLarge(),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
        fillColor: fillColor,
        filled: isFilled,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: kBorderColor,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: kBorderColor,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: kPrimaryColor,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: kRedLight,
            width: 1.0,
          ),
        ),
      );
}

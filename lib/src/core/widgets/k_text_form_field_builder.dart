import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/extensions/text_style_extension.dart';
import 'package:personal_finance_tracker/src/core/utils/color.dart';

class KTextFormFieldBuilder extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final FormFieldValidator? validator;
  final String? hintText;
  final FocusNode? focusNode;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final Color? suffixColor;
  final int maxLine;
  final int minLine;
  final Function(String value)? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onTapPrefix;
  final VoidCallback? onTapSuffix;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool readOnly;
  final bool obscureText;
  final double contentPadding;
  final double bottomPadding;
  final double borderRadius;
  final Color? fillColor;
  final bool isFilled;

  const KTextFormFieldBuilder({
    super.key,
    this.label,
    this.controller,
    this.validator,
    this.hintText,
    this.focusNode,
    this.prefixIconData,
    this.suffixIconData,
    this.suffixColor,
    this.maxLine = 1,
    this.minLine = 1,
    this.onChanged,
    this.onTap,
    this.onTapPrefix,
    this.onTapSuffix,
    this.inputAction = TextInputAction.next,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.contentPadding = 18,
    this.bottomPadding = 15,
    this.borderRadius = 4,
    this.fillColor = kTextFieldFillColor,
    this.isFilled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomPadding,
      ),
      child: TextFormField(
        onTap: onTap,
        onChanged: onChanged,
        controller: controller,
        focusNode: focusNode,
        validator: validator,
        maxLines: maxLine,
        minLines: minLine,
        keyboardType: inputType,
        textInputAction: inputAction,
        textAlign: TextAlign.start,
        readOnly: readOnly,
        obscureText: obscureText,
        style: context.titleSmall(),
        decoration: InputDecoration(
          hintText: hintText,
          labelText: label,
          labelStyle: context.titleSmall(
            fontWeight: FontWeight.w500,
          ),
          hintStyle: context.titleSmall(
            color: kGreyTextColor,
          ),
          isDense: true,
          contentPadding: EdgeInsets.all(contentPadding),
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
          prefixIcon: prefixIconData != null
              ? GestureDetector(
                  onTap: onTapPrefix,
                  behavior: HitTestBehavior.opaque,
                  child: Icon(
                    prefixIconData,
                  ),
                )
              : null,
          suffixIconConstraints: const BoxConstraints(
            maxWidth: 50,
            maxHeight: 50,
            minHeight: 14,
            minWidth: 14,
          ),
          suffixIcon: suffixIconData != null
              ? GestureDetector(
                  onTap: onTapSuffix,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 14,
                      right: 16,
                    ),
                    child: Icon(
                      suffixIconData,
                      color: suffixColor,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

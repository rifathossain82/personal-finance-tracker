import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class KTextFormFieldBuilderWithTitle extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final FormFieldValidator? validator;
  final String? hintText;
  final String? secondaryHintText;
  final FocusNode? focusNode;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final Color? suffixColor;
  final int maxLine;
  final int minLine;
  final Function(String value)? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onTapSuffix;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool readOnly;
  final bool obscureText;
  final double bottomPadding;
  final double borderRadius;
  final Color fillColor;
  final bool isFilled;

  const KTextFormFieldBuilderWithTitle({
    super.key,
    required this.title,
    this.controller,
    this.validator,
    this.hintText,
    this.secondaryHintText,
    this.focusNode,
    this.prefixIconData,
    this.suffixIconData,
    this.suffixColor,
    this.maxLine = 1,
    this.minLine = 1,
    this.onChanged,
    this.onTap,
    this.onTapSuffix,
    this.inputAction = TextInputAction.next,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.bottomPadding = 15,
    this.borderRadius = 10,
    this.fillColor = kTextFieldFillColor,
    this.isFilled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 4),
            Expanded(
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
            if (secondaryHintText != null)
              Text(
                secondaryHintText ?? '',
                textAlign: TextAlign.end,
                style: context.bodyLarge(),
              ),
          ],
        ),
        const SizedBox(height: 6),
        TextFormField(
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
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: context.bodyLarge(),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            errorMaxLines: 3,
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
            prefixIcon: prefixIconData != null ? Icon(prefixIconData) : null,
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
        SizedBox(height: bottomPadding),
      ],
    );
  }
}

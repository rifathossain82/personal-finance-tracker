import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class PinFieldWidget extends StatelessWidget {
  final int length;
  final double borderRadius;
  final TextEditingController? fieldController;
  final int? maxLines;
  final Color? fillColor;
  final bool? isProtected;
  final bool? isEditable;
  final FocusNode? focusNode;
  final TextInputType keyType;
  final Function? validation;

  const PinFieldWidget({
    super.key,
    required this.length,
    this.borderRadius = 10,
    this.isEditable,
    this.maxLines,
    this.focusNode,
    this.fillColor,
    this.isProtected = false,
    this.fieldController,
    this.keyType = TextInputType.number,
    this.validation,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: length,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(borderRadius),
        fieldHeight: 64,
        fieldWidth: context.screenWidth / (length + 1),
        activeFillColor: Colors.white,
        activeColor: kPrimaryColor,
        inactiveColor: kGreyLight,
        inactiveFillColor: kGreyLight,
        selectedColor: kPrimaryColor,
        selectedFillColor: kPrimaryColor.withValues(alpha: 0.15),
      ),
      animationDuration: const Duration(milliseconds: 300),
      //backgroundColor: Colors.blue.shade50,
      enableActiveFill: true,
      controller: fieldController,
      keyboardType: keyType,
      onCompleted: (v) {
        kPrint("Completed");
      },
      onChanged: (value) {
        kPrint(value);
      },
      beforeTextPaste: (text) {
        kPrint("Allowing to paste $text");

        /// if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        /// but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
      appContext: context,
    );
  }
}

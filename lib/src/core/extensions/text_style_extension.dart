import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

extension TextStyleExtension on BuildContext {
  TextStyle titleLarge({
    FontWeight fontWeight = FontWeight.w700,
    double fontSize = 20,
    Color color = kBlackLight,
  }) {
    return Theme.of(this).textTheme.titleLarge?.copyWith(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    ) ??
        TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
        );
  }

  TextStyle titleMedium({
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 16,
    Color color = kBlackLight,
  }) {
    return Theme.of(this).textTheme.titleMedium?.copyWith(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    ) ??
        TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
        );
  }

  TextStyle titleSmall({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 14,
    Color color = kBlackLight,
  }) {
    return Theme.of(this).textTheme.titleSmall?.copyWith(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    ) ??
        TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
        );
  }

  TextStyle bodyLarge({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 14,
    Color color = kGreyTextColor,
  }) {
    return Theme.of(this).textTheme.bodyLarge?.copyWith(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    ) ??
        TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
        );
  }

  TextStyle bodyMedium({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 12,
    Color color = kGreyTextColor,
  }) {
    return Theme.of(this).textTheme.bodyMedium?.copyWith(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    ) ??
        TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
        );
  }

  TextStyle bodySmall({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize = 10,
    Color color = kGreyTextColor,
  }) {
    return Theme.of(this).textTheme.bodySmall?.copyWith(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    ) ??
        TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
        );
  }

  TextStyle buttonTextStyle({
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 16,
    Color color = kWhite,
  }) {
    return Theme.of(this).textTheme.titleSmall?.copyWith(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    ) ??
        TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
        );
  }

  TextStyle outlinedButtonTextStyle({
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 16,
    Color color = kPrimaryColor,
  }) {
    return Theme.of(this).textTheme.titleSmall?.copyWith(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    ) ??
        TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
        );
  }
}

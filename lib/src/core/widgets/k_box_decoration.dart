import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class KBoxDecoration {
  static BoxDecoration itemDecoration() => BoxDecoration(
    color: kWhite,
    borderRadius: BorderRadius.circular(15),
    border: Border.all(
      color: kGrey.withOpacity(0.5),
      width: 0.75,
    ),
  );
}

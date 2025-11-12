import 'package:intl/intl.dart';

extension NumberExtension on num {
  String get formattedNumber {
    return NumberFormat('#,##,###').format(abs());
  }

  bool get isPositive {
    return this >= 0;
  }
}

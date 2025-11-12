import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// Returns the date in 'yyyy/MM/dd' format (e.g., 01/01/2023).
  String get formattedDateWithSlashes {
    return "$year/$month/$day";
  }

  /// Returns the date in 'dd-MM-yyyy' format (e.g., 01-01-2023).
  String get formattedDate {
    return DateFormat('dd-MM-yyyy').format(this);
  }

  /// Returns the time in 'hh:mm a' format (e.g., 03:30 PM).
  String get formattedTime {
    return DateFormat('hh:mm a').format(this);
  }

  /// Returns the date in 'MMMM yyyy' format (e.g., February 2024).
  String get formattedMonthAndYear {
    return DateFormat('MMMM yyyy').format(this);
  }

  /// Returns the date in 'dd' format (e.g., 14).
  String get formattedDay {
    return DateFormat('dd').format(this);
  }

  /// Returns the date in 'MMMM' format (e.g., September).
  String get formattedMonth {
    return DateFormat('MMMM').format(this);
  }

  /// Returns the date and time in 'dd MMM yyyy, hh:mm AM/PM' format.
  /// (e.g., 01-01-2023, 03:30 PM).
  String get formattedDateTime {
    return DateFormat('dd-MM-yyyy, hh:mm a').format(this);
  }

  String formatDateTime(String customFormat) {
    return DateFormat(customFormat).format(this);
  }

  /// Returns the date in 'yyyy-MM-dd' format (e.g., 2023-01-01).
  String get formattedRequestDate {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get formatDuration {
    String suffix = "আগে";
    DateTime now = DateTime.now();

    /// Calculate years, months, days, hours, and minutes
    int years = now.year - year;
    int months = now.month - month;
    int days = now.day - day;

    if(now.isBefore(this)){
      suffix = "পরে";
      years = year - now.year;
      months = month - now.month;
      days = day - now.day;
    }

    /// Adjust if necessary
    if (days < 0) {
      months--;
      days += DateTime(now.year, now.month, 0)
          .day; // Get days in the previous month
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    /// Build the formatted string in Bengali
    StringBuffer result = StringBuffer();
    if (years > 0) result.write("$years বছর ");
    if (months > 0) result.write("$months মাস ");
    if (days > 0) result.write("$days দিন ");

    /// is duration == 0, means today
    /// otherwise, add suffix and return duration
    if(result.isEmpty){
      result.write('আজকেই');
    } else {
      result.write(' $suffix');
    }

    /// Convert the numbers in the result to Bengali numerals
    return _convertToBengaliNumeral(result.toString().trim());
  }

  String _convertToBengaliNumeral(String input) {
    const englishToBengali = {
      '0': '০',
      '1': '১',
      '2': '২',
      '3': '৩',
      '4': '৪',
      '5': '৫',
      '6': '৬',
      '7': '৭',
      '8': '৮',
      '9': '৯',
    };

    /// Replace each digit in the string with its Bengali counterpart
    return input.split('').map((char) {
      return englishToBengali[char] ?? char; // Replace only if it's a digit
    }).join('');
  }
}

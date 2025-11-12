import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:personal_finance_tracker/src/core/services/dialog_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

/// Debug Print Utility
///
/// ## Usage
/// To log debug information, call `kPrint(data)` with the desired [data] to print.
/// The information will be displayed in the console during debugging sessions.
///
/// Example:
/// ```dart
/// kPrint("Debug information");
/// ```
void kPrint(dynamic data) {
  if (kDebugMode) {
    print(data);
  }
}

void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

/// To share any thing by third party app
void kShareData({
  required String data,
  String? subject,
}) {
  SharePlus.instance.share(
    ShareParams(
      text: data,
      subject: subject,
    )
  );
}

Future<bool> confirmSubmission(BuildContext context) async {
  bool? result = await DialogService.confirmationDialog(
    context: context,
    title: 'আপনি কি নিশ্চিত?',
    subtitle: 'আপনি কি নিশ্চিত যে এখানে প্রদত্ত সমস্ত তথ্য সঠিক এবং সত্য?',
    negativeActionText: 'বাতিল করুন',
    positiveActionText: 'হ্যাঁ, নিশ্চিত',
  );

  if (result == false) {
    SnackBarService.showSnackBar(
      message: 'অনুগ্রহ করে সঠিক তথ্য প্রদান করুন!',
      bgColor: failedColor,
    );
    return false;
  }
  return true;
}

Future<bool?> dataDeleteConfirmationDialog({
  required BuildContext context,
  required String titleSubject, // উদাহরণ: 'ডেটা', 'প্রফেশনাল', 'ব্যবহারকারী'
}) {
  return DialogService.confirmationDialog(
    context: context,
    title: '$titleSubject ডিলিট',
    subtitle: 'আপনি কি নিশ্চিত যে আপনি এই $titleSubject ডিলিট করতে চান?',
    negativeActionText: 'বাতিল করুন',
    positiveActionText: 'ডিলিট করুন',
  );
}


LinearGradient appGradient({bool isCenter = true, List<Color>? colors}) {
  final Alignment begin = isCenter ? Alignment.centerLeft : Alignment.topLeft;
  final Alignment end =
      isCenter ? Alignment.centerRight : Alignment.bottomRight;

  return LinearGradient(
    begin: begin,
    end: end,
    colors: colors ?? [leftGradientColor, rightGradientColor],
  );
}





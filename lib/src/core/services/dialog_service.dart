import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DialogService {
  static Future<bool?> confirmationDialog({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String negativeActionText,
    required String positiveActionText,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          title: Text(
            title,
            style: context.titleLarge(),
          ),
          content: Text(
            subtitle,
            style: context.bodyMedium(),
          ),
          titlePadding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 15,
          ),
          contentPadding: const EdgeInsets.all(15),
          actionsPadding: const EdgeInsets.all(15.0),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: KOutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    borderColor: kPrimaryColor,
                    borderRadius: 4,
                    height: 42,
                    child: Text(
                      negativeActionText,
                      style: context.outlinedButtonTextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: KButton(
                    onPressed: () => Navigator.pop(context, true),
                    borderRadius: 4,
                    height: 42,
                    child: Text(
                      positiveActionText,
                      style: context.buttonTextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static Future<bool?> customDialog({
    required BuildContext context,
    required String title,
    required AlignmentGeometry dialogPosition,
    List<Widget>? actions,
    Widget? content,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: content,
            ),
            insetPadding: const EdgeInsets.all(15),
            alignment: dialogPosition,
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: context.titleMedium(),
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: actions,
          );
        });
  }

  static Future<bool?> loadingDialog({
    required BuildContext context,
    required AlignmentGeometry dialogPosition,
    required Widget content,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                child: content,
              ),
            ],
          ),
          insetPadding: const EdgeInsets.all(15),
          alignment: dialogPosition,
        );
      },
    );
  }

  static Future<void> logoutDialog(BuildContext context) {
    // final authController = Get.find<AuthController>();

    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 150,
                  width: context.screenWidth * 0.8,
                  decoration: BoxDecoration(
                    gradient: appGradient(),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15),
                    ),
                  ),
                  child: Lottie.asset(
                    AssetPath.logoutLottie,
                    height: 120,
                    width: 120,
                  ),
                ),
                Container(
                  height: 150,
                  width: context.screenWidth * 0.8,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(15),
                    ),
                    color: kWhite,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "আপনি লগ আউট করতে চলেছেন। \nআপনি কি নিশ্চিত যে আপনি লগ আউট করতে চান?",
                        textAlign: TextAlign.center,
                        style: context.titleSmall(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'বাতিল করুন',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          // KButton(
                          //   width: context.screenWidth * 0.4,
                          //   height: 42,
                          //   onPressed: () {
                          //     authController.logout();
                          //   },
                          //   child: Obx(() {
                          //     return authController.isLogoutLoading.value
                          //         ? const KButtonProgressIndicator()
                          //         : Text(
                          //       'লগআউট',
                          //       style: context.buttonTextStyle(
                          //         fontSize: 14,
                          //       ),
                          //     );
                          //   }),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static void welcomeDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Background with image
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage('assets/images/village.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Glass blur box at bottom
                  Positioned(
                    top: 8,
                    left: 8,
                    right: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        KLogo(
                          height: 50,
                          width: 50,
                        ),
                        Text(
                          '${AppConstants.appName} অ্যাপ এ স্বাগতম',
                          style: context.titleMedium(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('আমাদের গ্রাম, আমদের গর্ব',
                            style: context.bodyMedium(
                              color: kBlackLight,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Close Button
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 16,
                  child: Icon(Icons.close, color: Colors.white, size: 18),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CupertinoDatePickerDialog {
  static Future<DateTime?> show({
    required BuildContext context,
    required DateTime initialDate,
    required ValueChanged<DateTime> onDateChanged,
    required VoidCallback onDone,
  }) {
    return showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          _buildDatePicker(
            initialDate: initialDate,
            onDateChanged: onDateChanged,
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            onDone();
            Navigator.pop(context);
          },
          child: const Text('Done'),
        ),
      ),
    );
  }

  static Widget _buildDatePicker({
    required DateTime initialDate,
    required ValueChanged<DateTime> onDateChanged,
  }) {
    return SizedBox(
      height: 200,
      child: CupertinoDatePicker(
        minimumYear: DateTime.now().year - 30,
        maximumYear: DateTime.now().year + 30,
        initialDateTime: initialDate,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: onDateChanged,
      ),
    );
  }
}
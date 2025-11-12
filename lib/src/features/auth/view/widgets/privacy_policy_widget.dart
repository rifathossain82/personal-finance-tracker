import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:personal_finance_tracker/src/features/auth/controller/auth_controller.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Obx(() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              side: BorderSide(
                color: kGrey,
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              value: authController.isPrivacyPolicyChecked.value,
              onChanged: (value) => authController.togglePrivacyPolicyCheck(),
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'আমি ${AppConstants.appName} এর ',
                    style: context.bodyLarge(
                      color: kGrey,
                    ),
                  ),
                  TextSpan(
                    text: 'পরিষেবার শর্তাবলী ',
                    style: context.bodyLarge(
                      color: kPrimaryColor,
                    ),
                  ),
                  TextSpan(
                    text: 'ও ',
                    style: context.bodyLarge(
                      color: kGrey,
                    ),
                  ),
                  TextSpan(
                    text: 'গোপনীয়তা নীতিতে',
                    style: context.bodyLarge(
                      color: kPrimaryColor,
                    ),
                  ),
                  TextSpan(
                    text: ' সম্মত আছি',
                    style: context.bodyLarge(
                      color: kGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

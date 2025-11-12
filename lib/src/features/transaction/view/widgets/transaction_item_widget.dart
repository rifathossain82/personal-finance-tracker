import 'package:personal_finance_tracker/src/core/enums/app_enum.dart';
import 'package:personal_finance_tracker/src/core/extensions/build_context_extension.dart';
import 'package:personal_finance_tracker/src/core/services/dialog_service.dart';
import 'package:personal_finance_tracker/src/core/utils/asset_path.dart';
import 'package:personal_finance_tracker/src/core/utils/color.dart';
import 'package:personal_finance_tracker/src/core/widgets/status_builder.dart';
import 'package:personal_finance_tracker/src/core/widgets/svg_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/features/transaction/data/model/transaction_model.dart';

import '../../../../core/core.dart';

class TransactionItemWidget extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItemWidget({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: kGreyLight,
            width: 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(12),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           // Text(
            //           //   transaction.contact?.name ?? "Unknown",
            //           //   style: context.appTextTheme.bodySmall?.copyWith(
            //           //     fontWeight: FontWeight.bold,
            //           //   ),
            //           // ),
            //           const SizedBox(height: 8),
            //           if (transaction.paymentMethod != null)
            //             StatusBuilder(
            //               status: transaction.paymentMethod ?? "",
            //               statusColor: kBlue,
            //             ),
            //         ],
            //       ),
            //       const SizedBox(width: 8),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.end,
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Text(
            //             "${transaction.amount ?? 0}",
            //             style: context.appTextTheme.bodySmall?.copyWith(
            //               fontWeight: FontWeight.bold,
            //               color: transaction.type == TransactionType.cashIn
            //                   ? kGreen
            //                   : kRed,
            //             ),
            //           ),
            //           const SizedBox(height: 8),
            //           Text(
            //             "${transaction.dateTime?.formattedDateTime}",
            //             textAlign: TextAlign.start,
            //             style: context.appTextTheme.bodySmall?.copyWith(
            //               color: kGreyTextColor,
            //               fontSize: 11,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // const KDivider(height: 0),
            // Padding(
            //   padding: const EdgeInsets.all(12),
            //   child: Row(
            //     children: [
            //       Text(
            //         'Remarks: ${transaction.remarks ?? ''}',
            //         style: context.appTextTheme.bodySmall?.copyWith(
            //           fontWeight: FontWeight.w500,
            //           color: kGreyTextColor,
            //           fontSize: 11,
            //         ),
            //       ),
            //       const Spacer(),
            //       SvgIconButton(
            //         onPressed: onEditTransaction,
            //         assetPath: AssetPath.editIcon,
            //       ),
            //       const SizedBox(width: 30),
            //       SvgIconButton(
            //         onPressed: () => onDeleteTransaction(context),
            //         assetPath: AssetPath.deleteIcon,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void onEditTransaction() {
    // Get.toNamed(
    //   RouteGenerator.transactionAddUpdate,
    //   arguments: TransactionAddUpdatePageArguments(
    //     transactionType: transaction.type!,
    //     existingTransaction: transaction,
    //   ),
    // );
  }

  void onDeleteTransaction(BuildContext context) async {
    bool? result = await DialogService.confirmationDialog(
      context: context,
      title: "Delete Transaction?",
      subtitle:
          "Are you sure you want to delete this transaction? This action cannot be undone.",
      negativeActionText: 'cancel'.toUpperCase(),
      positiveActionText: 'delete'.toUpperCase(),
    );

    if (result ?? false) {
      // final transactionController = Get.find<TransactionController>();
      // transactionController.deleteTransaction(transaction.id!);
    }
  }
}

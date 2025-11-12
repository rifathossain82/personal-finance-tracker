import 'package:personal_finance_tracker/src/core/utils/color.dart';
import 'package:personal_finance_tracker/src/core/widgets/bottom_loader.dart';
import 'package:personal_finance_tracker/src/core/widgets/failure_widget_builder.dart';
import 'package:personal_finance_tracker/src/core/widgets/k_custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/features/transaction/controller/transaction_controller.dart';
import 'package:personal_finance_tracker/src/features/transaction/view/widgets/transaction_item_widget.dart';

class TransactionListWidget extends StatelessWidget {
  final TransactionController transactionController;
  final ScrollController scrollController;

  const TransactionListWidget({
    super.key,
    required this.transactionController,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (transactionController.isTransactionsLoading.value) {
        return const KCustomLoader();
      } else if (transactionController.transactions.isEmpty) {
        return const _TransactionFailureWidget();
      } else {
        return _TransactionList(
          transactionController: transactionController,
          scrollController: scrollController,
        );
      }
    });
  }
}

class _TransactionFailureWidget extends StatelessWidget {
  const _TransactionFailureWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const FailureWidgetBuilder(),
    );
  }
}

class _TransactionList extends StatelessWidget {
  final TransactionController transactionController;
  final ScrollController scrollController;

  const _TransactionList({
    required this.transactionController,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15),
      controller: scrollController,
      itemCount: transactionController.transactions.length,
      itemBuilder: (context, index) {
        // if (index == transactionController.transactionList.length) {
        //   return transactionController.loadedCompleted.value
        //       ? Container()
        //       : const BottomLoader();
        // }
        return TransactionItemWidget(
          transaction: transactionController.transactions[index],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}

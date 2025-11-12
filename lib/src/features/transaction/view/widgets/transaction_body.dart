import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/features/transaction/controller/transaction_controller.dart';
import 'package:personal_finance_tracker/src/features/transaction/view/widgets/net_balance_card_widget.dart';
import 'package:personal_finance_tracker/src/features/transaction/view/widgets/transaction_list_widget.dart';

class TransactionBody extends StatefulWidget {
  const TransactionBody({super.key});

  @override
  State<TransactionBody> createState() => _TransactionBodyState();
}

class _TransactionBodyState extends State<TransactionBody> {
  final transactionController = Get.find<TransactionController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    transactionController.loadTransactions();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        await transactionController.loadTransactions();
      },
      child: Column(
        children: [
          const NetBalanceCardWidget(),
          const TitleTextWidget(title: "Transaction List : "),
          Expanded(
            child: TransactionListWidget(
              transactionController: transactionController,
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }
}

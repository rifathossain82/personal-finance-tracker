import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/src/features/transaction/view/pages/transaction_add_update_page.dart';
import 'package:personal_finance_tracker/src/features/transaction/view/widgets/transaction_body.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      appBar: GradientAppBar(title: const Text(AppConstants.appName)),
      body: SafeArea(child: const TransactionBody()),
      bottomNavigationBar: _BottomNavigationBar(
        onCashIn: _onCashIn,
        onCashOut: _onCashOut,
      ),
    );
  }

  void _onCashIn() {
    Get.toNamed(
      RouteGenerator.transactionAddUpdate,
      arguments: TransactionAddUpdatePageArguments(
        transactionType: TransactionType.cashIn,
      ),
    );
  }

  void _onCashOut() {
    Get.toNamed(
      RouteGenerator.transactionAddUpdate,
      arguments: TransactionAddUpdatePageArguments(
        transactionType: TransactionType.cashOut,
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final VoidCallback onCashIn;
  final VoidCallback onCashOut;

  const _BottomNavigationBar({required this.onCashIn, required this.onCashOut});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: kWhite, boxShadow: [KBoxShadow.top()]),
      child: Row(
        children: [
          Expanded(
            child: KIconButton(
              onPressed: onCashIn,
              iconData: Icons.add,
              title: "cash in".toUpperCase(),
              bgColor: kGreen,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: KIconButton(
              onPressed: onCashOut,
              iconData: CupertinoIcons.minus,
              title: "cash out".toUpperCase(),
              bgColor: kRed,
            ),
          ),
        ],
      ),
    );
  }
}

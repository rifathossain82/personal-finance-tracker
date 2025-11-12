import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:personal_finance_tracker/src/features/auth/controller/auth_controller.dart';
import 'package:personal_finance_tracker/src/features/transaction/view/pages/transaction_add_update_page.dart';
import 'package:personal_finance_tracker/src/features/transaction/view/widgets/transaction_body.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      appBar: GradientAppBar(
        title: const Text(AppConstants.appName),
        actions: [
          PopupMenuButton(
            color: kWhite,
            onSelected: (value) {
              if (value == 1) {
                _onPressedChangePassword();
              } else if (value == 2) {
                _onPressedLogout(context);
              }
            },
            icon: Icon(Icons.more_vert_outlined, color: kWhite),
            itemBuilder: (BuildContext context) => [
              popupMenuItemBuilder(
                value: 1,
                icon: Icons.password_outlined,
                iconColor: kGrey,
                title: "Change Password",
              ),
              popupMenuItemBuilder(
                value: 2,
                icon: Icons.logout,
                iconColor: kGrey,
                title: "Logout",
              ),
            ],
          ),
        ],
      ),
      body: const TransactionBody(),
      bottomNavigationBar: _BottomNavigationBar(
        onCashIn: _onCashIn,
        onCashOut: _onCashOut,
      ),
    );
  }

  void _onPressedChangePassword() {
    Get.toNamed(RouteGenerator.resetPassword);
  }

  void _onPressedLogout(BuildContext context) async {
    final authController = Get.find<AuthController>();

    showDialog(
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
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  color: kPrimaryColor,
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
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
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
                      'You are about to logout.\nAre you sure this is what you want?',
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        KButton(
                          width: context.screenWidth * 0.4,
                          btnColor: kPrimaryColor,
                          onPressed: () {
                            authController.logout();
                          },
                          child: Obx(() {
                            return authController.isLoginLoading.value
                                ? const KButtonProgressIndicator()
                                : Text(
                                    'Confirm Logout',
                                    style: context.buttonTextStyle(),
                                  );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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

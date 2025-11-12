import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/features/transaction/controller/transaction_controller.dart';
import 'package:personal_finance_tracker/src/features/transaction/data/model/transaction_model.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class TransactionAddUpdatePageArguments {
  final TransactionType transactionType;
  final TransactionModel? existingTransaction;

  TransactionAddUpdatePageArguments({
    required this.transactionType,
    this.existingTransaction,
  });
}

class TransactionAddUpdatePage extends StatefulWidget {
  final TransactionAddUpdatePageArguments arguments;

  const TransactionAddUpdatePage({super.key, required this.arguments});

  @override
  State<TransactionAddUpdatePage> createState() =>
      _TransactionAddUpdatePageState();
}

class _TransactionAddUpdatePageState extends State<TransactionAddUpdatePage> {
  final transactionController = Get.find<TransactionController>();

  TransactionModel? existingTransaction;
  final formKey = GlobalKey<FormState>();

  final amountTextController = TextEditingController();
  final remarkTextController = TextEditingController();

  DateTime? selectedDateTime = DateTime.now();
  dynamic selectedContact;
  PaymentMethod? selectedPaymentMethod;
  String? selectedCategory;

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime!,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    selectedPaymentMethod = PaymentMethod.cash;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.arguments.existingTransaction != null) {
        existingTransaction = widget.arguments.existingTransaction;

        selectedDateTime = existingTransaction?.date;
        amountTextController.text = "${existingTransaction?.amount ?? 0}";
        selectedPaymentMethod = getSelectedPaymentMethod(existingTransaction);
        remarkTextController.text = existingTransaction?.remark ?? '';
        selectedCategory = existingTransaction?.category;
      }

      setState(() {});
    });
  }

  PaymentMethod getSelectedPaymentMethod(
    TransactionModel? existingTransaction,
  ) {
    if (existingTransaction?.paymentMethod == PaymentMethod.cash) {
      return PaymentMethod.cash;
    } else if (existingTransaction?.paymentMethod == PaymentMethod.bkash) {
      return PaymentMethod.bkash;
    } else {
      return PaymentMethod.cash;
    }
  }

  @override
  void dispose() {
    amountTextController.dispose();
    remarkTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String action = widget.arguments.existingTransaction != null
        ? "Update"
        : "Add";

    String title = '';

    if (widget.arguments.transactionType == TransactionType.cashIn) {
      title = "$action Cash In Transaction";
    } else {
      title = "$action Cash Out Transaction";
    }

    return Scaffold(
      appBar: GradientAppBar(title: Text(title)),
      body: _transactionFormWidget(),
      bottomNavigationBar: SafeArea(
        child: _BottomNavigationBar(
          transactionType: widget.arguments.transactionType,
          onSave: _onSave,
          transactionController: transactionController,
        ),
      ),
    );
  }

  Widget _transactionFormWidget() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KTextFormFieldBuilderWithTitle(
                title: 'Date & Time',
                hintText: selectedDateTime?.formattedDateTime,
                inputAction: TextInputAction.next,
                readOnly: true,
                prefixIconData: Icons.date_range,
                onTap: () => _selectDateTime(context),
              ),
              KDropDownSearchBuilderWithTitle<String>(
                title: 'Category',
                value: selectedCategory,
                hintText: 'Select category',
                items:
                    widget.arguments.transactionType == TransactionType.cashIn
                    ? AppConstants.cashInCategories
                    : AppConstants.cashOutCategories,
                validator: Validators.emptyValidator,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedCategory = value;
                      hideKeyboard();
                    });
                  }
                },
                itemAsString: (item) => item.toString(),
                showSelectedItem: true,
                showSearchBox: false,
                isFilteredOnline: false,
              ),
              KTextFormFieldBuilderWithTitle(
                controller: amountTextController,
                title: 'Amount',
                hintText: '0',
                inputAction: TextInputAction.next,
                inputType: TextInputType.number,
                validator: Validators.emptyValidator,
              ),
              KTextFormFieldBuilderWithTitle(
                controller: remarkTextController,
                title: 'Remark',
                hintText: "Enter any additional comments or notes",
                inputAction: TextInputAction.next,
                inputType: TextInputType.text,
              ),
              KPaymentMethodFieldBuilderWithTitle(
                title: 'Payment Method',
                items: PaymentMethod.values,
                selectedItem: selectedPaymentMethod,
                itemBuilder: (item) => item?.name.capitalizedFirst ?? '',
                onItemChanged: (item) {
                  setState(() {
                    selectedPaymentMethod = item;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSave() {
    /// Validate the form fields
    if (!formKey.currentState!.validate()) {
      return;
    }

    /// Check if a payment method is selected
    if (selectedPaymentMethod == null) {
      SnackBarService.showSnackBar(
        message: "Select a payment method!",
        bgColor: kPrimaryColor,
      );
      return;
    }

    /// Add or update the transaction based on the existing transaction status
    if (existingTransaction == null) {
      addNewTransaction();
    } else {
      updateTransaction();
    }
  }

  String get _userId{
    final String? userId = LocalStorage.getData(
      key: LocalStorageKey.userId,
    );

    if (userId == null) {
      throw 'User ID not found';
    }

    return userId;
  }

  void addNewTransaction() {
    final newTransaction = TransactionModel(
      userId: _userId,
      type: widget.arguments.transactionType,
      paymentMethod: selectedPaymentMethod,
      amount: num.tryParse(amountTextController.text) ?? 0,
      category: selectedCategory,
      remark: remarkTextController.text.trim(),
      date: selectedDateTime,
      createdAt: DateTime.now(),
    );

    transactionController
        .addTransaction(transaction: newTransaction)
        .then((value) => Get.back());
  }

  void updateTransaction() {
    final newTransaction = TransactionModel(
      id: existingTransaction?.id,
      userId: _userId,
      type: existingTransaction?.type,
      paymentMethod: selectedPaymentMethod,
      amount: num.tryParse(amountTextController.text) ?? 0,
      category: selectedCategory,
      remark: remarkTextController.text.trim(),
      date: selectedDateTime,
    );

    transactionController
        .updateTransaction(transaction: newTransaction)
        .then((value) => Get.back());
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final TransactionType transactionType;
  final VoidCallback onSave;
  final TransactionController transactionController;

  const _BottomNavigationBar({
    required this.transactionType,
    required this.onSave,
    required this.transactionController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: kWhite, boxShadow: [KBoxShadow.top()]),
      child: Obx(() {
        return KIconButton(
          onPressed: onSave,
          iconData: Icons.check,
          title: "save".toUpperCase(),
          bgColor: transactionType == TransactionType.cashIn ? kGreen : kRed,
          isLoading:
              transactionController.isAddTransactionLoading.value ||
              transactionController.isUpdateTransactionLoading.value,
        );
      }),
    );
  }
}

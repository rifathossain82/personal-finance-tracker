import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:personal_finance_tracker/src/features/transaction/data/model/transaction_model.dart';
import 'package:personal_finance_tracker/src/features/transaction/data/repository/transaction_repository.dart';

class TransactionController extends GetxController {
  final TransactionRepository _repository = Get.find<TransactionRepository>();

  /// Loading states
  var isAddTransactionLoading = false.obs;
  var isUpdateTransactionLoading = false.obs;
  var isDeleteTransactionLoading = false.obs;

  /// Transaction list
  var transactions = <TransactionModel>[].obs;
  var isTransactionsLoading = true.obs;

  /// Summary data
  var totalCashIn = 0.0.obs;
  var totalCashOut = 0.0.obs;
  var balance = 0.0.obs;

  /// Selected transaction for editing
  Rx<TransactionModel?> selectedTransaction = Rx<TransactionModel?>(null);

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  /// Load all transactions for current user
  void loadTransactions() {
    try {
      final String? userId = LocalStorage.getData(
        key: LocalStorageKey.userId,
      );

      if (userId == null) {
        Log.error('User ID not found in local storage');
        return;
      }

      isTransactionsLoading(true);

      _repository.getTransactions(userId: userId).listen(
            (transactionList) {
          transactions.value = transactionList;
          _calculateSummary();
          isTransactionsLoading(false);
        },
        onError: (error) {
          Log.error('Error loading transactions: $error');
          isTransactionsLoading(false);
        },
      );
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);
      isTransactionsLoading(false);
    }
  }

  /// Calculate summary (total cash in, cash out, and balance)
  void _calculateSummary() {
    double cashIn = 0.0;
    double cashOut = 0.0;

    for (var transaction in transactions) {
      if (transaction.type == TransactionType.cashIn) {
        cashIn += (transaction.amount ?? 0);
      } else {
        cashOut += (transaction.amount ?? 0);
      }
    }

    totalCashIn.value = cashIn;
    totalCashOut.value = cashOut;
    balance.value = cashIn - cashOut;
  }

  /// Add a new transaction
  Future<void> addTransaction({
    required TransactionModel transaction,
  }) async {
    try {
      isAddTransactionLoading(true);

      final String? userId = LocalStorage.getData(
        key: LocalStorageKey.userId,
      );

      if (userId == null) {
        throw 'User ID not found';
      }

      Result result = await _repository.addTransaction(
        transaction: transaction,
      );

      if (result.isSuccess) {
        Get.back();
        SnackBarService.showSnackBar(
          message: transaction.type == TransactionType.cashIn
              ? 'ক্যাশ ইন সফলভাবে যোগ করা হয়েছে'
              : 'ক্যাশ আউট সফলভাবে যোগ করা হয়েছে',
          bgColor: successColor,
        );
      } else {
        SnackBarService.showSnackBar(
          message: result.message ?? 'লেনদেন যোগ করতে ব্যর্থ',
          bgColor: failedColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isAddTransactionLoading(false);
    }
  }

  /// Update an existing transaction
  Future<void> updateTransaction({
    required TransactionModel transaction,
  }) async {
    try {
      isUpdateTransactionLoading(true);

      final String? userId = LocalStorage.getData(
        key: LocalStorageKey.userId,
      );

      if (userId == null) {
        throw 'User ID not found';
      }

      Result result = await _repository.updateTransaction(
        transactionId: transaction.id!,
        transaction: transaction,
      );

      if (result.isSuccess) {
        Get.back();
        SnackBarService.showSnackBar(
          message: 'লেনদেন সফলভাবে আপডেট করা হয়েছে',
          bgColor: successColor,
        );
        selectedTransaction.value = null;
      } else {
        SnackBarService.showSnackBar(
          message: result.message ?? 'লেনদেন আপডেট করতে ব্যর্থ',
          bgColor: failedColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isUpdateTransactionLoading(false);
    }
  }

  /// Delete a transaction
  Future<void> deleteTransaction(String transactionId) async {
    try {
      isDeleteTransactionLoading(true);

      Result result = await _repository.deleteTransaction(
        transactionId: transactionId,
      );

      if (result.isSuccess) {
        Get.back();
        SnackBarService.showSnackBar(
          message: 'লেনদেন সফলভাবে মুছে ফেলা হয়েছে',
          bgColor: successColor,
        );
      } else {
        SnackBarService.showSnackBar(
          message: result.message ?? 'লেনদেন মুছতে ব্যর্থ',
          bgColor: failedColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(
        message: e.toString(),
        bgColor: failedColor,
      );
    } finally {
      isDeleteTransactionLoading(false);
    }
  }

  /// Load transaction for editing
  Future<void> loadTransactionForEdit(String transactionId) async {
    try {
      TransactionModel? transaction = await _repository.getTransactionById(
        transactionId: transactionId,
      );
      selectedTransaction.value = transaction;
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);
    }
  }

  /// Clear selected transaction
  void clearSelectedTransaction() {
    selectedTransaction.value = null;
  }

  /// Get filtered transactions
  List<TransactionModel> getFilteredTransactions({
    TransactionType? type,
    String? category,
  }) {
    List<TransactionModel> filtered = transactions;

    if (type != null) {
      filtered = filtered.where((t) => t.type == type).toList();
    }

    if (category != null && category.isNotEmpty) {
      filtered = filtered.where((t) => t.category == category).toList();
    }

    return filtered;
  }
}
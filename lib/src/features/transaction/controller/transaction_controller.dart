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

  /// Load all transactions for current user
  Future<void> loadTransactions() async {
    try {
      final String? userId = LocalStorage.getData(key: LocalStorageKey.userId);

      if (userId == null) {
        Log.error('User ID not found in local storage');
        return;
      }

      isTransactionsLoading(true);

      final transactions = await _repository.getTransactions(userId: userId);
      this.transactions.value = transactions;
      _calculateSummary();

      Log.debug("Transactions: ${transactions.length}");
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);
    } finally {
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
  Future<void> addTransaction({required TransactionModel transaction}) async {
    try {
      isAddTransactionLoading(true);

      Result result = await _repository.addTransaction(
        transaction: transaction,
      );

      if (result.isSuccess) {
        Get.back();
        loadTransactions();
        SnackBarService.showSnackBar(
          message: transaction.type == TransactionType.cashIn
              ? 'Cash In added successfully'
              : 'Cash Out added successfully',
          bgColor: successColor,
        );
      } else {
        SnackBarService.showSnackBar(
          message: result.message ?? 'Failed to add transaction',
          bgColor: failedColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(message: e.toString(), bgColor: failedColor);
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

      final String? userId = LocalStorage.getData(key: LocalStorageKey.userId);

      if (userId == null) {
        throw 'User ID not found';
      }

      Result result = await _repository.updateTransaction(
        transactionId: transaction.id!,
        transaction: transaction,
      );

      if (result.isSuccess) {
        Get.back();
        loadTransactions();
        SnackBarService.showSnackBar(
          message: 'Transaction updated successfully',
          bgColor: successColor,
        );
        selectedTransaction.value = null;
      } else {
        SnackBarService.showSnackBar(
          message: result.message ?? 'Failed to update transaction',
          bgColor: failedColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(message: e.toString(), bgColor: failedColor);
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
        loadTransactions();
        SnackBarService.showSnackBar(
          message: 'Transaction deleted successfully',
          bgColor: successColor,
        );
      } else {
        SnackBarService.showSnackBar(
          message: result.message ?? 'Failed to delete transaction',
          bgColor: failedColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(message: e.toString(), bgColor: failedColor);
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

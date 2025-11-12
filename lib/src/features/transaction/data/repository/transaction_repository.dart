import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:personal_finance_tracker/src/features/transaction/data/model/transaction_model.dart';

class TransactionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'transactions';

  /// Add a new transaction
  Future<Result> addTransaction({
    required TransactionModel transaction,
  }) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      await _firestore.collection(_collectionName).add(transaction.toJson());
      return Result.success();
    } catch (e) {
      Log.error("Error adding transaction: ${e.toString()}");
      rethrow;
    }
  }

  /// Update an existing transaction
  Future<Result> updateTransaction({
    required String transactionId,
    required TransactionModel transaction,
  }) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      await _firestore
          .collection(_collectionName)
          .doc(transactionId)
          .update(transaction.toJson());
      return Result.success();
    } catch (e) {
      Log.error("Error updating transaction: ${e.toString()}");
      rethrow;
    }
  }

  /// Delete a transaction
  Future<Result> deleteTransaction({
    required String transactionId,
  }) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      await _firestore.collection(_collectionName).doc(transactionId).delete();
      return Result.success();
    } catch (e) {
      Log.error("Error deleting transaction: ${e.toString()}");
      rethrow;
    }
  }

  /// Get all transactions for a specific user
  Future<List<TransactionModel>> getTransactions({
    required String userId,
  }) async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .where('userId', isEqualTo: userId)
          .orderBy('date', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => TransactionModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      Log.error("Error getting transactions: ${e.toString()}");
      rethrow;
    }
  }

  /// Get a single transaction by ID
  Future<TransactionModel?> getTransactionById({
    required String transactionId,
  }) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      DocumentSnapshot doc = await _firestore
          .collection(_collectionName)
          .doc(transactionId)
          .get();

      if (doc.exists) {
        return TransactionModel.fromJson(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }
      return null;
    } catch (e) {
      Log.error("Error getting transaction by ID: ${e.toString()}");
      rethrow;
    }
  }

  /// Get transactions by type (cashIn or cashOut)
  Future<List<TransactionModel>> getTransactionsByType({
    required String userId,
    required TransactionType type,
  }) async {
    try {
      String typeString = type == TransactionType.cashIn ? 'cashIn' : 'cashOut';

      final snapshot = await _firestore
          .collection(_collectionName)
          .where('userId', isEqualTo: userId)
          .where('type', isEqualTo: typeString)
          .orderBy('date', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => TransactionModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      Log.error("Error getting transactions by type: ${e.toString()}");
      rethrow;
    }
  }

  /// Get transactions within a date range
  Future<List<TransactionModel>> getTransactionsByDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .where('userId', isEqualTo: userId)
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
          .where('date', isLessThanOrEqualTo: Timestamp.fromDate(endDate))
          .orderBy('date', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => TransactionModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      Log.error("Error getting transactions by date range: ${e.toString()}");
      rethrow;
    }
  }
}
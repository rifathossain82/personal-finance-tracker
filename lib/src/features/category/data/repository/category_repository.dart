import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:personal_finance_tracker/src/features/category/data/model/category_model.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'categories';

  /// Add a new category
  Future<Result> addCategory({
    required CategoryModel category,
  }) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      await _firestore.collection(_collectionName).add(category.toJson());
      return Result.success();
    } catch (e) {
      Log.error("Error adding category: ${e.toString()}");
      rethrow;
    }
  }

  /// Update an existing category
  Future<Result> updateCategory({
    required String categoryId,
    required CategoryModel category,
  }) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      await _firestore
          .collection(_collectionName)
          .doc(categoryId)
          .update(category.toJson());
      return Result.success();
    } catch (e) {
      Log.error("Error updating category: ${e.toString()}");
      rethrow;
    }
  }

  /// Delete a category
  Future<Result> deleteCategory({
    required String categoryId,
  }) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      await _firestore.collection(_collectionName).doc(categoryId).delete();
      return Result.success();
    } catch (e) {
      Log.error("Error deleting category: ${e.toString()}");
      rethrow;
    }
  }

  /// Get all categories for a specific user
  Future<List<CategoryModel>> getCategories({
    required String userId,
  }) async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      Log.error("Error getting categories: ${e.toString()}");
      rethrow;
    }
  }

  /// Get a single category by ID
  Future<CategoryModel?> getCategoryById({
    required String categoryId,
  }) async {
    try {
      if (!await ConnectivityService.hasInternet) {
        throw Message.noInternet;
      }

      DocumentSnapshot doc = await _firestore
          .collection(_collectionName)
          .doc(categoryId)
          .get();

      if (doc.exists) {
        return CategoryModel.fromJson(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }
      return null;
    } catch (e) {
      Log.error("Error getting category by ID: ${e.toString()}");
      rethrow;
    }
  }

  /// Get categories by type (cashIn or cashOut)
  Future<List<CategoryModel>> getCategoriesByType({
    required String userId,
    required TransactionType type,
  }) async {
    try {
      String typeString = type == TransactionType.cashIn ? 'cashIn' : 'cashOut';

      final snapshot = await _firestore
          .collection(_collectionName)
          .where('userId', isEqualTo: userId)
          .where('type', isEqualTo: typeString)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      Log.error("Error getting categories by type: ${e.toString()}");
      rethrow;
    }
  }
}
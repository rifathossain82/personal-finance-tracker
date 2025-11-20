import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:personal_finance_tracker/src/features/category/data/model/category_model.dart';
import 'package:personal_finance_tracker/src/features/category/data/repository/category_repository.dart';

class CategoryController extends GetxController {
  final CategoryRepository _repository = Get.find<CategoryRepository>();

  /// Loading states
  var isAddCategoryLoading = false.obs;
  var isUpdateCategoryLoading = false.obs;
  var isDeleteCategoryLoading = false.obs;

  /// Category list
  var categories = <CategoryModel>[].obs;
  var filteredCategories = <CategoryModel>[].obs;
  var isCategoriesLoading = true.obs;

  /// Load all categories for current user
  Future<void> loadCategories() async {
    try {
      final String? userId = LocalStorage.getData(key: LocalStorageKey.userId);

      if (userId == null) {
        Log.error('User ID not found in local storage');
        return;
      }

      isCategoriesLoading(true);

      final categories = await _repository.getCategories(userId: userId);
      this.categories.value = categories;
      getFilteredCategories(type: TransactionType.cashIn);

      Log.debug("Categories: ${categories.length}");
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);
    } finally {
      isCategoriesLoading(false);
    }
  }

  /// Get filtered categories based on type
  void getFilteredCategories({required TransactionType type}) {
    List<CategoryModel> filtered = categories;

    filtered = filtered.where((t) => t.type == type).toList();

    filteredCategories.value = filtered;
  }

  /// Add a new category
  Future<void> addCategory({required CategoryModel category}) async {
    try {
      isAddCategoryLoading(true);

      Result result = await _repository.addCategory(category: category);

      if (result.isSuccess) {
        Get.back();
        loadCategories();
        SnackBarService.showSnackBar(
          message: 'Category added successfully',
          bgColor: successColor,
        );
      } else {
        SnackBarService.showSnackBar(
          message: result.message ?? 'Failed to add category',
          bgColor: failedColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isAddCategoryLoading(false);
    }
  }

  /// Update an existing category
  Future<void> updateCategory({required CategoryModel category}) async {
    try {
      isUpdateCategoryLoading(true);

      final String? userId = LocalStorage.getData(key: LocalStorageKey.userId);

      if (userId == null) {
        throw 'User ID not found';
      }

      Result result = await _repository.updateCategory(
        categoryId: category.id!,
        category: category,
      );

      if (result.isSuccess) {
        Get.back();
        loadCategories();
        SnackBarService.showSnackBar(
          message: 'Category updated successfully',
          bgColor: successColor,
        );
      } else {
        SnackBarService.showSnackBar(
          message: result.message ?? 'Failed to update category',
          bgColor: failedColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isUpdateCategoryLoading(false);
    }
  }

  /// Delete a category
  Future<void> deleteCategory(String categoryId) async {
    try {
      isDeleteCategoryLoading(true);

      Result result = await _repository.deleteCategory(categoryId: categoryId);

      if (result.isSuccess) {
        Get.back();
        loadCategories();
        SnackBarService.showSnackBar(
          message: 'Category deleted successfully',
          bgColor: successColor,
        );
      } else {
        SnackBarService.showSnackBar(
          message: result.message ?? 'Failed to delete category',
          bgColor: failedColor,
        );
      }
    } catch (e, stackTrace) {
      Log.error('$e', stackTrace: stackTrace);

      SnackBarService.showSnackBar(message: e.toString(), bgColor: failedColor);
    } finally {
      isDeleteCategoryLoading(false);
    }
  }
}

import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/features/category/controller/category_controller.dart';
import 'package:personal_finance_tracker/src/features/category/data/model/category_model.dart';
import 'package:personal_finance_tracker/src/features/category/view/widgets/category_tem_widget.dart';

class CategoryListWidget extends StatelessWidget {
  final CategoryController categoryController;

  const CategoryListWidget({super.key, required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (categoryController.isCategoriesLoading.value) {
        return const KCustomLoader();
      } else if (categoryController.filteredCategories.isEmpty) {
        return const _TransactionFailureWidget();
      } else {
        return _TransactionList(
          categories: categoryController.filteredCategories,
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
        borderRadius: BorderRadius.circular(12),
      ),
      child: const FailureWidgetBuilder(),
    );
  }
}

class _TransactionList extends StatelessWidget {
  final List<CategoryModel> categories;

  const _TransactionList({required this.categories});

  @override
  Widget build(BuildContext context) {
    return StretchingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      child: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemCount: categories.length,
        itemBuilder: (context, index) =>
            CategoryItemWidget(category: categories[index]),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}

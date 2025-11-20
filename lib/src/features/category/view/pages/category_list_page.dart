import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/features/category/view/widgets/category_list_body.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryBackgroundColor,
      appBar: GradientAppBar(title: const Text('Categories')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteGenerator.categoryAddUpdate);
        },
        child: Icon(Icons.add),
      ),
      body: const CategoryListBody(),
    );
  }
}

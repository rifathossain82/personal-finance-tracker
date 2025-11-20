import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/features/category/controller/category_controller.dart';
import 'package:personal_finance_tracker/src/features/category/data/model/category_model.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class CategoryAddUpdatePage extends StatefulWidget {
  final CategoryModel? existingCategory;

  const CategoryAddUpdatePage({super.key, this.existingCategory});

  @override
  State<CategoryAddUpdatePage> createState() => _CategoryAddUpdatePageState();
}

class _CategoryAddUpdatePageState extends State<CategoryAddUpdatePage> {
  final categoryController = Get.find<CategoryController>();

  CategoryModel? existingCategory;
  final formKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  TransactionType? selectedType = TransactionType.cashIn;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.existingCategory != null) {
        existingCategory = widget.existingCategory;
        nameTextController.text = existingCategory?.name ?? '';
        selectedType = existingCategory?.type;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    nameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String action = widget.existingCategory != null ? "Update" : "Add";
    String title = "$action Category";

    return Scaffold(
      appBar: GradientAppBar(title: Text(title)),
      body: _categoryFormWidget(),
      bottomNavigationBar: SafeArea(
        child: _BottomNavigationBar(
          transactionType: selectedType,
          onSave: _onSave,
          categoryController: categoryController,
        ),
      ),
    );
  }

  Widget _categoryFormWidget() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Transaction Type Selection
              const Text(
                'Category Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _TransactionTypeCard(
                      type: TransactionType.cashIn,
                      icon: Icons.arrow_downward,
                      label: 'Cash In',
                      color: kGreen,
                      isSelected: selectedType == TransactionType.cashIn,
                      onTap: () {
                        setState(() {
                          selectedType = TransactionType.cashIn;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _TransactionTypeCard(
                      type: TransactionType.cashOut,
                      icon: Icons.arrow_upward,
                      label: 'Cash Out',
                      color: kRed,
                      isSelected: selectedType == TransactionType.cashOut,
                      onTap: () {
                        setState(() {
                          selectedType = TransactionType.cashOut;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              KTextFormFieldBuilderWithTitle(
                controller: nameTextController,
                title: 'Category Name',
                hintText: 'Enter category name',
                inputAction: TextInputAction.done,
                inputType: TextInputType.text,
                prefixIconData: Icons.category,
                validator: Validators.emptyValidator,
              ),
              const SizedBox(height: 20),
              if (selectedType != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.blue.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.blue[700],
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'This category will be available for cash ${selectedType == TransactionType.cashIn ? "in" : "out"} transactions.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blue[700],
                          ),
                        ),
                      ),
                    ],
                  ),
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

    /// Check if transaction type is selected
    if (selectedType == null) {
      SnackBarService.showSnackBar(
        message: "Please select a category type!",
        bgColor: kPrimaryColor,
      );
      return;
    }

    /// Check if category name is not empty after trimming
    if (nameTextController.text.trim().isEmpty) {
      SnackBarService.showSnackBar(
        message: "Category name cannot be empty!",
        bgColor: kPrimaryColor,
      );
      return;
    }

    /// Add or update the category based on the existing category status
    if (existingCategory == null) {
      addNewCategory();
    } else {
      updateCategory();
    }
  }

  String get _userId {
    final String? userId = LocalStorage.getData(
      key: LocalStorageKey.userId,
    );

    if (userId == null) {
      throw 'User ID not found';
    }

    return userId;
  }

  void addNewCategory() {
    final newCategory = CategoryModel(
      userId: _userId,
      type: selectedType,
      name: nameTextController.text.trim(),
      createdAt: DateTime.now(),
    );

    categoryController
        .addCategory(category: newCategory)
        .then((value) => Get.back());
  }

  void updateCategory() {
    final updatedCategory = CategoryModel(
      id: existingCategory?.id,
      userId: _userId,
      type: selectedType,
      name: nameTextController.text.trim(),
      createdAt: existingCategory?.createdAt,
    );

    categoryController
        .updateCategory(category: updatedCategory)
        .then((value) => Get.back());
  }
}

class _TransactionTypeCard extends StatelessWidget {
  final TransactionType type;
  final IconData icon;
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _TransactionTypeCard({
    required this.type,
    required this.icon,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.grey[600],
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? color : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final TransactionType? transactionType;
  final VoidCallback onSave;
  final CategoryController categoryController;

  const _BottomNavigationBar({
    required this.transactionType,
    required this.onSave,
    required this.categoryController,
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
          bgColor: transactionType == TransactionType.cashIn
              ? kGreen
              : transactionType == TransactionType.cashOut
              ? kRed
              : kPrimaryColor,
          isLoading: categoryController.isAddCategoryLoading.value ||
              categoryController.isUpdateCategoryLoading.value,
        );
      }),
    );
  }
}
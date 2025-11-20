import 'package:personal_finance_tracker/src/core/services/dialog_service.dart';
import 'package:personal_finance_tracker/src/core/widgets/svg_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/features/category/data/model/category_model.dart';
import 'package:personal_finance_tracker/src/features/category/controller/category_controller.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class CategoryItemWidget extends StatelessWidget {
  final CategoryModel category;

  const CategoryItemWidget({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCashIn = category.type == TransactionType.cashIn;
    final Color typeColor = isCashIn ? kGreen : kRed;

    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: kGreyLight,
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name ?? "Unknown",
                    style: context.appTextTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: typeColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          isCashIn ? 'Cash In' : 'Cash Out',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: typeColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        category.createdAt?.formattedDate ?? '',
                        style: context.appTextTheme.bodySmall?.copyWith(
                          color: kGreyTextColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Action Buttons
            Row(
              children: [
                SvgIconButton(
                  onPressed: () => _onEditCategory(context),
                  assetPath: AssetPath.editIcon,
                ),
                const SizedBox(width: 8),
                SvgIconButton(
                  onPressed: () => _onDeleteCategory(context),
                  assetPath: AssetPath.deleteIcon,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onEditCategory(BuildContext context) {
    Get.toNamed(
      RouteGenerator.categoryAddUpdate,
      arguments: category,
    );
  }

  void _onDeleteCategory(BuildContext context) async {
    bool? result = await DialogService.confirmationDialog(
      context: context,
      title: "Delete Category?",
      subtitle:
      "Are you sure you want to delete this category? This action cannot be undone.",
      negativeActionText: 'cancel'.toUpperCase(),
      positiveActionText: 'delete'.toUpperCase(),
    );

    if (result ?? false) {
      final categoryController = Get.find<CategoryController>();
      categoryController.deleteCategory(category.id!);
    }
  }
}
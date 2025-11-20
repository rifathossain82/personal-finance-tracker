import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/features/category/controller/category_controller.dart';
import 'package:personal_finance_tracker/src/features/category/view/widgets/category_list_widget.dart';

class CategoryListBody extends StatefulWidget {
  const CategoryListBody({super.key});

  @override
  State<CategoryListBody> createState() => _CategoryListBodyState();
}

class _CategoryListBodyState extends State<CategoryListBody>
    with SingleTickerProviderStateMixin {
  late final CategoryController categoryController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    categoryController = Get.find<CategoryController>()..loadCategories();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _loadCategoriesForCurrentTab();
      }
    });
  }

  void _loadCategoriesForCurrentTab() {
    // Assuming your controller has a method to load by type
    // You may need to modify this based on your actual implementation
    if (_tabController.index == 0) {
      categoryController.getFilteredCategories(type: TransactionType.cashIn);
    } else {
      categoryController.getFilteredCategories(type: TransactionType.cashOut);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> onRefresh() async {
    await categoryController.loadCategories();
    _tabController.index = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab Bar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[700],
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_downward, size: 18),
                    SizedBox(width: 8),
                    Text('Cash In'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_upward, size: 18),
                    SizedBox(width: 8),
                    Text('Cash Out'),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Tab View
        Expanded(
          child: CustomRefreshIndicator(
            onRefresh: onRefresh,
            child: CategoryListWidget(categoryController: categoryController),
          ),
        ),
      ],
    );
  }
}

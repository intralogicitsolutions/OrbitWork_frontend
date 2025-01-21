import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/transaction_category_controller.dart';

class SelectTransactionCategoryBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionCategoryController>();

    return GetBuilder<TransactionCategoryController>(
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transaction category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                onChanged: (query) {
                  controller.updateSelectedLabel();
                },
                decoration: InputDecoration(
                  labelText: 'Search categories',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Select All Checkbox
              Row(
                children: [
                  Checkbox(
                    value: controller.isAllSelected.value,
                    onChanged: (value) {
                      controller.toggleSelectAll();
                    },
                  ),
                  Text('All transactions'),
                ],
              ),
              // List of categories with checkboxes
              Expanded(
                child: ListView.builder(
                  itemCount: controller.getFilteredCategories('').length,
                  itemBuilder: (context, index) {
                    final category = controller.getFilteredCategories('')[index];
                    return CheckboxListTile(
                      value: controller.selectedCategories.contains(category),
                      onChanged: (value) {
                        controller.toggleCategorySelection(category);
                      },
                      title: Text(category),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/transaction_category_controller.dart';

class SelectTransactionCategoryBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TransactionCategoryController>();
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
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
          // Search bar
          Container(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search transactions...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              ),
              onChanged: (query) {
                controller.updateSearchQuery(query);
              },
            ),
          ),
          const SizedBox(height: 12),
          // List of clients with checkboxes
          Obx(() {
            final filteredCategories = controller.filteredCategories;

            return Expanded(
              child: ListView.builder(
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  int clientIndex =
                      controller.categories.indexOf(filteredCategories[index]);
                  return ListTile(
                    minVerticalPadding: 0,
                    horizontalTitleGap: 8.0,
                    contentPadding: EdgeInsets.zero,
                    leading: Obx(() => Checkbox(
                          value: controller.selectedCategories[clientIndex],
                          onChanged: (bool? value) {
                            controller.toggleCategorySelection(clientIndex);
                          },
                        )),
                    title: Text(filteredCategories[index]),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

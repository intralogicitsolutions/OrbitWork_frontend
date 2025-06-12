import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../client_profile_controller/project_categories_controller.dart';

class BrowseProjectCategoriesBottomSheet extends StatelessWidget {
  const BrowseProjectCategoriesBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProjectCategoriesController controller = Get.put(ProjectCategoriesController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Browse Project Categories',
        ),
        actions: [
          GestureDetector(
            onTap: controller.onDone,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Done',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
        leading:  GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.close,
            size: 24,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Search Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 2,
                    height: 20,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),

            // Categories List
            Expanded(
              child:  ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  final isSelected = controller.selectedCategory.value == category;

                  return GestureDetector(
                    onTap: () => controller.selectCategory(category),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[200]!,
                            width: 1,
                          ),
                        ),
                        color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            category,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? Colors.blue : Colors.black,
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check,
                              color: Colors.blue,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              )),


            // Bottom indicator
            Container(
              width: 134,
              height: 5,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

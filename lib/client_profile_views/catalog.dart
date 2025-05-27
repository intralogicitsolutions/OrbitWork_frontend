import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../client_profile_controller/catalog_controller.dart';
import '../client_profile_model/catalog_model.dart';

class CatalogPage extends StatelessWidget{
  final CatalogController controller = Get.put(CatalogController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog'),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                onChanged: controller.updateSearchText,
                decoration: InputDecoration(
                  hintText: 'Search projects',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Popular Categories Title
                    const Text(
                      'Popular categories',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Categories List
                    Obx(() => Column(
                      children: [
                        ...controller.displayedCategories.map((category) =>
                            _buildCategoryCard(category),
                        ).toList(),

                        // Show More Button
                       // if (!controller.showMoreCategories.value)
                          GestureDetector(
                            onTap: controller.toggleShowMore,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Text(controller.showMoreCategories.value
                                      ? 'Show Less'
                                      :
                                    'Show More (${controller.moreCategories.length})',
                                    style: const TextStyle(
                                      color: Color(0xFF4CAF50),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    controller.showMoreCategories.value
                                      ? Icons.keyboard_arrow_up
                                      :
                                    Icons.keyboard_arrow_down,
                                    color: const Color(0xFF4CAF50),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    )),

                    const SizedBox(height: 20),

                    // Browse Project Categories Button
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: OutlinedButton(
                        onPressed: () {

                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFF4CAF50),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'Browse Project Categories',
                          style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(CategoryModel category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: () => controller.onCategoryTap(category.title),
      // contentPadding: const EdgeInsets.all(12),
        contentPadding: const EdgeInsets.only(right: 12),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            color: Colors.grey[200],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            child: Image.asset(
              category.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          category.title,
          style: TextStyle(
            color: category.textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        // trailing: const Icon(
        //   Icons.arrow_forward_ios,
        //   color: Colors.grey,
        //   size: 16,
        // ),
      ),
    );
  }
}
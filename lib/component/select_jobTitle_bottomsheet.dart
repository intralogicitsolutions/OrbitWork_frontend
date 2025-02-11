import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/work_experience_controller.dart';

class TitleBottomSheet extends StatelessWidget {
final WorkExperienceController controller = Get.put(WorkExperienceController());
  @override
  Widget build(BuildContext context) {
    return Container(
    //  height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
                Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Clear search button
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    controller.searchTitles('');
                    // You might want to clear the search field here
                  },
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: controller.searchTitles,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),

          // Title List
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: controller.filteredTitles.length,
                itemBuilder: (context, index) {
                  final title = controller.filteredTitles[index];
                  return ListTile(
                    title: Text(
                      title.name,
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      // Handle title selection
                      Get.back(result: title);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
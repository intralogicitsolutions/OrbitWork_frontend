import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/work_experience_controller.dart';

class SelectYearBottomsheet extends StatelessWidget{
  final WorkExperienceController controller = Get.put(WorkExperienceController());
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Year',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Row(
          //     children: [
          //       const Icon(Icons.search),
          //       const SizedBox(width: 8),
          //       Container(
          //         width: 2,
          //         height: 20,
          //         color: Colors.blue,
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
              onChanged: (value) {
                controller.filterYears(value);
              },
            ),
          ),
          Expanded(
            child: Obx(
               () {
                return ListView.builder(
                  itemCount: controller.filteredYears.length,
                  itemBuilder: (context, index) {
                    final year = DateTime.now().year - index;
                    return Obx(() => RadioListTile<int>(
                      value: year,
                      groupValue: controller.selectedYear.value,
                      onChanged: (value) => controller.updateYear(value!),
                      title: Text(
                        year.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ));
                  },
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}

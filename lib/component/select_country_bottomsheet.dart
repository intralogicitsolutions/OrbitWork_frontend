import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/work_experience_controller.dart';

class CountryBottomsheet extends StatelessWidget{
  final WorkExperienceController controller = Get.put(WorkExperienceController());
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  'Country',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
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
                controller.filterCountries(value);
              },
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.filteredCountries.length,
              itemBuilder: (context, index) {
                final country = controller.filteredCountries[index];
                return Obx(() => RadioListTile<String>(
                  value: country,
                  groupValue: controller.selectedCountry.value,
                  onChanged: (value) => controller.updateCountry(value!),
                  title: Text(
                    country,
                    style: const TextStyle(fontSize: 16),
                  ),
                ));
              },
            )),
          ),
        ],
      ),
    );
  }
}

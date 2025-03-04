import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/profile/boost_profile_controller.dart';

class ShowCategoryBottomsheet extends StatelessWidget{
  final BoostProfileController controller = Get.put(BoostProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor
        ),
        padding: EdgeInsets.symmetric(vertical: 20),
        child:  Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Select Category',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return Obx(() => RadioListTile<String>(
                    activeColor: Get.theme.primaryColor,
                    title: Text(category),
                    value: category,
                    groupValue: controller.selectedCategory.value,
                    onChanged: (value) {
                      if (value != null) {
                        controller.setCategory(value);
                        Get.back(); // Close the bottom sheet
                      }
                    },
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
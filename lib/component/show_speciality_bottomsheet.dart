import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/profile/boost_profile_controller.dart';

class ShowSpecialityBottomsheet extends StatelessWidget {
  final BoostProfileController controller = Get.put(BoostProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Select Speciality',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                itemCount: controller.specialities.length,
                itemBuilder: (context, index) {
                  final speciality = controller.specialities[index];
                  return Obx(() => RadioListTile<String>(
                    activeColor: Get.theme.primaryColor,
                    title: Text(speciality),
                    value: speciality,
                    groupValue: controller.selectedSpeciality.value,
                    onChanged: (value) {
                      if (value != null) {
                        controller.setSpeciality(value);
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

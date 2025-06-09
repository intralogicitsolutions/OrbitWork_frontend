import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/client_profile_controller/client_profile_controller.dart';

class WorkExperienceBottomsheet extends StatelessWidget{
  final ClientProfileController controller = Get.put(ClientProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select',style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w500
                  ),),
                  IconButton(onPressed: () {
                    Get.back();
                  }, icon: Icon(Icons.close))
                ],
              ),

              Obx(() => RadioListTile<String>(
                title: const Text('Newest first'),
                value: 'Newest first',
                activeColor: Get.theme.primaryColor,
                groupValue: controller.selectedOption.value,
                onChanged: (value) {
                  if (value != null) controller.selectedOption.value = value;
                },
              )),
              Obx(() => RadioListTile<String>(
                title: const Text('Highest rated'),
                value: 'Highest rated',
                activeColor: Get.theme.primaryColor,
                groupValue: controller.selectedOption.value,
                onChanged: (value) {
                  if (value != null) controller.selectedOption.value = value;
                },
              )),
              Obx(() => RadioListTile<String>(
                title: const Text('Lowest rated'),
                value: 'Lowest rated',
                activeColor: Get.theme.primaryColor,
                groupValue: controller.selectedOption.value,
                onChanged: (value) {
                  if (value != null) controller.selectedOption.value = value;
                },
              )),
              Obx(() => RadioListTile<String>(
                title: const Text('Largest projects'),
                value: 'Largest projects',
                activeColor: Get.theme.primaryColor,
                groupValue: controller.selectedOption.value,
                onChanged: (value) {
                  if (value != null) controller.selectedOption.value = value;
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ViewProfileBottomsheet extends StatelessWidget{
  final ProfilePageController controller = Get.put(ProfilePageController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('View profile', style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500
                ),),
                IconButton(onPressed: () {
                  Get.back();
                }, icon: Icon(Icons.close)),
              ],
            ),
            Obx(() => Column(
              children: [
                RadioListTile(
                  title: Text("Mobile App Development"),
                  activeColor: Get.theme.primaryColor,
                  subtitle: controller.draftStatus["Mobile App Development"]!
                      ? Text("Draft")
                      : null,
                  value: "Mobile App Development",
                  groupValue: controller.selectedWork.value,
                  onChanged: (value) {
                    controller.setSelectedWork(value!);
                  },
                ),
                RadioListTile(
                  title: Text("Creative Writing"),
                  activeColor: Get.theme.primaryColor,
                  subtitle: controller.draftStatus["Creative Writing"]!
                      ? Text("Draft")
                      : null,
                  value: "Creative Writing",
                  groupValue: controller.selectedWork.value,
                  onChanged: (value) {
                    controller.setSelectedWork(value!);
                  },
                ),
                RadioListTile(
                  title: Text("All Work"),
                  activeColor: Get.theme.primaryColor,
                  value: "All Work",
                  groupValue: controller.selectedWork.value,
                  onChanged: (value) {
                    controller.setSelectedWork(value!);
                  },
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

}
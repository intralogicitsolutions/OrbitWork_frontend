import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../client_profile_controller/display_setting_controller.dart';

class DisplaySettingBottomsheet extends StatelessWidget{
  final DisplaySettingController controller = Get.put(DisplaySettingController());

  final types = ['Team', 'Talent', 'Contract', 'Memo', 'Activity ID', 'Activity description'];
  final groupings = ['Day', 'Week', 'Month', 'All time'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Display settings'),
        actions: [
          IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.close)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Show', style: TextStyle(
                      fontSize: 16
                    ),),
                    SizedBox(height: 20,),
                    ...types.map((type) => Obx(() => RadioListTile(
                        title: Text(type),
                        value: type,
                        activeColor: Get.theme.primaryColor,
                        groupValue: controller.selectedType.value,
                        onChanged: (value) => controller.selectedType.value = value!,
                    ),
                    ),),
                    SizedBox(height: 20,),
                    Text('Grouped by', style: TextStyle(
                      fontSize: 16
                    ),),
                    SizedBox(height: 20,),
                    ...groupings.map((group) => Obx(() => RadioListTile(
                        title: Text(group),
                        value: group,
                         activeColor: Get.theme.primaryColor,
                        groupValue: controller.selectedGroup.value,
                        onChanged: (value) => controller.selectedGroup.value = value!,
                    ),),),
                    SizedBox(height: 20,),
                    Text('Customize columns', style: TextStyle(
                      fontSize: 16
                    ),),
                    SizedBox(height: 20,),
                    Obx(() => DropdownButtonFormField<String>(
                      value: controller.selectedColumn.value,
                      decoration: InputDecoration(
                        labelText: "Select Column",
                        border: OutlineInputBorder(), // Bordered like TextField
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      ),
                      items: controller.columns.map((col) {
                        return DropdownMenuItem(value: col, child: Text(col));
                      }).toList(),
                      onChanged: (newValue) {
                        controller.selectedColumn.value = newValue!;
                      },
                    )),

                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(onPressed: () {
                    Get.back();
                  }, child: Text('Cancel', style: TextStyle(color: Get.theme.primaryColor),)),
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Get.theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        ),
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 8)
                      ),
                      child: Text('Apply', style: TextStyle(color: Colors.white),)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/skill_controller.dart';

class SelectCategoriesBottomsheet extends StatelessWidget{
  final SkillsController controller = Get.put(SkillsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        title: Row(
          children: [
            IconButton(onPressed: () {
              Get.back();
            }, icon: Icon(Icons.close)),
            Text('Categories'),
            Spacer(),
            IconButton(onPressed: () {},
                icon: Icon(Icons.more_vert_rounded))
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('What are the main service you offer to clients?', style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500,
                  ),),
                  SizedBox(height: 24,),
                  Text('Select up to 10 categories.', style: TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 16
                  ),),

                  SizedBox(height: 24,),
                  Expanded(
                    child: GetBuilder<SkillsController>(
                      builder: (controller) => ListView.builder(
                        itemCount: controller.categories.length,
                        itemBuilder: (context, index) {
                          final category = controller.categories[index];
                          return Column(
                            children: [
                              ListTile(
                                title: Text(
                                  category.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Obx(() => Text(
                                  controller.selectedSkills
                                      .where((skill) => skill.category == category.name)
                                      .length > 0
                                      ? "(${controller.selectedSkills.where((skill) => skill.category == category.name).length})"
                                      : "›",
                                  style: TextStyle(
                                    color: controller.selectedSkills
                                        .where((skill) => skill.category == category.name)
                                        .length > 0
                                        ? Colors.green
                                        : Colors.black,
                                    fontSize: 18,
                                  ),
                                )),
                                onTap: () => controller.toggleExpansion(index),
                              ),
                              if (category.isExpanded)
                                Column(
                                  children: category.specialties.map((specialty) {
                                    return Obx(() {
                                      final isSelected = controller.selectedSkills.any(
                                            (skill) =>
                                        skill.category == category.name &&
                                            skill.specialty == specialty,
                                      );
                                      return CheckboxListTile(
                                        title: Text(specialty),
                                        value: isSelected,
                                        onChanged: (bool? value) {
                                          if (value == true) {
                                            controller.selectSkill(category.name, specialty);
                                          }
                                        },
                                      );
                                    });
                                  }).toList(),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom + 16,
                left: 16,
                right: 16
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child:
                  // final bool isEnabled = controller.selectedLanguage.isNotEmpty &&
                  //     controller.selectedProficiency.isNotEmpty;
                  ElevatedButton(
                    onPressed: () {},
                    // onPressed: isEnabled ? () {
                    //   // Handle save action
                    //   Get.back();
                    // } : null,
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                    ),
                    child: const Text('Save'),
                  ),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
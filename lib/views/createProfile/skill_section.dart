import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/skill_controller.dart';
import '../../routes/app_routes.dart';


class SkillsSelectionScreen extends StatelessWidget {
  final SkillsController controller = Get.put(SkillsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Obx(() => TextButton.icon(
                  icon: const Icon(Icons.clear, color: Colors.green),
                  label: const Text(
                    'Clear selections',
                    style: TextStyle(color: Colors.green),
                  ),
                  onPressed: controller.selectedSkills.isNotEmpty
                      ? controller.clearSelections
                      : null,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
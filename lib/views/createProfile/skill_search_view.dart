import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_skill_controller.dart';


class SkillsSearchView extends GetView<ProfileSkillController> {
  final ProfileSkillController controller = Get.put(ProfileSkillController());
  //const SkillsSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Enter skills here',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Done',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    onChanged: controller.updateSearchQuery,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search skills...',
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Selected Skills
          Obx(() => Wrap(
            spacing: 8,
            runSpacing: 8,
            children: controller.selectedSkills.map((skill) => Chip(
              label: Text(skill.name),
              deleteIcon: const Icon(Icons.close),
              onDeleted: () => controller.toggleSkill(skill),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.grey),
              ),
              backgroundColor: Colors.white,
            )).toList(),
          )),

          // Search Results
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.filteredSkills.length,
              itemBuilder: (context, index) {
                final skill = controller.filteredSkills[index];
                return ListTile(
                  title: Text(
                    skill.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () => controller.toggleSkill(skill),
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}
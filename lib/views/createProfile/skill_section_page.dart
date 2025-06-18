import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile_skill_controller.dart';
import '../../routes/app_routes.dart';
import 'skill_search_view.dart';

class ProfileSkillView extends GetView<ProfileSkillController> {
  final ProfileSkillController controller = Get.put(ProfileSkillController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                const Text(
                  'Nearly there! What work are you here to do?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Your skills show clients what you can offer, and help us choose which jobs to recommend to you. Add or remove the ones we\'ve suggested, or start typing to pick more. It\'s up to you.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 16),

                // "Why choosing carefully matters" link
                InkWell(
                  onTap: () {Get.defaultDialog(
                    title: 'Orbitwork Pro Tip',
                    titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    content: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Orbitwork's algorithm will recommend specific job posts to you based on your skills. So Choose them carefully to get the best matches!",
                        textAlign: TextAlign.start,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    confirm: Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Button background color
                          elevation: 5, // Button elevation
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Rounded corners
                            // side: const BorderSide(color: Colors.black), // Border color
                          ),
                        ),
                        onPressed: () => Get.back(), // Close the dialog
                        child: const Text('Got it', style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  );},
                  child: const Text(
                    'Why choosing carefully matters',
                    style: TextStyle(
                      color: Colors.green,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.green,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Your skills',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 8),

                // Selected Skills
                Obx(() => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: controller.selectedSkills.map((skill) => Chip(
                    padding: const EdgeInsets.all(2),
                    backgroundColor: Colors.white,
                    label: Text(skill.name),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () => controller.removeSkill(skill),
                  )).toList(),
                )),
                SizedBox(height: 10,),
                Container(
                  height: 40,
                  child: TextField(
                    readOnly: true,
                    onTap: () {
                      Get.to(() =>  SkillsSearchView(),
                        binding: BindingsBuilder(() {
                          Get.put(ProfileSkillController());
                        }),
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter skills here',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 0, horizontal: 12),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'Suggested skills',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 8),

                // Suggested Skills
                Obx(() => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: controller.suggestedSkills.map((skill) => ActionChip(
                    padding: const EdgeInsets.all(2),
                    backgroundColor: Colors.white,
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add, size: 16),
                        const SizedBox(width: 4),
                        Text(skill.name),
                      ],
                    ),
                    onPressed: () => controller.addSkill(skill),
                  )).toList(),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

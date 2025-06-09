import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../client_profile_controller/add_note_controller.dart';

class AddNoteBottomSheet extends StatelessWidget {
  final AddNoteController controller = Get.put(AddNoteController());

  AddNoteBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
         // height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.cancelNote(),
                      child: const Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'Add a note about Eldar...',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.more_vert,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Note Section
                      const Text(
                        'Note',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Note Text Field
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[400]!, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: controller.noteController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: 'What caught your eye about Eldar M.',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Privacy Note
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lock,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "The talent won't see anything you put here.",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Soft Skills Section
                      const Text(
                        'Soft Skills',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Soft Skills Chips
                      Obx(() => Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: controller.availableSoftSkills.map((skill) {
                          final isSelected = controller.selectedSoftSkills.contains(skill);
                          return _buildSoftSkillChip(skill, isSelected);
                        }).toList(),
                      )),

                      const SizedBox(height: 32),

                      // Custom Tags Section
                      const Text(
                        'Custom Tags',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                     // const SizedBox(height: 12),

                      // Custom Tags Input
                      Container(
                        height: 44,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: controller.customTagController,
                          onSubmitted: (value) => controller.addCustomTag(),
                          decoration: const InputDecoration(
                            hintText: 'Start typing',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 6)
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Custom Tags Display
                      Obx(() => controller.customTags.isNotEmpty
                          ? Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: controller.customTags.map((tag) {
                          return _buildCustomTagChip(tag);
                        }).toList(),
                      )
                          : const SizedBox()),

                      const SizedBox(height: 100), // Space for bottom buttons
                    ],
                  ),
                ),
              ),

              // Bottom Buttons
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey[200]!),
                  ),
                ),
                child: Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.cancelNote(),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Save Button
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () => controller.saveNote(),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'Save note',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSoftSkillChip(String skill, bool isSelected) {
    return GestureDetector(
      onTap: () => controller.toggleSoftSkill(skill),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.transparent : Colors.transparent,
          border: Border.all(
            color: isSelected ? Get.theme.secondaryHeaderColor : Colors.grey[400]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              skill,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Get.theme.secondaryHeaderColor,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              isSelected ? Icons.check : Icons.add,
              size: 16,
              color: isSelected ? Get.theme.secondaryHeaderColor : Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTagChip(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => controller.removeCustomTag(tag),
            child: Icon(
              Icons.close,
              size: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

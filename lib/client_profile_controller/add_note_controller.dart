import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNoteController extends GetxController {
  var noteText = ''.obs;
  var customTagText = ''.obs;
  var selectedSoftSkills = <String>[].obs;
  var customTags = <String>[].obs;

  final TextEditingController noteController = TextEditingController();
  final TextEditingController customTagController = TextEditingController();

  // Predefined soft skills
  final List<String> availableSoftSkills = [
    'Budget Minded',
    'Communicates Well',
    'Flexible',
    'Good Advice',
    'Great Quality',
    'Recommends Solutions',
    'Responsive',
    'Strategic Thinker',
  ];

  @override
  void onInit() {
    super.onInit();
    noteController.addListener(() {
      noteText.value = noteController.text;
    });
    customTagController.addListener(() {
      customTagText.value = customTagController.text;
    });
  }

  void toggleSoftSkill(String skill) {
    if (selectedSoftSkills.contains(skill)) {
      selectedSoftSkills.remove(skill);
    } else {
      selectedSoftSkills.add(skill);
    }
  }

  void addCustomTag() {
    if (customTagController.text.trim().isNotEmpty) {
      customTags.add(customTagController.text.trim());
      customTagController.clear();
    }
  }

  void removeCustomTag(String tag) {
    customTags.remove(tag);
  }

  void saveNote() {
    // Implement save functionality here
    print('Note: ${noteText.value}');
    print('Selected Skills: ${selectedSoftSkills.toList()}');
    print('Custom Tags: ${customTags.toList()}');

    // Show success message and close bottom sheet
    Get.snackbar(
      'Success',
      'Note saved successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
    Get.back();
  }

  void cancelNote() {
    // Clear all data
    noteController.clear();
    customTagController.clear();
    selectedSoftSkills.clear();
    customTags.clear();
    Get.back();
  }

  @override
  void onClose() {
    noteController.dispose();
    customTagController.dispose();
    super.onClose();
  }
}

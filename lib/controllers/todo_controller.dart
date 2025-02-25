import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final RxBool isUserAssigned = true.obs;
  final Rx<DateTime?> dueDate = Rx<DateTime?>(null);

  void resetForm() {
    titleController.clear();
    descriptionController.clear();
    isUserAssigned.value = true;
    dueDate.value = null;
  }

  void saveTodo() {
    // Implement save functionality
    Get.back();
  }

  void saveAndAddAnother() {
    // Implement save functionality
    resetForm();
    // Keep the bottom sheet open
  }
}
import 'package:get/get.dart';

class ProjectCategoriesController extends GetxController {
  RxString selectedCategory = ''.obs;

  final List<String> categories = [
    'Design',
    'Video & Audio',
    'Development & IT',
    'Marketing',
    'Writing & Translation',
    'Admin & Customer Support',
    'Consulting & HR',
    'Lifestyle',
  ];

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void onDone() {
    if (selectedCategory.value.isNotEmpty) {
      Get.back(result: selectedCategory.value);
      Get.snackbar(
        'Category Selected',
        'You selected: ${selectedCategory.value}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
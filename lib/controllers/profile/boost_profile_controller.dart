import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoostProfileController extends GetxController {
  final RxInt connects = 0.obs;
  final RxBool isDailySelected = true.obs;
  final RxString selectedDate = ''.obs;
  final TextEditingController connectTextController = TextEditingController();

  final selectedCategory = Rx<String?>(null);
  final selectedSpeciality = Rx<String?>(null);

  void toggleDailyTotal(bool isDaily) {
    isDailySelected.value = isDaily;
  }

  void setDate(String date) {
    selectedDate.value = date;
  }

  final Map<String, List<String>> categorySpecialities = {
    'Accounting': ['Accounting', 'Booking', 'Career', 'Tax Filing'],
    'Admin': ['Business Project', 'Data Entry', 'Office Management', 'Virtual Assistance'],
    'Customer Service': ['Call Center', 'Chat Support', 'Email Support', 'Technical Support']
  };

  List<String> get categories => categorySpecialities.keys.toList();

  List<String> get specialities {
    if (selectedCategory.value == null) return [];
    return categorySpecialities[selectedCategory.value] ?? [];
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    selectedSpeciality.value = null;
  }

  void setSpeciality(String speciality) {
    selectedSpeciality.value = speciality;
  }
}


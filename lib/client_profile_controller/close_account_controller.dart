import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CloseAccountController extends GetxController {
  var selectedReason = ''.obs;

  void selectReason(String reason) {
    selectedReason.value = reason;
  }

  void closeAccount() {
    if (selectedReason.value.isNotEmpty) {
      // Handle account closure logic here
      Get.snackbar(
        'Account Closure',
        'Account closure request submitted',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'Please select a reason for leaving',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void cancelClosure() {
    Get.back();
  }
}
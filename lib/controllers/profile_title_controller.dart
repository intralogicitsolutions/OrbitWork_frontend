import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileTitleController extends GetxController {
  TextEditingController textController = TextEditingController();
  var professionalTitle = ''.obs;
  var showError = false.obs;

  void updateTitle(String value) {
    professionalTitle.value = value;
    validateTitle();
  }

  void validateTitle() {
    showError.value = professionalTitle.value.length < 4 &&
        professionalTitle.value.isNotEmpty;
  }

  void clearTitle() {
    textController.clear();
    professionalTitle.value = '';
   showError.value = false;
  }

  bool canProceed() {
    return professionalTitle.value.length >= 4;
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
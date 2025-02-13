import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvailabilityBadgeController extends GetxController {
  final RxInt connects = 14.obs;
  final RxBool isAvailable = false.obs;
  final TextEditingController connectsTextController = TextEditingController();
  final FocusNode connectsFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    connectsTextController.text = connects.value.toString();

    // Listen for focus changes
    connectsFocusNode.addListener(() {
      if (!connectsFocusNode.hasFocus) {
        validateAndUpdateConnects();
      }
    });
  }

  @override
  void onClose() {
    connectsTextController.dispose();
    connectsFocusNode.dispose();
    super.onClose();
  }


  void validateAndUpdateConnects() {
    int? value = int.tryParse(connectsTextController.text);

    if (value == null || value < 14) {
      connects.value = 0;
      connectsTextController.text = '0';
    } else {
      connects.value = value;
      connectsTextController.text = value.toString();
    }
  }


  void incrementConnects() {
    connects.value++;
    connectsTextController.text = connects.value.toString();
  }

  void decrementConnects() {
    if (connects.value > 0) {
      connects.value--;
      connectsTextController.text = connects.value.toString();
    }
  }

  void toggleAvailability() {
    isAvailable.value = !isAvailable.value;
  }
}
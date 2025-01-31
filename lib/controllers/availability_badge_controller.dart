import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/availability_badge_model.dart';

class BadgeController extends GetxController {
  final Rx<BadgeModel> badge = BadgeModel(
    currentPrice: 14,
    maximumConnects: 14,
    availableConnects: 126,
  ).obs;

  static const int MIN_CONNECTS = 14;
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    textController.text = badge.value.maximumConnects.toString();
  }

  void updateMaximumConnects(int value) {
    if (value < MIN_CONNECTS) {
     // value = MIN_CONNECTS;
    }
    badge.update((val) {
      if (val != null) {
        val.maximumConnects = value;
        textController.text = value.toString();
      }
    });
  }

  void toggleEditing() {
    badge.update((val) {
      if (val != null) {
        val.isEditing = !val.isEditing;
      }
    });
    if (badge.value.isEditing) {
      textController.text = badge.value.maximumConnects.toString();
      focusNode.requestFocus();
    }
  }

  void submitValue() {
    int? value = int.tryParse(textController.text);
    if (value != null) {
      updateMaximumConnects(value);
    }
    focusNode.unfocus();
    badge.update((val) {
      if (val != null) {
        val.isEditing = false;
      }
    });
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void turnOnBadge() {
    // Implement your logic here
    Get.back();
  }
}


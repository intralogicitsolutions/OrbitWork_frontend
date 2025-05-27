import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDetailsController extends GetxController{
  final textController = TextEditingController();
  final errorMessages = <String>[].obs;
  final maxChars = 150;

  RxInt remainingChars = 150.obs;

  void onTextChanged(String value) {
    remainingChars.value = maxChars - value.length;

    errorMessages.clear();

    if (value.length > maxChars) {
      errorMessages.add('Must be less than 150 characters');
    }

    // Check if any word is longer than 50 characters
    if (value.split(' ').any((word) => word.length > 50)) {
      errorMessages.add('Please limit the length of the words to less than 50 characters each');
    }
  }
}
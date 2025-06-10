import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobInviteController extends GetxController {
  var isLoading = false.obs;

  var greeting = "Hello!".obs;
  var message = "I'd like to invite you to take a look at the job I've posted. Please submit a proposal if you're available and interested.".obs;
  var name = "Ishita P.".obs;

  final greetingController = TextEditingController();
  final messageController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void onInit() {
    greetingController.text = greeting.value;
    messageController.text = message.value;
    nameController.text = name.value;
    super.onInit();
  }

  void updateFields() {
    greeting.value = greetingController.text;
    message.value = messageController.text;
    name.value = nameController.text;
  }


  void scheduleConsultation() {
    // Handle consultation scheduling
    Get.back(); // Close bottom sheet
    // Add your consultation logic here
  }

  void completeJobPost() {

  }
}
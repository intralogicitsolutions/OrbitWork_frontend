import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/client_profile/re_enter_password_bottomsheet.dart';

class SecurityQuestionController extends GetxController {
  var selectedQuestion = 'The name of the street you grew up on'.obs;
  var answer = ''.obs;
  var isAccountLockUnderstood = false.obs;
  var keepLoggedIn = false.obs;
  RxBool keepMeLoggedIn = false.obs;

  final TextEditingController answerController = TextEditingController();

  final List<String> securityQuestions = [
    'The name of the street you grew up on',
    'Your first pet\'s name',
    'Your mother\'s maiden name',
    'The name of your elementary school',
    'Your elementary school mascot',
    'Your best friend\'s nickname',
    'Your favorite sports team',
    'Your favorite writer',
    'Your favorite actor',
    'Your favorite singer',
    'Your favorite song',
    'Make and model of your first car',
    'The city where you first met your spouse',
    'Other...',
  ];

  @override
  void onInit() {
    super.onInit();
    answerController.addListener(() {
      answer.value = answerController.text;
    });
  }

  @override
  void onClose() {
    answerController.dispose();
    super.onClose();
  }

  void selectQuestion(String question) {
    selectedQuestion.value = question;
    Get.back();
  }

  void toggleAccountLockUnderstanding() {
    isAccountLockUnderstood.value = !isAccountLockUnderstood.value;
  }

  void toggleKeepLoggedIn() {
    keepLoggedIn.value = !keepLoggedIn.value;
  }

  void showQuestionDropdown() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Security Question',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              ...securityQuestions.map((question) =>
                  ListTile(
                    title: Text(
                      question,
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () => selectQuestion(question),
                    trailing: selectedQuestion.value == question
                        ? Icon(Icons.check, color: Color(0xFF4CAF50))
                        : null,
                  )
              ).toList(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void cancel() {
    Get.back();
  }

  void save() {
    if (answer.value.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please provide an answer to your security question',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
      return;
    }

    if (!isAccountLockUnderstood.value) {
      Get.snackbar(
        'Warning',
        'Please confirm you understand the account lock policy',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange[100],
        colorText: Colors.orange[800],
      );
      return;
    }

    Get.snackbar(
      'Success',
      'Security question saved successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green[100],
      colorText: Colors.green[800],
    );
    Get.bottomSheet(
      ReEnterPasswordBottomsheet(),
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
  }

  void toggleKeepMeLoggedIn(bool? value) {
    keepMeLoggedIn.value = value ?? false;
  }
}
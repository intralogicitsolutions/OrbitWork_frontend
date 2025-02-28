import 'package:get/get.dart';

class SecurityQuestionController extends GetxController {
  final selectedQuestion = RxString("");
  final answer = RxString("");
  final understandLockout = RxBool(false);
  final keepLoggedIn = RxBool(false);

  final List<String> securityQuestions = [
    "Your favorite sports team",
    "Your first pet's name",
    "Your mother's maiden name",
    "Your elementary school mascot",
    "Your childhood nickname",
    "Your best friend's nickname",
    "your favorite writer",
    "Your favorite actor",
  ];

  bool get canSave =>
      selectedQuestion.isNotEmpty &&
          answer.isNotEmpty &&
          understandLockout.value;
}
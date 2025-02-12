import 'package:get/get.dart';

class ProfileOverviewController extends GetxController{
  var maxCharacters = 5000;
  var remainingCharacters = 5000.obs;

  void updateCharacterCount(String text) {
    remainingCharacters.value = maxCharacters - text.length;
  }
}
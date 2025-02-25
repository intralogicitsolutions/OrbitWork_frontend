import 'package:get/get.dart';

class FlagInappropriateController extends GetxController{
  var selectedReason = ''.obs;
  var remainingCharacters = 4000.obs;

  void updateCharacterCount(String text) {
    remainingCharacters.value = 4000 - text.length;
  }
}
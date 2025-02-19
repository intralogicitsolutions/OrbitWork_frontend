import 'package:get/get.dart';

class ChangePreferenceController extends GetxController {
  final RxBool isAIDataAllowed = false.obs;

  void toggleAIData(bool value) {
    isAIDataAllowed.value = value;
  }
}
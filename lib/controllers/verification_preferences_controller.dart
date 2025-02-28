import 'package:get/get.dart';

class VerificationPreferencesController extends GetxController {

  final selectedVerificationMethod = RxInt(-1);

  final selectedVerificationFrequency = RxInt(0);

  void setVerificationMethod(int index) {
    selectedVerificationMethod.value = index;
  }

  void setVerificationFrequency(int index) {
    selectedVerificationFrequency.value = index;
  }

  bool get canSave => selectedVerificationMethod.value >= 0;
}
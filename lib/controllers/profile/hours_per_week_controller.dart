import 'package:get/get.dart';

class HoursPerWeekController extends GetxController {
  final RxString selectedHours = ''.obs;
  final RxBool isContractToHire = false.obs;

  void setHours(String value) {
    selectedHours.value = value;
  }

  void toggleContractToHire(bool? value) {
    isContractToHire.value = value ?? false;
  }
}
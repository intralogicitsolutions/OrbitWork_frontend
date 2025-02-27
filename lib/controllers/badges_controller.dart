import 'package:get/get.dart';

class BadgesController extends GetxController {
  final RxBool isProfileComplete = false.obs;
  final RxBool noAccountHolds = true.obs;

  void toggleProfileComplete() {
    isProfileComplete.value = !isProfileComplete.value;
  }

  void toggleAccountHolds() {
    noAccountHolds.value = !noAccountHolds.value;
  }
}
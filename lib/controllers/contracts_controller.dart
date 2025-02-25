import 'package:get/get.dart';

class ContractController extends GetxController{
  final isShowing = true.obs;
  final isVisible = true.obs;

  void dismissWarningText() {
    isShowing.value = false;
  }

  void hideUpgradePlan() {
    isVisible.value = false;
  }
}
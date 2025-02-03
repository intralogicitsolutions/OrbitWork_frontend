import 'package:get/get.dart';

class AddBillingController extends GetxController {
  final RxString selectedMethod = ''.obs;

  void setSelectedMethod(String method) {
    selectedMethod.value = method;
  }

  void addPaymentMethod() {

    Get.back();
  }
}
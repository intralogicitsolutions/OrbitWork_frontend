import 'package:get/get.dart';

class BillingController extends GetxController {
  final RxString primaryMethod = ''.obs;

  void updatePrimaryMethod(String method) {
    primaryMethod.value = method;
  }

  void removePrimaryMethod() {
    primaryMethod.value = '';
  }
}

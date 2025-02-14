import 'package:get/get.dart';

class VerificationController extends GetxController{
  var hasServed = false.obs;

  void setHasServed(bool value) {
    hasServed.value = value;
  }
}
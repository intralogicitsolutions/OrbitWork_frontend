import 'package:get/get.dart';

class ChangePasswordController extends GetxController{
  var isPasswordHidden = true.obs;
  var isNewPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleNewPasswordVisibility(){
    isNewPasswordHidden.value = !isNewPasswordHidden.value;
  }
}
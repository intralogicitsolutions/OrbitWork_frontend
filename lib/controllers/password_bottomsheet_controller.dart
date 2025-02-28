import 'package:get/get.dart';

class PasswordBottomSheetController extends GetxController {
  final passwordVisible = false.obs;
  final confirmPasswordVisible = false.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisible.value = !confirmPasswordVisible.value;
  }

  bool get canSave =>
      password.value.isNotEmpty &&
          confirmPassword.value.isNotEmpty &&
          password.value == confirmPassword.value;
}
import 'package:get/get.dart';

class PasswordAndSecurityController extends GetxController {
  final _biometricAuthenticationEnabled = false.obs;
  final _twoStepVerificationEnabled = false.obs;
  final _smsTextMessagesEnabled = false.obs;
  final _authenticatorAppCodesEnabled = false.obs;

  bool get biometricAuthenticationEnabled => _biometricAuthenticationEnabled.value;
  bool get twoStepVerificationEnabled => _twoStepVerificationEnabled.value;
  bool get smsTextMessagesEnabled => _smsTextMessagesEnabled.value;
  bool get authenticatorAppCodesEnabled => _authenticatorAppCodesEnabled.value;

  void toggleBiometricAuthentication(bool value) {
    _biometricAuthenticationEnabled.value = value;
  }

  void toggleTwoStepVerification(bool value) {
    _twoStepVerificationEnabled.value = value;
  }

  void toggleSmsTextMessages(bool value) {
    _smsTextMessagesEnabled.value = value;
  }

  void toggleAuthenticatorAppCodes(bool value) {
    _authenticatorAppCodesEnabled.value = value;
  }

  void changePassword() {
    // Implement logic to change the Upwork password
  }

  void updateSecurityQuestionAndAnswer() {
    // Implement logic to update the security question and answer
  }
}
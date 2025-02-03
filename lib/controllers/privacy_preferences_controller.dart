import 'package:get/get.dart';

class PrivacyPreferencesController extends GetxController {
  final _performanceCookiesEnabled = true.obs;
  final _functionalCookiesEnabled = true.obs;
  final _targetingCookiesEnabled = true.obs;

  bool get performanceCookiesEnabled => _performanceCookiesEnabled.value;
  bool get functionalCookiesEnabled => _functionalCookiesEnabled.value;
  bool get targetingCookiesEnabled => _targetingCookiesEnabled.value;

  void togglePerformanceCookies(bool value) {
    _performanceCookiesEnabled.value = value;
  }

  void toggleFunctionalCookies(bool value) {
    _functionalCookiesEnabled.value = value;
  }

  void toggleTargetingCookies(bool value) {
    _targetingCookiesEnabled.value = value;
  }

  void rejectAll() {
    _performanceCookiesEnabled.value = false;
    _functionalCookiesEnabled.value = false;
    _targetingCookiesEnabled.value = false;
  }

  void confirmChoices() {
    // Implement logic to save the user's cookie preferences
  }
}
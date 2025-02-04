
import 'package:get/get.dart';

import '../models/privacy_preference_model.dart';


class PrivacyPreferencesController extends GetxController {
  var isPrivacyTextExpanded = false.obs;
  var cookies = <PrivacyPreferenceModel>[
    PrivacyPreferenceModel(title: "Strictly Necessary Cookies", description: " These cookies are essential for users to browse or use our website and its features, such as accessing secure areas of the site..."),
    PrivacyPreferenceModel(title: "Performance Cookies", description: "These cookies allow us to count visits in traffic sources so we can measure and improve the performance of...", isEnabled: true),
    PrivacyPreferenceModel(title: "Functional Cookies", description: "These cookies enable the website to provide enhanced functionality and personalisation...", isEnabled: true),
    PrivacyPreferenceModel(title: "Targeting Cookies", description: "These cookies track users' online activity to help advertisers deliver more relevant advertising...", isEnabled: true),
  ].obs;


  void toggleCookie(int index) {
    cookies[index].isEnabled = !cookies[index].isEnabled!;
    cookies.refresh();
  }

  void toggleExpand(int index) {
    cookies[index].isExpanded = !cookies[index].isExpanded;
    cookies.refresh();
  }

  void togglePrivacyText() {
    isPrivacyTextExpanded.value = !isPrivacyTextExpanded.value;
  }


  void rejectAll() {
    for (var cookie in cookies) {
      cookie.isEnabled = false;
    }
    cookies.refresh();
  }


  void confirmAll() {
    for (var cookie in cookies) {
      cookie.isEnabled = true;
    }
    cookies.refresh();
  }
}

import 'package:get/get.dart';

import '../models/profile_setting_model.dart';

class ProfileController extends GetxController {
  var profile = ProfileModel().obs;
  var isExpanded = false.obs;

  final experienceLevels = [
    {
      'title': 'Entry level',
      'description': 'I am relatively new to this field'
    },
    {
      'title': 'Intermediate',
      'description': 'I have substantial experience in this field'
    },
    {
      'title': 'Expert',
      'description': 'I have comprehensive and deep expertise in this field'
    }
  ];

  final defaultCategories = [
    'QA Testing',
    'Other - Software Development',
    'Web & Mobile Design',
    'Web Development',
    'Mobile Development'
  ];

  void updateVisibility(String value) {
    profile.update((val) {
      val?.visibility = value;
    });
  }

  void updateProjectPreference(String value) {
    profile.update((val) {
      val?.projectPreference = value;
    });
  }

  void updateCustomUrl(String value) {
    profile.update((val) {
      val?.customUrl = value;
    });
  }

  void toggleHideEarnings(bool value) {
    profile.update((val) {
      val?.hideEarnings = value;
    });
  }

  void updateExperienceLevel(String value) {
    profile.update((val) {
      val?.experienceLevel = value;
    });
  }

  void toggleCategory(String category) {
    var currentCategories = [...profile.value.categories];
    if (currentCategories.contains(category)) {
      currentCategories.remove(category);
    } else {
      currentCategories.add(category);
    }
    profile.update((val) {
      val?.categories = currentCategories;
    });
  }

  void toggleAIPreference() {
    profile.update((val) {
      val?.isAIDataEnabled = !val.isAIDataEnabled;
    });
  }

  void addSpecializedProfile() {
    if (profile.value.publishedProfiles < profile.value.maxProfiles) {
      profile.update((val) {
        val?.publishedProfiles++;
      });
    }
  }

  void toggleTextVisibility() {
    isExpanded.value = !isExpanded.value; // Toggle the visibility of the full text
  }
}
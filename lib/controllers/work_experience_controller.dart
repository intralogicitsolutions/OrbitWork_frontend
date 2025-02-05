import 'package:get/get.dart';
import '../models/work_experience_model.dart';

class WorkExperienceController extends GetxController {
  var title = ''.obs;
  var company = ''.obs;
  var location = ''.obs;
  var country = ''.obs;
  var isCurrentRole = false.obs;
  var startMonth = ''.obs;
  var startYear = ''.obs;
  var endMonth = ''.obs;
  var endYear = ''.obs;
  var description = ''.obs;

  void toggleCurrentRole(bool? value) {
    isCurrentRole.value = value ?? false;
  }

  bool canSave() {
    return title.value.isNotEmpty &&
        company.value.isNotEmpty &&
        startMonth.value.isNotEmpty &&
        startYear.value.isNotEmpty &&
        endYear.value.isNotEmpty &&
        endMonth.value.isNotEmpty;
  }

  void saveExperience() {
    if (canSave()) {
      final experience = WorkExperience(
        title: title.value,
        company: company.value,
        location: location.value,
        country: country.value,
        isCurrentRole: isCurrentRole.value,
        startMonth: startMonth.value,
        startYear: startYear.value,
        endMonth: endMonth.value,
        endYear: endYear.value,
        description: description.value,
      );
      Get.back(result: experience);
    }
  }
}

// Example usage in your main view:
// void showAddExperienceSheet() {
//   Get.bottomSheet(
//     const WorkExperienceSheet(),
//     isScrollControlled: true,
//     ignoreSafeArea: false,
//   );
// }

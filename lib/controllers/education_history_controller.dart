import 'package:get/get.dart';
import 'package:orbitwork/models/education_history_model.dart';

class EducationHistoryController extends GetxController {
  var school = ''.obs;
  var degree = ''.obs;
  var fieldOfStudy = ''.obs;
  var datesAttendedFrom = ''.obs;
  var datesAttendedTo = ''.obs;
  var description = ''.obs;

  bool canSave() {
    return school.value.isNotEmpty;
  }

  void saveEducation() {
    if (canSave()) {
      final education = EducationHistory(
          school: school.value,
          degree: degree.value,
          fieldOfStudy: fieldOfStudy.value,
          datesAttendedFrom: datesAttendedFrom.value,
          datesAttendedTo: datesAttendedTo.value,
          description: description.value
      );
      Get.back(result: education);
    }
  }
}
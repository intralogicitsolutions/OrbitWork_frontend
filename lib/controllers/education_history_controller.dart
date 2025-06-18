import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/models/education_history_model.dart';

import '../component/profile/education_fields_selection_bottomsheet.dart';
import '../component/select_year_bottomsheet.dart';
import '../models/freelancer_profile_model.dart';

class EducationHistoryController extends GetxController {
  var school = ''.obs;
  var degree = ''.obs;
  var fieldOfStudy = ''.obs;
  var datesAttendedFrom = ''.obs;
  var datesAttendedTo = ''.obs;
  var description = ''.obs;
  final descriptionController = TextEditingController();

  RxInt startYear = 0.obs;
  RxInt endYear = 0.obs;

  // RxString startYear = 0.toString().obs;
  // RxString endYear = 0.toString().obs;


  final educationList = <Education>[].obs;

  bool canSave() {
    return school.value.isNotEmpty;
  }
  @override
  void onInit() {
    super.onInit();
    descriptionController.text = description.value;
    descriptionController.addListener(() {
      description.value = descriptionController.text;
    });
  }

  void showStartYearPicker() {
    Get.bottomSheet(SelectYearBottomsheet(
      title: 'Select Start Year',
      selectedYear: startYear,
      onYearSelected: (value) => startYear.value = value,
    ));
  }

  void showSchoolPicker() {
    Get.bottomSheet(SimpleSelectionBottomSheet(
      title: "Select School",
      options: ['Harvard', 'Stanford', 'MIT', 'Oxford', 'Daemen College', 'Miami Dade College'],
      onSelect: (value) => school.value = value,
    ));
  }

  void showDegreePicker() {
    Get.bottomSheet(SimpleSelectionBottomSheet(
      title: "Select Degree",
      options: ['Bachelors', 'Masters', 'PhD', 'Diploma', ],
      onSelect: (value) => degree.value = value,
    ));
  }

  void showFieldOfStudyPicker() {
    Get.bottomSheet(SimpleSelectionBottomSheet(
      title: "Select Field of Study",
      options: ['Computer Science', 'Mechanical', 'Electronics', 'Business', 'Computer engineering', 'Wireless Communications'],
      onSelect: (value) => fieldOfStudy.value = value,
    ));
  }


  void showEndYearPicker() {
    Get.bottomSheet(SelectYearBottomsheet(
      title: 'Select End Year',
      selectedYear: endYear,
      onYearSelected: (value) => endYear.value = value,
    ));
  }

  void saveEducation() {
    if (canSave()) {
      final startDate = '${startYear.value}';

      final endDate = '${endYear.value}';

      final education = Education(
        institutionName: school.value,
        degree: degree.value,
        fieldOfStudy: fieldOfStudy.value,
        startYear: startDate,
        endYear: endDate,
        description: description.value,
      );
      print('Description: ${education.description}');
      educationList.add(education); // Save to list
      Get.back(result: education);
    }
  }
}
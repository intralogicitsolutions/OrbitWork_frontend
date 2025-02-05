import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/routes/app_routes.dart';

import '../component/resume_upload_bottomsheet.dart';
import '../models/category_model.dart';
import '../models/user_profile_model.dart';
import '../models/work_preference.dart';


class ProfilesController extends GetxController {
  final userProfile = UserProfile().obs;
  final currentStep = 0.obs;
  final totalSteps = 3;
  var workPreferences = <WorkPreference>[].obs;
  var selectedFile = Rx<PlatformFile?>(null);
  var isFileSelected = false.obs;
  final RxString selectedCategory = ''.obs;
  final RxList<String> selectedSpecialties = <String>[].obs;
  //final RxBool showWarning = false.obs;
  final RxBool showWarningMessage = false.obs;
  final RxString openedCategory = ''.obs;
  final RxBool attemptedMoreThanThree = false.obs;

  final categories = [
    Category(
      name: 'Accounting & Consulting',
      specialties: [
        'Personal & Professional Coaching',
        'Accounting & Bookkeeping',
        'Financial Planning',
        'Recruiting & Human Resources',
        'Management Consulting & Analysis',
        'Other - Accounting & Consulting',
      ],
    ),
    Category(name: 'Admin Support', specialties: [
      'Data Entry & Transcription Services',
      'Virtual Assistance',
      'Project Management',
      'Market Research & Product Reviews',
    ]),
    Category(name: 'Customer Service', specialties: [
      'Community Management & Tagging',
      'Customer Service & Tech Support'
    ]),
    Category(
      name: 'IT & Networking',
      specialties: [
        'Database Management & Administration',
        'ERP/CRM Software',
        'Information Security & Compliance',
        'Network & System Administration',
        'DevOps & Solution Architecture',
      ],
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize work preferences
    workPreferences.addAll([
      WorkPreference(
        title: "I'd like to find opportunities myself",
        description: "Clients post jobs on our Talent Marketplace™: you can browse and bid for them, or get invited by a client.",
        iconPath: "assets/icon/job-seeker.png",
        isCardStyle: true,
      ),
      WorkPreference(
        title: "I'd like to package up my work for clients to buy",
        description: "Define your service with prices and timelines: we'll list it in our Project Catalog™ for clients to buy right away",
        iconPath: "assets/icon/find-cv.png",
        isCardStyle: true,
      ),
      WorkPreference(
        title: "I'm open to contract-to-hire opportunities",
        description: "Start with a contract, and later explore a full-time option with the client",
        isCardStyle: false, iconPath: null, // Different layout for this option
      ),
      // Add more preferences as needed
    ]);
  }

  void togglePreference(int index) {
    workPreferences[index].isSelected = !workPreferences[index].isSelected;
    workPreferences.refresh();
  }

  void setFreelanceStatus(FreelanceExperience experience) {
    userProfile.update((val) {
      val?.experience = experience;
    });
  }

  void setFreelanceGoal(FreelanceGoal goal) {
    userProfile.update((val) {
      val?.freelanceGoal = goal;
    });
  }

  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    }else {
      // Navigate to profile_creation page when "Create Profile" is clicked
      Get.toNamed(AppRoutes.profileCreation);
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void onManualFill() {
    //Get.toNamed(AppRoutes.selectCategory);
    Get.toNamed(AppRoutes.skillSection);
    // Handle manual fill
  }

  void showResumeUploadSheet() {
    Get.bottomSheet(
      ResumeUploadSheet(),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
    );
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'rtf'],
      allowMultiple: false,
    );

    if (result != null) {
      selectedFile.value = result.files.first;
      isFileSelected.value = true;
    }
  }

  void selectCategory(String category) {
    if (selectedCategory.value == category) {
      selectedCategory.value = '';
    } else {
      if (selectedCategory.value.isNotEmpty) {
        selectedSpecialties.clear();
      }
      selectedCategory.value = category;
    }
  }

  void toggleSpecialty(String specialty) {
    if (selectedSpecialties.contains(specialty)) {
      selectedSpecialties.remove(specialty);
    } else if (selectedSpecialties.length < 3) {
      selectedSpecialties.add(specialty);
    }
  }

  bool isCategorySelected(String category) => selectedCategory.value == category;
  bool isSpecialtySelected(String specialty) => selectedSpecialties.contains(specialty);
  int get selectedSpecialtiesCount => selectedSpecialties.length;
  bool get canAddSkills => selectedCategory.isNotEmpty && selectedSpecialties.isNotEmpty;

  // // void selectCategory(String category) {
  // //   selectedCategory.value = category;
  // //   selectedSpecialties.clear();
  // // }
  //
  // void selectCategory(String category) {
  //   if (selectedCategory.value == category) {
  //     selectedCategory.value = '';
  //     selectedSpecialties.clear();
  //     showWarningMessage.value = false;
  //     attemptedMoreThanThree.value = false;
  //   } else {
  //     selectedCategory.value = category;
  //     selectedSpecialties.clear();
  //     showWarningMessage.value = false;
  //     attemptedMoreThanThree.value = false;
  //   }
  // }
  //
  // // void selectCategory(String category) {
  // //   if (selectedCategory.value.isNotEmpty && selectedCategory.value != category) {
  // //     // Show warning if the user tries to switch categories
  // //     Get.snackbar('Warning', 'You can only select 1 category at a time.');
  // //     return;
  // //   }
  // //   selectedCategory.value = category;
  // //   selectedSpecialties.clear();
  // // }
  //
  //
  // // void selectCategory(String category) {
  // //   if (selectedCategory.value.isNotEmpty && selectedCategory.value != category) {
  // //     // If the user switches categories after selecting specialties, show warning
  // //     if (selectedSpecialties.isNotEmpty) {
  // //       showWarning.value = true;
  // //       return;
  // //     }
  // //   }
  // //   selectedCategory.value = category;
  // //   selectedSpecialties.clear();
  // //  showWarning.value = false;
  // // }
  //
  //
  //
  // // void toggleSpecialty(String specialty) {
  // //   if (selectedSpecialties.contains(specialty)) {
  // //     selectedSpecialties.remove(specialty);
  // //   } else if (selectedSpecialties.length < 3) {
  // //     selectedSpecialties.add(specialty);
  // //   }
  // // }
  //
  // void toggleSpecialty(String specialty) {
  //   if (selectedSpecialties.contains(specialty)) {
  //     selectedSpecialties.remove(specialty);
  //     showWarningMessage.value = selectedSpecialties.isNotEmpty;
  //     attemptedMoreThanThree.value = false;
  //   } else if (selectedSpecialties.length < 3) {
  //     selectedSpecialties.add(specialty);
  //     showWarningMessage.value = true;
  //     attemptedMoreThanThree.value = false;
  //   } else {
  //     attemptedMoreThanThree.value = true;
  //     showWarningMessage.value = true;
  //   }
  // }
  //
  // // void toggleSpecialty(String specialty) {
  // //   if (selectedSpecialties.contains(specialty)) {
  // //     selectedSpecialties.remove(specialty);
  // //   } else if (selectedSpecialties.length < 3) {
  // //     selectedSpecialties.add(specialty);
  // //   } else {
  // //     Get.snackbar('Warning', 'You can only select up to 3 specialties.');
  // //   }
  // // }
  //
  //
  // // void toggleSpecialty(String specialty) {
  // //   if (selectedSpecialties.contains(specialty)) {
  // //     selectedSpecialties.remove(specialty);
  // //     showWarning.value = false;
  // //   } else if (selectedSpecialties.length < 3) {
  // //     selectedSpecialties.add(specialty);
  // //   } else {
  // //     showWarning.value = true;
  // //   }
  // // }
  //
  // // String get warningMessage {
  // //   if (attemptedMoreThanThree.value) {
  // //     return 'You can select maximum 3 specialties only';
  // //   }
  // //   return 'Select up to 3 specialties. You\'ll be able to change and add to these later on.';
  // // }
  //
  // bool isSpecialtySelected(String specialty) {
  //   return selectedSpecialties.contains(specialty);
  // }
  //
  // bool isCategorySelected(String category) {
  //   return selectedCategory.value == category;
  // }
  //
  // int get selectedSpecialtiesCount => selectedSpecialties.length;
  //
  // void setOpenedCategory(String category) {
  //   if (selectedCategory.value.isNotEmpty && selectedCategory.value != category) {
  //     Get.snackbar('Warning', 'You can only select specialties within one category.');
  //     return;
  //   }
  //   openedCategory.value = category;
  // }

}
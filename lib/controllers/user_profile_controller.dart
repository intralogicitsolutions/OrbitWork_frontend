import 'package:get/get.dart';
import 'package:orbitwork/routes/app_routes.dart';

import '../models/user_profile_model.dart';


class ProfilesController extends GetxController {
  final userProfile = UserProfile().obs;
  final currentStep = 0.obs;
  final totalSteps = 2;

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

  // void nextStep() {
  //   currentStep.value++;
  //   Get.toNamed(AppRoutes.freelancingSetup);
  // }
  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }
}
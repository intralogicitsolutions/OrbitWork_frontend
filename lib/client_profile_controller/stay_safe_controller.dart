import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/client_profile/stay_safe_bottomsheet.dart';

class StaySafeController extends GetxController {
  var isAgreed = false.obs;

  void toggleAgreement() {
    isAgreed.toggle();
  }

  void showStaySafeBottomSheet() {
    Get.bottomSheet(
      StaySafeBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  void submitOffer() {
    if (isAgreed.value) {
      Get.back(); // Close bottom sheet
      // Get.snackbar(
      //   'Success',
      //   'Offer submitted successfully!',
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      //   snackPosition: SnackPosition.TOP,
      // );
    } else {
      // Get.snackbar(
      //   'Agreement Required',
      //   'Please agree to Upwork\'s policies before submitting.',
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      //   snackPosition: SnackPosition.TOP,
      // );
    }
  }

  void cancelOffer() {
    Get.back();
  }
}

import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';

import '../component/client_profile/feedback_bottomsheet.dart';

class FeedbackController extends GetxController{
  var selectedFeedbackType = ''.obs;
  var feedbackText = ''.obs;

  void openFeedbackSheet(){
    Get.back();
    Get.bottomSheet(
      Container(
        height: Get.height * 0.8,
          child: FeedbackBottomsheet()),
      isScrollControlled: true,
    );
  }

  void submitFeedback() {
    Get.back();
    Get.snackbar('Thank you!', 'Your feedback has been submitted.');
  }
}
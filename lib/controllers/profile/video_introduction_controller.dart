import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoIntroductionController extends GetxController{

  final videoLinkController = TextEditingController();
  final RxBool isVideoLinkValid = false.obs;
  final RxBool showError = false.obs;

  void validateVideoLink(String value) {
    if (value.isEmpty) {
      showError.value = true;
      isVideoLinkValid.value = false;
    } else {
      showError.value = false;
      isVideoLinkValid.value = true;
    }
  }

  void onSave() {
    if (videoLinkController.text.isEmpty) {
      showError.value = true;
      return;
    }
    // Handle save logic here
    Get.back(result: videoLinkController.text);
  }

  void onCancel() {
    Get.back();
  }

  @override
  void dispose() {
    videoLinkController.dispose();
    super.dispose();
  }
}
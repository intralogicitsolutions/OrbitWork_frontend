import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecializedProfileController extends GetxController {
  final RxString selectedSpecialty = ''.obs;
  final RxInt currentStep = 0.obs;
  final totalSteps = 5;
  final RxList<String> selectedSkills = <String>[].obs;
  final RxString title = ''.obs;
  final RxString profileOverview = ''.obs;
  final RxInt maxCharacters = 5000.obs;
  int get charactersLeft => maxCharacters.value - profileOverview.value.length;


  final devices = ['Smartphone', 'Tablet'];
  final databases = ['SQLite', 'Realm Database'];
  final deliverables = ['Hybrid App Development', 'Native App Development'];
  final platforms = ['iOS', 'Android', 'Microsoft'];
  final appFeatures = ['In-App Purchases', 'User Auth'];
  final programmingLanguages = ['Swift', 'Kotlin', 'Java', 'Objective-C'];
  final appDevTools = ['Iconic Framework', 'Firebase', 'Google Analytics', 'React Native'];

  final ScrollController scrollController = ScrollController();
  final RxBool showLeftChevron = false.obs;
  final RxBool showRightChevron = true.obs;

  final double scrollAmount = 200.0;


  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_updateChevronVisibility);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _updateChevronVisibility() {
    showLeftChevron.value = scrollController.offset > 0;
    showRightChevron.value = scrollController.offset < scrollController.position.maxScrollExtent;
  }
  void scrollLeft() {
    scrollController.animateTo(
      scrollController.offset - 100,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void scrollRight() {
    scrollController.animateTo(
      scrollController.offset + 100,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void setSpecialty(String specialty) {
    selectedSpecialty.value = specialty;
  }

  void toggleSkill(String skill) {
    if (selectedSkills.contains(skill)) {
      selectedSkills.remove(skill);
    } else {
      selectedSkills.add(skill);
    }
  }

  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    }else{
      Get.back();
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }else {
      Get.back();
    }
  }

  void setTitle(String value) {
    title.value = value;
  }

  void setProfileOverview(String value) {
    if (value.length <= maxCharacters.value) {
      profileOverview.value = value;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectDetailsController extends GetxController{
  final pageController = PageController();
  var currentPage = 0.obs;

  var isRequirementsExpanded = false.obs;
  var isStepsExpanded = false.obs;
  var isGuaranteeExpanded = false.obs;

  var selectedServiceType = 'project_rates'.obs;
  var selectedTier = 'Starter'.obs;
  final ScrollController horizontalScrollController = ScrollController();

  var isSaved = false.obs;

  final List<String> images = [
    'assets/images/architecture-interior-design.jpg',
    'assets/images/ecommerce-development.jpg',
    'assets/images/articles-blog-posts.jpg',
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    horizontalScrollController.dispose();
    super.dispose();
  }

  void toggleRequirements() {
    isRequirementsExpanded.toggle();
  }

  void toggleSteps() {
    isStepsExpanded.toggle();
  }

  void toggleGuarantee() {
    isGuaranteeExpanded.toggle();
  }

  void selectServiceType(String type) {
    selectedServiceType.value = type;
  }

  void selectTier(String tier) {
    selectedTier.value = tier;
  }

  void toggleSave() {
    isSaved.value = !isSaved.value;
  }
}
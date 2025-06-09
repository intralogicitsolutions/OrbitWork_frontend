import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../client_profile_model/dashboard_model.dart';
import '../component/client_profile/post_job_bottomsheet.dart';
import '../routes/app_routes.dart';


class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  var showGuidedTour = true.obs;
  var dashboardItems = <DashboardItems>[].obs;
  var categoryItems = <CategoryItem>[].obs;
  var selectedCategoryIndex = 0.obs;
  var isLoading = false.obs;

  List<DashboardItem> dashboardItem = [
    DashboardItem(
      title: 'Verify your email',
      subtitle: 'Confirm it\'s you and establish trust with freelancers.',
      requirement: 'Required to hire',
      icon: Icons.email_outlined,
      actionType: DashboardActionType.bottomSheet,
    ),
    DashboardItem(
      title: 'Verify your phone number',
      subtitle: 'Confirm it\'s you, to be able to publish your first job post.',
      requirement: 'Required to publish a job',
      icon: Icons.phone_outlined,
      actionType: DashboardActionType.bottomSheet,
    ),
    DashboardItem(
      title: 'Add a billing method',
      subtitle: 'This can increase your hiring speed by up to 3x. There\'s no cost until you hire.',
      requirement: 'Required to hire',
      icon: Icons.payment_outlined,
      actionType: DashboardActionType.navigate,
    ),
  ];

  List<NavigationItem> navigationItems = [
    NavigationItem(title: 'View all job posts', hasUnderline: true),
    NavigationItem(title: 'View all contracts', hasUnderline: true),
  ];

  List<HelpResource> helpResources = [
    HelpResource(
      category: 'Get started',
      title: 'Get started and connect with talent to get work done',
      description: '',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void completeItem(int index) {
    final item = dashboardItem[index];
    switch (item.actionType) {
      case DashboardActionType.bottomSheet:
       // _openBottomSheet(item.title); // define this function
        break;
      case DashboardActionType.navigate:
        Get.toNamed(AppRoutes.clientBillingAndPayments);
        break;
    }
    print('Completing item: ${dashboardItem[index].title}');
  }

  void postJob() {
    print('Post a job clicked');
    Get.bottomSheet(
      PostJobBottomsheet(),
      isScrollControlled: true,
      ignoreSafeArea: false,
    );

  }

  void viewJobPosts() {
    print('View all job posts clicked');
    Get.toNamed(AppRoutes.viewAllJobPost);
  }

  void viewContracts() {
    print('View all contracts clicked');
    Get.toNamed(AppRoutes.viewAllContracts);
  }

  void browseConsultations() {
    print('Browse consultations clicked');
    Get.toNamed(AppRoutes.talentSearchScreen);
  }

  void bookConsultation() {
    print('Book a consultation clicked');
  }

  void learnMore() {
    print('Learn more clicked');
  }

  void viewAllHelp() {
    print('View all help resources clicked');
  }

  void loadDashboardData() {
    isLoading.value = true;

    // Simulate loading delay
    Future.delayed(Duration(milliseconds: 500), () {
      dashboardItems.value = DashboardData.getDashboardItems();
      categoryItems.value = DashboardData.getCategoryItems();
      isLoading.value = false;
    });
  }

  void onLearnMoreTap() {
    Get.snackbar(
      "Learn More",
      "Navigating to learning resources...",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  void onAddTap() {
    Get.snackbar(
      "Add",
      "Add new item functionality",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  void onMenuTap() {
    Get.snackbar(
      "Menu",
      "Opening menu options",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  void onCategoryTap(String category) {
    Get.snackbar(
      category,
      "Opening $category category...",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  void onCategorySelect(int index) {
    selectedCategoryIndex.value = index;
  }

  void closeGuidedTour() {
    showGuidedTour.value = false;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../client_profile_model/consultation_project_model.dart';

class ConsultationController extends GetxController{

  var isSaved = false.obs;
  var isPeopleSaved = false.obs;

  RxList<String> personalizedAdvice = <String>[
    "Content marketing", "Ecommerce Marketing", "Marketing Strategy", "Search Marketing", "Social Media Marketing",
    "google ad manager", "seo backLinking", "seo content", "on-page seo", "digital advertising"
  ].obs;

  var ratings = <int>[153, 2, 1, 0, 0].obs;
  int get totalVotes => ratings.fold(0, (sum, val) => sum + val);

  var selectedOption = 'now'.obs;
  RxString selectedDuration = '30'.obs;

  var selectedTab = 0.obs;
  var showAllProjects = false.obs;
  var showThisProject = false.obs;
  var currentPage = 0.obs;

  var selectedShareDuration = '30 minutes'.obs;

  // Sample data
  final List<ConsultationItem> allProjects = [
    ConsultationItem(
      name: "Min Kyung K.",
      initials: "MK",
      rating: 5.0,
      date: "Apr 18, 2025",
      duration: "30 minute consultation",
      description: "Eldar was helpful in answering my questions about framework considerations, particularly rewrite from Flutterflow to Flutter framework, estimates, pros and cons of native (ie React native) vs Flutter.",
      color: Colors.green,
    ),
    ConsultationItem(
      name: "Clifford W.",
      initials: "CW",
      rating: 5.0,
      date: "Apr 11, 2025",
      duration: "30 minute consultation",
      description: "Great consultation with this team. Very professional and informative!",
      color: Colors.green,
    ),
    ConsultationItem(
      name: "Ayman A.",
      initials: "AA",
      rating: 5.0,
      date: "Mar 9, 2025",
      duration: "Exeeria Flutter App Audition from QA perspective",
      description: "",
      color: Colors.red,
    ),
    ConsultationItem(
      name: "Joe H.",
      initials: "JH",
      rating: 5.0,
      date: "Mar 5, 2025",
      duration: "Time and Attendance system and app",
      description: "",
      color: Colors.teal,
    ),
    ConsultationItem(
      name: "Sarah M.",
      initials: "SM",
      rating: 4.8,
      date: "Feb 28, 2025",
      duration: "45 minute consultation",
      description: "Excellent guidance on mobile app architecture and best practices.",
      color: Colors.blue,
    ),
    ConsultationItem(
      name: "David L.",
      initials: "DL",
      rating: 5.0,
      date: "Feb 25, 2025",
      duration: "React Native vs Flutter comparison",
      description: "Very detailed comparison and helped make the right decision for our project.",
      color: Colors.purple,
    ),
    ConsultationItem(
      name: "Emma T.",
      initials: "ET",
      rating: 4.9,
      date: "Feb 20, 2025",
      duration: "UI/UX consultation",
      description: "Great insights on modern UI design patterns and user experience.",
      color: Colors.orange,
    ),
    ConsultationItem(
      name: "Michael R.",
      initials: "MR",
      rating: 5.0,
      date: "Feb 15, 2025",
      duration: "Backend integration consultation",
      description: "Helped resolve complex API integration issues efficiently.",
      color: Colors.indigo,
    ),
  ];

  final List<ConsultationItem> thisProject = [
    ConsultationItem(
      name: "John D.",
      initials: "JD",
      rating: 5.0,
      date: "Apr 20, 2025",
      duration: "Project setup consultation",
      description: "Helped with initial project setup and architecture decisions.",
      color: Colors.blue,
    ),
    ConsultationItem(
      name: "Lisa P.",
      initials: "LP",
      rating: 4.8,
      date: "Apr 15, 2025",
      duration: "Code review session",
      description: "Thorough code review with actionable feedback and improvements.",
      color: Colors.pink,
    ),
    ConsultationItem(
      name: "Robert K.",
      initials: "RK",
      rating: 5.0,
      date: "Apr 10, 2025",
      duration: "Performance optimization",
      description: "Excellent advice on app performance and optimization techniques.",
      color: Colors.cyan,
    ),
    ConsultationItem(
      name: "Anna S.",
      initials: "AS",
      rating: 4.9,
      date: "Apr 5, 2025",
      duration: "Testing strategy consultation",
      description: "Comprehensive testing strategy and implementation guidance.",
      color: Colors.amber,
    ),
    ConsultationItem(
      name: "Tom W.",
      initials: "TW",
      rating: 5.0,
      date: "Mar 30, 2025",
      duration: "Deployment consultation",
      description: "Smooth deployment process with detailed step-by-step guidance.",
      color: Colors.lightGreen,
    ),
    ConsultationItem(
      name: "Maria G.",
      initials: "MG",
      rating: 4.7,
      date: "Mar 25, 2025",
      duration: "State management consultation",
      description: "Clear explanation of different state management approaches.",
      color: Colors.deepOrange,
    ),
  ];

  final List<ServiceProvider> serviceProviders = [
    ServiceProvider(
      name: "Steve S.",
      rating: 4.9,
      reviews: 1243,
      title: "Development & IT Consultation",
      price: "From \$25",
      imageUrl: "assets/images/architecture-interior-design.jpg",
      profileImage: "",
      isTopRatedPlus: true,
      badge: "Top Rated Plus",
      isInitiallySaved: false,
    ),
    ServiceProvider(
      name: "Mariusz O.",
      rating: 4.9,
      reviews: 1731,
      title: "Development & IT Consultation",
      price: "From \$30",
      imageUrl: "assets/images/articles-blog-posts.jpg",
      profileImage: "",
      isTopRatedPlus: true,
      badge: "Top Rated Plus",
      isInitiallySaved: false,
    ),
    ServiceProvider(
      name: "Nasir J.",
      rating: 4.9,
      reviews: 296,
      title: "Development & IT Consultation",
      price: "From \$40",
      imageUrl: "assets/images/data-entry.jpg",
      profileImage: "",
      isTopRatedPlus: false,
      badge: "Top Rated",
      isInitiallySaved: false,
    ),
  ].obs;

  void toggleSave() {
    isSaved.value = !isSaved.value;
  }

  void togglePeopleSave(){
    isPeopleSaved.value = !isPeopleSaved.value;
  }

  void changeTab(int index) {
    selectedTab.value = index;
    showAllProjects.value = false;
    showThisProject.value = false;
  }

  void toggleShowMore(int tabIndex) {
    if (tabIndex == 0) {
      showAllProjects.value = !showAllProjects.value;
    } else {
      showThisProject.value = !showThisProject.value;
    }
  }

  List<ConsultationItem> getCurrentItems() {
    return selectedTab.value == 0 ? allProjects : thisProject;
  }

  List<ConsultationItem> getDisplayedItems() {
    final items = getCurrentItems();
    final showAll = selectedTab.value == 0 ? showAllProjects.value : showThisProject.value;

    if (showAll || items.length <= 5) {
      return items;
    }
    return items.take(5).toList();
  }

  bool shouldShowMoreButton() {
    final items = getCurrentItems();
    final showAll = selectedTab.value == 0 ? showAllProjects.value : showThisProject.value;
    return items.length > 5 && !showAll;
  }

  String getTabTitle(int index) {
    if (index == 0) {
      return "All projects (${allProjects.length})";
    } else {
      return "This project (${thisProject.length})";
    }
  }

  void updateDuration(String newDuration) {
    selectedShareDuration.value = newDuration;
    Get.back();
  }
}
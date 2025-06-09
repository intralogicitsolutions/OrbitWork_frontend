import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../client_profile_model/talent_model.dart';
import '../component/client_profile/create_list_bottomsheet.dart';
import '../component/client_profile/select_like_bottomsheet.dart';

class TalentController extends GetxController {
  var recentlyViewed = <TalentModel>[].obs;
  var talentToCheckOut = <TalentModel>[].obs;
  var isLoading = false.obs;

  var talentFromArea = <TalentModel>[].obs;
  var projectsYouMayLike = <ProjectModel>[].obs;
  var favoriteProjects = <String>[].obs;

  var selectedListName = 'Discover'.obs;
  var customLists = <String>[].obs;

  var errorText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadTalentData();
    loadData();
  }

  void loadTalentData() {
    isLoading.value = true;

    // Simulate API call delay
    Future.delayed(Duration(milliseconds: 500), () {
      recentlyViewed.value = [
        TalentModel(
          id: '1',
          name: 'Amandeep K.',
          location: 'Kajabi',
          specialization: 'Kajabi Website Designer',
          profileImage: 'https://via.placeholder.com/60x60/4CAF50/FFFFFF?text=AK',
          hourlyRate: 25.00,
          jobSuccessRate: 97,
          isTopRated: true,
          isOnline: true,
        ),
        TalentModel(
          id: '2',
          name: 'Sarah M.',
          location: 'Mumbai',
          specialization: 'UI/UX Designer',
          profileImage: 'https://via.placeholder.com/60x60/2196F3/FFFFFF?text=SM',
          hourlyRate: 30.00,
          jobSuccessRate: 95,
          isTopRated: true,
          isOnline: true,
        ),
        TalentModel(
          id: '3',
          name: 'David L.',
          location: 'Delhi',
          specialization: 'Flutter Developer',
          profileImage: 'https://via.placeholder.com/60x60/FF9800/FFFFFF?text=DL',
          hourlyRate: 35.00,
          jobSuccessRate: 92,
          isTopRated: false,
          isOnline: false,
        ),
      ];

      projectsYouMayLike.value = [
        ProjectModel(
          id: '1',
          title: 'Logo, Logo Design, Brand Identity',
          description: 'I will create professional logo design for your business',
          //projectImage: 'https://via.placeholder.com/200x120/FF6B35/FFFFFF?text=TIKI+LOGO',
          startingPrice: 25.00,
          freelancerName: 'Kiran N.',
          //freelancerImage: 'https://via.placeholder.com/40x40/E74C3C/FFFFFF?text=KN',
          rating: 4.8,
          reviewCount: 642,
          isTopRated: true,
        ),
        ProjectModel(
          id: '2',
          title: 'Modern Website Design & Development',
          description: 'I will create responsive website with modern design',
          //projectImage: 'https://via.placeholder.com/200x120/2C3E50/FFFFFF?text=WEBSITE',
          startingPrice: 50.00,
          freelancerName: 'Amit R.',
          //freelancerImage: 'https://via.placeholder.com/40x40/3498DB/FFFFFF?text=AR',
          rating: 4.9,
          reviewCount: 328,
          isTopRated: true,
        ),
        ProjectModel(
          id: '3',
          title: 'Mobile App UI/UX Design',
          description: 'I will design beautiful mobile app interface',
          //projectImage: 'https://via.placeholder.com/200x120/8E44AD/FFFFFF?text=APP+UI',
          startingPrice: 35.00,
          freelancerName: 'Sneha K.',
          //freelancerImage: 'https://via.placeholder.com/40x40/9B59B6/FFFFFF?text=SK',
          rating: 4.7,
          reviewCount: 156,
          isTopRated: false,
        ),
        ProjectModel(
          id: '4',
          title: 'Social Media Marketing Package',
          description: 'I will manage your social media accounts professionally',
          //projectImage: 'https://via.placeholder.com/200x120/E67E22/FFFFFF?text=SOCIAL',
          startingPrice: 40.00,
          freelancerName: 'Rohit P.',
          //freelancerImage: 'https://via.placeholder.com/40x40/F39C12/FFFFFF?text=RP',
          rating: 4.6,
          reviewCount: 89,
          isTopRated: true,
        ),
      ];


      talentToCheckOut.value = [
        TalentModel(
          id: '4',
          name: 'Talha K.',
          location: 'Karachi',
          specialization: 'Logo Animation | Explainer Videos',
          profileImage: 'https://via.placeholder.com/60x60/FFC107/FFFFFF?text=TK',
          hourlyRate: 10.00,
          jobSuccessRate: 94,
          isTopRated: true,
          isOnline: true,
        ),
        TalentModel(
          id: '5',
          name: 'Priya S.',
          location: 'Bangalore',
          specialization: 'Content Writer | SEO Expert',
          profileImage: 'https://via.placeholder.com/60x60/E91E63/FFFFFF?text=PS',
          hourlyRate: 15.00,
          jobSuccessRate: 98,
          isTopRated: true,
          isOnline: true,
        ),
        TalentModel(
          id: '6',
          name: 'Alex R.',
          location: 'Chennai',
          specialization: 'React Native Developer',
          profileImage: 'https://via.placeholder.com/60x60/9C27B0/FFFFFF?text=AR',
          hourlyRate: 28.00,
          jobSuccessRate: 89,
          isTopRated: false,
          isOnline: false,
        ),
      ];

      isLoading.value = false;
    });
  }

  void loadData() {
    isLoading.value = true;

    // Simulate API call delay
    Future.delayed(Duration(milliseconds: 500), () {
      talentFromArea.value = [
        TalentModel(
          id: '1',
          name: 'Manisha P.',
          location: 'Mumbai',
          specialization: 'Contract Specialist | Legal Research',
          profileImage: 'https://via.placeholder.com/60x60/8E44AD/FFFFFF?text=MP',
          hourlyRate: 10.00,
          jobSuccessRate: 96,
          isTopRated: false,
          isOnline: false,
        ),
        TalentModel(
          id: '2',
          name: 'Rajesh K.',
          location: 'Delhi',
          specialization: 'Mobile App Developer | Flutter',
          profileImage: 'https://via.placeholder.com/60x60/3498DB/FFFFFF?text=RK',
          hourlyRate: 18.00,
          jobSuccessRate: 94,
          isTopRated: true,
          isOnline: true,
        ),
        TalentModel(
          id: '3',
          name: 'Priya S.',
          location: 'Bangalore',
          specialization: 'UI/UX Designer | Web Design',
          profileImage: 'https://via.placeholder.com/60x60/E74C3C/FFFFFF?text=PS',
          hourlyRate: 22.00,
          jobSuccessRate: 98,
          isTopRated: true,
          isOnline: true,
        ),
        TalentModel(
          id: '4',
          name: 'Arjun M.',
          location: 'Chennai',
          specialization: 'Digital Marketing | SEO Expert',
          profileImage: 'https://via.placeholder.com/60x60/2ECC71/FFFFFF?text=AM',
          hourlyRate: 15.00,
          jobSuccessRate: 92,
          isTopRated: false,
          isOnline: false,
        ),
      ];

      projectsYouMayLike.value = [
        ProjectModel(
          id: '1',
          title: 'Logo, Logo Design, Brand Identity',
          description: 'I will create professional logo design for your business',
          //projectImage: 'https://via.placeholder.com/200x120/FF6B35/FFFFFF?text=TIKI+LOGO',
          startingPrice: 25.00,
          freelancerName: 'Kiran N.',
         // freelancerImage: 'https://via.placeholder.com/40x40/E74C3C/FFFFFF?text=KN',
          rating: 4.8,
          reviewCount: 642,
          isTopRated: true,
        ),
        ProjectModel(
          id: '2',
          title: 'Modern Website Design & Development',
          description: 'I will create responsive website with modern design',
          //projectImage: 'https://via.placeholder.com/200x120/2C3E50/FFFFFF?text=WEBSITE',
          startingPrice: 50.00,
          freelancerName: 'Amit R.',
          //freelancerImage: 'https://via.placeholder.com/40x40/3498DB/FFFFFF?text=AR',
          rating: 4.9,
          reviewCount: 328,
          isTopRated: true,
        ),
        ProjectModel(
          id: '3',
          title: 'Mobile App UI/UX Design',
          description: 'I will design beautiful mobile app interface',
         // projectImage: 'https://via.placeholder.com/200x120/8E44AD/FFFFFF?text=APP+UI',
          startingPrice: 35.00,
          freelancerName: 'Sneha K.',
          //freelancerImage: 'https://via.placeholder.com/40x40/9B59B6/FFFFFF?text=SK',
          rating: 4.7,
          reviewCount: 156,
          isTopRated: false,
        ),
        ProjectModel(
          id: '4',
          title: 'Social Media Marketing Package',
          description: 'I will manage your social media accounts professionally',
          //projectImage: 'https://via.placeholder.com/200x120/E67E22/FFFFFF?text=SOCIAL',
          startingPrice: 40.00,
          freelancerName: 'Rohit P.',
         // freelancerImage: 'https://via.placeholder.com/40x40/F39C12/FFFFFF?text=RP',
          rating: 4.6,
          reviewCount: 89,
          isTopRated: true,
        ),
      ];

      isLoading.value = false;
    });
  }

  void addToFavorites(String talentId) {
    // Handle favorite functionality
    Get.bottomSheet(SelectLikeBottomsheet());
  }

  void viewTalentProfile(TalentModel talent) {
    // Handle navigation to talent profile
    Get.snackbar(
      'Profile View',
      'Opening ${talent.name}\'s profile',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  void toggleFavorite(String projectId) {
    if (favoriteProjects.contains(projectId)) {
      favoriteProjects.remove(projectId);
    } else {
      favoriteProjects.add(projectId);
    }
  }

  void viewProject(ProjectModel project) {
    Get.snackbar(
      'Project View',
      'Opening ${project.title}',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.orange.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  void addNewList(String name) {
    customLists.add(name);
    selectedListName.value = name;
    errorText.value = '';
    update();
  }

  void validateAndCreate(String name) {
    if (name.trim().isEmpty) {
      errorText.value = 'Title should not be empty';
    } else {
      addNewList(name.trim());
      Get.back(); // Close bottomsheet
    }
  }
}
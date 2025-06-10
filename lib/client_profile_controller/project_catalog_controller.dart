import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../client_profile_model/project_model.dart';

class ProjectCatalogController extends GetxController {
  var searchText = ''.obs;
  var savedCount = 0.obs;
  var projects = <Project>[].obs;
  var favoriteProjects = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProjects();
  }

  void loadProjects() {
    // Sample data matching the UI
    projects.value = [
      Project(
        id: '1',
        title: 'Responsive & Professional Websites, Effective...',
        description: 'High-quality responsive websites',
        price: 'From \$99',
        providerName: 'Haroon A.',
        rating: 5.0,
        reviewCount: 2167,
        profileImage: 'assets/haroon_profile.jpg',
        projectImages: [
          'assets/images/Teams_room.jpg',
          'assets/images/Teams_room.jpg',
          'assets/images/Teams_room.jpg',
        ],
        isTopRatedPlus: true,
      ),
      Project(
        id: '2',
        title: 'A great PowerPoint template to feature your message wit...',
        description: 'Professional PowerPoint templates',
        price: 'From \$99',
        providerName: 'Ignacio G.',
        rating: 4.8,
        reviewCount: 7989,
        profileImage: 'assets/ignacio_profile.jpg',
        projectImages: [
          'assets/images/voice-over.jpg',
        ],
        isTopRatedPlus: true,
      ),
      Project(
        id: '3',
        title: 'Logo, Logo Design, Logo Designer',
        description: 'Professional logo design services',
        price: 'From \$95',
        providerName: 'Blu Jay',
        rating: 4.9,
        reviewCount: 1543,
        profileImage: 'assets/blujay_profile.jpg',
        projectImages: [
          'assets/images/video-editing.jpg',
        ],
        isTopRatedPlus: false,
      ),
    ];
  }

  void toggleFavorite(String projectId) {
    if (favoriteProjects.contains(projectId)) {
      favoriteProjects.remove(projectId);
      savedCount.value--;
    } else {
      favoriteProjects.add(projectId);
      savedCount.value++;
    }
  }

  void onSearchChanged(String value) {
    searchText.value = value;
  }

  void showFilterBottomSheet() {
    Get.bottomSheet(
      Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            'Filter Options',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  void showSavedProjects() {
    Get.snackbar(
      'Saved Projects',
      'You have ${savedCount.value} saved projects',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../client_profile_model/catalog_model.dart';

class CatalogController extends GetxController {
  var searchText = ''.obs;
  var isSearching = false.obs;
  var showMoreCategories = false.obs;

  final List<CategoryModel> popularCategories = [
    CategoryModel(
      title: 'Logo Design',
      image: 'assets/images/logo-design.jpg',
      textColor: const Color(0xFF4CAF50),
    ),
    CategoryModel(
      title: 'WordPress',
      image: 'assets/images/wordpress.jpg',
      textColor: const Color(0xFF4CAF50),
    ),
    CategoryModel(
      title: 'Articles & Blog Posts',
      image: 'assets/images/articles-blog-posts.jpg',
      textColor: const Color(0xFF4CAF50),
    ),
    CategoryModel(
      title: 'Video Editing',
      image: 'assets/images/video-editing.jpg',
      textColor: const Color(0xFF4CAF50),
    ),
  ];

  final List<CategoryModel> moreCategories = [
    CategoryModel(
      title: 'Illustration',
      image: 'assets/images/illustration.jpg',
      textColor: const Color(0xFF4CAF50),
    ),
    CategoryModel(
      title: 'SEO',
      image: 'assets/images/seo.jpg',
      textColor: const Color(0xFF4CAF50),
    ),
    CategoryModel(
      title: 'Ecommerce Development',
      image: 'assets/images/ecommerce-development.jpg',
      textColor: const Color(0xFF4CAF50),
    ),
    CategoryModel(
      title: 'Data Entry',
      image: 'assets/images/data-entry.jpg',
      textColor: const Color(0xFF4CAF50),
    ),
    CategoryModel(
      title: 'Architecture & Interior Design',
      image: 'assets/images/architecture-interior-design.jpg',
      textColor: const Color(0xFF4CAF50),
    ),
    CategoryModel(
      title: 'Voiceover Recordings',
      image: 'assets/images/voice-over.jpg',
      textColor: const Color(0xFF4CAF50),
    ),
  ];

  void updateSearchText(String value) {
    searchText.value = value;
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
  }

  void toggleShowMore() {
    showMoreCategories.value = !showMoreCategories.value;
  }

  void onCategoryTap(String category) {
    print('${category} select');
  }

  List<CategoryModel> get displayedCategories {
    List<CategoryModel> categories = List.from(popularCategories);
    if (showMoreCategories.value) {
      categories.addAll(moreCategories);
    }
    return categories;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../client_profile_model/category_model.dart';

class BrowseCategoryController extends GetxController {
  var categories = <CategoryModel>[].obs;
  var isLoading = false.obs;
  var expandedCategoryId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  void loadCategories() {
    isLoading.value = true;

    // Simulate API call delay
    Future.delayed(Duration(milliseconds: 300), () {
      categories.value = [
        CategoryModel(
          id: 'accounting',
          title: 'Accounting & Consulting',
          subcategories: [
            'Accounting',
            'Bookkeeping',
            'Business Analysis & Strategy',
            'Career Coaching',
            'Financial Analysis & Modeling',
            'Financial Management/CFO',
            'HR Administration',
            'Instructional Design',
            'Management Consulting',
            'Personal Coaching',
            'Recruiting & Talent Sourcing',
            'Tax Preparation',
            'Training & Development',
          ],
        ),
        CategoryModel(
          id: 'admin',
          title: 'Admin Support',
          subcategories: [
            'Data Entry',
            'Virtual Assistant',
            'Email Management',
            'Customer Support',
            'Project Management',
            'Research & Analysis',
            'Document Preparation',
            'Calendar Management',
            'Travel Planning',
            'Order Processing',
          ],
        ),
        CategoryModel(
          id: 'ai',
          title: 'AI Services',
          subcategories: [
            'Machine Learning',
            'Natural Language Processing',
            'Computer Vision',
            'AI Chatbots',
            'Data Science',
            'Deep Learning',
            'AI Model Training',
            'Predictive Analytics',
            'AI Integration',
            'Neural Networks',
          ],
        ),
        CategoryModel(
          id: 'customer',
          title: 'Customer Service',
          subcategories: [
            'Customer Support',
            'Live Chat Support',
            'Phone Support',
            'Email Support',
            'Technical Support',
            'Social Media Support',
            'Help Desk',
            'Customer Success',
            'Quality Assurance',
            'Training & Documentation',
          ],
        ),
        CategoryModel(
          id: 'design',
          title: 'Design & Creative',
          subcategories: [
            'Graphic Design',
            'Logo Design',
            'Web Design',
            'UI/UX Design',
            'Brand Identity',
            'Print Design',
            'Illustration',
            'Animation',
            'Video Editing',
            'Photography',
          ],
        ),
        CategoryModel(
          id: 'development',
          title: 'Development & IT',
          subcategories: [
            'Web Development',
            'Mobile App Development',
            'Software Development',
            'Database Administration',
            'DevOps & Cloud',
            'Quality Assurance',
            'Cybersecurity',
            'Blockchain',
            'Game Development',
            'API Development',
          ],
        ),
        CategoryModel(
          id: 'marketing',
          title: 'Marketing & Sales',
          subcategories: [
            'Digital Marketing',
            'Social Media Marketing',
            'Content Marketing',
            'SEO',
            'PPC Advertising',
            'Email Marketing',
            'Lead Generation',
            'Market Research',
            'Sales Strategy',
            'Brand Management',
          ],
        ),
      ];

      isLoading.value = false;
    });
  }

  void toggleCategory(String categoryId) {
    if (expandedCategoryId.value == categoryId) {
      // If clicking on already expanded category, collapse it
      expandedCategoryId.value = '';
    } else {
      // Expand the clicked category and collapse others
      expandedCategoryId.value = categoryId;
    }
  }

  void selectSubcategory(String categoryTitle, String subcategory) {
    Get.snackbar(
      'Category Selected',
      '$subcategory in $categoryTitle',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
    );
  }
}
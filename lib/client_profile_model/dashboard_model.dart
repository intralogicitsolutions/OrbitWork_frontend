import 'package:flutter/material.dart';

class DashboardItem {
  final String title;
  final String subtitle;
  final String requirement;
  final IconData icon;

  DashboardItem({
    required this.title,
    required this.subtitle,
    required this.requirement,
    required this.icon,
  });
}

class NavigationItem {
  final String title;
  final bool hasUnderline;

  NavigationItem({
    required this.title,
    this.hasUnderline = false,
  });
}

class HelpResource {
  final String category;
  final String title;
  final String description;

  HelpResource({
    required this.category,
    required this.title,
    required this.description,
  });
}

class CategoryItem {
  final String title;
  final String imagePath;

  CategoryItem({
    required this.title,
    required this.imagePath,
  });
}

class DashboardItems {
  final String title;
  final String subtitle;
  final String category;
  final String iconPath;
  final String? buttonText;

  DashboardItems({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.iconPath,
    this.buttonText,
  });
}

class DashboardData {

  static List<CategoryItem> getCategoryItems() {
    return [
      CategoryItem(title: "Development & IT", imagePath: "assets/icon/development-it.svg"),
      CategoryItem(title: "AI Services", imagePath: "assets/icon/ai-services.svg"),
      CategoryItem(title: "Marketing", imagePath: "assets/icon/marketing.svg"),
      CategoryItem(title: "Design", imagePath: "assets/icon/design.svg"),
      CategoryItem(title: "Writing & Translation", imagePath: "assets/icon/writing-transaction.svg"),
      CategoryItem(title: "Administration", imagePath: "assets/icon/administration.svg"),
    ];
  }

  static List<DashboardItems> getDashboardItems() {
    return [
      DashboardItems(
        title: "Get started and connect with talent to get work done",
        subtitle: "Get started",
        category: "Get started",
        iconPath: "assets/icon/payment1.svg",
        buttonText: "Learn more",
      ),
      DashboardItems(
        title: "Everything you need to know about payments",
        subtitle: "Payments",
        category: "Payments",
        iconPath: "assets/icon/payment1.svg",
      ),
      DashboardItems(
        title: "How to set up your preferred billing method",
        subtitle: "Payments",
        category: "Payments",
        iconPath: "assets/icon/payment2.svg",
      ),
      DashboardItems(
          title: "Keep yourself and others safe on Orbitwork ",
          subtitle: "Trust & safety",
          category: "Payments",
          iconPath: "assets/icon/payment3.svg",
      )
    ];
  }
}
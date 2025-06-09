import 'package:get/get.dart';

import '../client_profile_model/portfolio_item_model.dart';

class PortfolioController extends GetxController {
  RxInt currentPage = 0.obs;
  final int itemsPerPage = 4;

  List<PortfolioItem> allItems = [
    // Add your real data here
    PortfolioItem(
        title: "MadKicks - UX & UI design",
        imageUrl: "assets/images/Teams_room.jpg",
        tags: ["Ecommerce", "+4"]),
    PortfolioItem(
        title: "TheCreditPros - UX & UI design",
        imageUrl: "assets/images/video-editing.jpg",
        tags: ["Web Design", "Figma", "+3"]),
    PortfolioItem(
        title: "Hausii - UX & UI",
        imageUrl: "assets/images/wordpress.jpg",
        tags: ["Web", "Marketplace"]),
    PortfolioItem(
        title: "NSBE - UX & UI",
        imageUrl: "assets/images/voice-over.jpg",
        tags: ["Design", "Community"]),
    // Add more as needed
  ];

  int get totalPages => (allItems.length / itemsPerPage).ceil();

  List<PortfolioItem> get paginatedItems {
    final start = currentPage.value * itemsPerPage;
    final end = (start + itemsPerPage).clamp(0, allItems.length);
    return allItems.sublist(start, end);
  }

  void nextPage() {
    if (currentPage.value < totalPages - 1) currentPage++;
  }

  void prevPage() {
    if (currentPage.value > 0) currentPage--;
  }
}

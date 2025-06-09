import 'package:get/get.dart';

import '../client_profile_model/work_item_model.dart';


class WorkHistoryController extends GetxController {
  final RxInt currentPage = 0.obs;
  final int itemsPerPage = 5;

  final List<WorkItem> allItems = List.generate(28, (index) => WorkItem(
    title: 'Job Title #$index',
    rating: 5.0,
    price: '\$170.00',
    dateRange: 'Apr 29, 2025 - May 12, 2025',
    tags: ['Website Asset', 'Mobile App Design'],
    description: 'Task: Redesign mobile checkout flow...',
  ));

  List<WorkItem> get paginatedItems {
    int start = currentPage.value * itemsPerPage;
    int end = start + itemsPerPage;
    return allItems.sublist(start, end > allItems.length ? allItems.length : end);
  }

  int get totalPages => (allItems.length / itemsPerPage).ceil();

  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      currentPage.value++;
    }
  }

  void prevPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }
}

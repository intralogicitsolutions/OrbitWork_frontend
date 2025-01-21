import 'package:get/get.dart';

class TransactionCategoryController extends GetxController {
  RxList<String> categories = [
    'All transactions',
    'All debits',
    'All credits',
    'Hourly',
    'Fixed price',
    'Bonus',
  ].obs;

  RxList<String> selectedCategories = <String>[].obs;
  RxBool isAllSelected = false.obs;
  RxString selectedCategoryLabel = 'All transaction'.obs;

  // Function to toggle individual selection
  void toggleCategorySelection(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }

    // Update 'All transactions' selection status
    isAllSelected.value = selectedCategories.length == categories.length;
  }

  // Function to select/deselect all categories
  void toggleSelectAll() {
    if (isAllSelected.value) {
      selectedCategories.clear();
    } else {
      selectedCategories.addAll(categories);
    }

    isAllSelected.value = !isAllSelected.value;
  }

  // Function to filter categories based on search query
  List<String> getFilteredCategories(String query) {
    return categories.where((category) {
      return category.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Function to update the selected label
  void updateSelectedLabel() {
    if (selectedCategories.isEmpty) {
      selectedCategoryLabel.value = 'All transaction';
    } else {
      selectedCategoryLabel.value = selectedCategories.join(', ');
    }
  }
}

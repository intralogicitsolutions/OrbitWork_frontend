import 'package:get/get.dart';
class TransactionCategoryController extends GetxController {

  RxList<String> categories = RxList<String>([
    'All transactions',
    'All debits',
    'All credits',
    'Hourly',
    'Fixed price',
    'Bonus',
    'Adjustments',
    'Withdrawals',
    'Expense'
  ]);

  RxList<bool> selectedCategories = RxList<bool>();

  RxString searchQuery = ''.obs;

  RxBool selectAll = false.obs;

  void _updateSelectedCategories() {
    if (selectedCategories.length != categories.length) {
      selectedCategories.assignAll(List.filled(categories.length, false));
    }
  }

  void toggleCategorySelection(int index) {
    if (index == 0) {
      selectAll.value = !selectAll.value;
      for (int i = 1; i < selectedCategories.length; i++) {
        selectedCategories[i] = selectAll.value;
      }
    } else {
      selectedCategories[index] = !selectedCategories[index];
      selectAll.value = selectedCategories.skip(1).every((element) => element);
    }

    selectedCategories[0] = selectAll.value;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<String> get filteredCategories {
    if (searchQuery.value.isEmpty) {
      return categories;
    } else {
      return categories.where((category) => category.toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    _updateSelectedCategories();
    categories.listen((_) => _updateSelectedCategories());
  }
}


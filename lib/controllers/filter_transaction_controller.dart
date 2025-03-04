import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  final dateRange = "All time".obs;
  final transactionType = "All types".obs;
  final client = "All clients".obs;
  final contract = "All contracts".obs;

  final TextEditingController searchController = TextEditingController();
  final RxList<String> allItems = <String>[].obs;
  final RxList<String> filteredItems = <String>[].obs;
  final RxSet<String> selectedItems = <String>{}.obs;

  void clearFilters() {
    dateRange.value = "All time";
    transactionType.value = "All types";
    client.value = "All clients";
    contract.value = "All contracts";
  }

  void initializeItems(String type) {
    switch (type) {
      case 'transactionType':
        allItems.assignAll(["All types", "Purchase", "Sale", "Transfer"]);
        break;
      case 'client':
        allItems.assignAll(["All clients", "Client A", "Client B", "Client C"]);
        break;
      case 'contract':
        allItems.assignAll(["All contracts", "Contract 1", "Contract 2", "Contract 3"]);
        break;
    }
    filteredItems.assignAll(allItems);
  }

  void filterItems(String query) {
    if (query.isEmpty) {
      filteredItems.assignAll(allItems);
    } else {
      filteredItems.assignAll(
        allItems.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList(),
      );
    }
  }

  void toggleSelection(String item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
  }

  void resetSelections() {
    selectedItems.clear();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
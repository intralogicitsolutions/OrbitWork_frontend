import 'package:get/get.dart';

class FilterController extends GetxController {
  final dateRange = "All time".obs;
  final transactionType = "All types".obs;
  final client = "All clients".obs;
  final contract = "All contracts".obs;

  void clearFilters() {
    dateRange.value = "All time";
    transactionType.value = "All types";
    client.value = "All clients";
    contract.value = "All contracts";
  }
}
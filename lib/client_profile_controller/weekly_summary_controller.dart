import 'package:get/get.dart';

class WeeklySummaryController extends GetxController {
  var selectedTab = 0.obs;
  var selectedWeek = 'May 26 - Jun 1, 2025'.obs;
  var hourlyTime = 0.0.obs;
  var manualTime = 0.0.obs;
  var fixedPrice = 0.0.obs;
  var totalAmount = 0.0.obs;

  var topContractsExpanded = false.obs;
  var topActivitiesExpanded = false.obs;

  void selectTab(int index) {
    selectedTab.value = index;
  }

  void toggleTopContracts() {
    topContractsExpanded.value = !topContractsExpanded.value;
  }

  void toggleTopActivities() {
    topActivitiesExpanded.value = !topActivitiesExpanded.value;
  }

  void changeWeek(bool isNext) {
    // Logic to change week - you can implement date manipulation here
    // For demo purposes, just updating the string
    if (isNext) {
      selectedWeek.value = 'Jun 2 - Jun 8, 2025';
    } else {
      selectedWeek.value = 'May 19 - May 25, 2025';
    }
  }
}
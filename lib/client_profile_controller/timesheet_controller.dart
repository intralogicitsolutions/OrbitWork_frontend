import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/client_profile/display_setting_bottomsheet.dart';
import '../component/select_date_bottom_sheet.dart';

class TimesheetController extends GetxController {
  var selectedTab = 1.obs; // Timesheet tab is selected (index 1)
  var selectedDateRange = 'May 26, 2025 - May 29, 2025'.obs;
  var showAlert = true.obs;
  var hasEntries = false.obs; // No entries found state

  void selectTab(int index) {
    selectedTab.value = index;
  }

  void dismissAlert() {
    showAlert.value = false;
  }

  void openDatePicker() {
    // Logic to open date picker
    // For demo purposes, just updating the string
    //selectedDateRange.value = 'Jun 1, 2025 - Jun 5, 2025';
    Get.bottomSheet(
      SelectDateBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(16)),
      ),
    );
  }

  void openFilters() {
    // Logic to open filters bottom sheet or page
    Get.snackbar(
      'Filters',
      'Filters functionality would open here',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green[100],
      colorText: Colors.green[800],
    );
  }

  void openDisplaySettings() {
    // Logic to open display settings
    Get.bottomSheet(
      Container(
        height: Get.height * 0.8,
          child: DisplaySettingBottomsheet()),
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
  }
}

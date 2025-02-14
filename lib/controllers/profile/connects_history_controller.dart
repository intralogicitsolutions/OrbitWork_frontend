import 'package:get/get.dart';

import '../../models/connects_history_model.dart';

class ConnectsHistoryController extends GetxController {
  final RxList<String> selectedFilters = <String>[].obs;
  final RxString selectedFiltersText = 'All connects'.obs;

  final RxInt balance = 97.obs;
  var selectedDuration = 'Last 7 days'.obs;
  final showWarning = true.obs;

  final RxList<ConnectHistory> history = <ConnectHistory>[].obs;

  final List<String> filterOptions = [
    'All connects',
    'All debits',
    'All credits',
    'Add Connects',
    'Purchased',
    'New membership',
    'Applied to job',
    'Free',
    'Refunded',
    'Rollover',
    'Membership Downgrade'
  ];

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  void loadHistory() {
    // Simulated data - replace with your actual data source
    history.value = [
      ConnectHistory(
        date: 'Feb 11, 2025',
        action: 'Applied to job',
        jobTitle: 'Full Stack Developer Needed for React',
        connectsChange: -18,
      ),
      ConnectHistory(
        date: 'Feb 7, 2025',
        action: 'Job cancelled',
        jobTitle: 'React Developer',
        connectsChange: 13,
      ),
      ConnectHistory(
        date: 'Feb 7, 2025',
        action: 'Job cancelled',
        jobTitle: 'React Developer',
        connectsChange: 2
      ),
    ];
  }

  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
  }

  void applyFilters() {
    if (selectedFilters.isEmpty) {
      selectedFiltersText.value = 'All connects';
    } else {
      selectedFiltersText.value = selectedFilters.join(', ');
    }
    Get.back();
  }

  void changeTimeRange(String value) {
    selectedDuration.value = value;
  }

  void dismissWarningText() {
    showWarning.value = false;
  }
}

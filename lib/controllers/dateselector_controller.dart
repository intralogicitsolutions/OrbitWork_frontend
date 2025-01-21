import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateSelectorController extends GetxController {
  final selectedDateLabel = "Current activity".obs;
  final dateRanges = <Map<String, String>>[].obs;
  final isCustomDatePickerOpen = false.obs;

  @override
  void onInit() {
    super.onInit();
    generateDateRanges();
  }

  void generateDateRanges() {
    final now = DateTime.now();
    final thisWeekStart = now.subtract(Duration(days: now.weekday - 1));
    final lastWeekStart = thisWeekStart.subtract(Duration(days: 7));
    final lastWeekEnd = thisWeekStart.subtract(Duration(days: 1));

    dateRanges.assignAll([
      {
        'label': 'Current activity',
        'range': '${_formatDate(now.subtract(Duration(days: 30)))} - ${_formatDate(now)}',
      },
      {
        'label': 'This week',
        'range': '${_formatDate(thisWeekStart)} - ${_formatDate(now)}',
      },
      {
        'label': 'Last week',
        'range': '${_formatDate(lastWeekStart)} - ${_formatDate(lastWeekEnd)}',
      },
      {
        'label': 'This month',
        'range': '${_formatDate(DateTime(now.year, now.month, 1))} - ${_formatDate(now)}',
      },
      for (int i = 1; i <= 3; i++)
        {
          'label': 'Statement - ${DateFormat('MMM yy').format(DateTime(now.year, now.month - i, 1))}',
          'range': '${_formatDate(DateTime(now.year, now.month - i, 1))} - ${_formatDate(DateTime(now.year, now.month - i + 1, 0))}',
        },
      {
        'label': 'Custom date range',
        'range': '',
      },
    ]);
  }

  void selectDateLabel(String label) {
    selectedDateLabel.value = label;
  }

  void toggleCustomDatePicker(bool open) {
    isCustomDatePickerOpen.value = open;
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }
}


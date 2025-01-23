import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateSelectorController extends GetxController {
  final selectedDateLabel = "Current activity".obs;
  final dateRanges = <Map<String, String>>[].obs;
  final isCustomDatePickerOpen = false.obs;

  final customStartDate = Rxn<DateTime>();
  final customEndDate = Rxn<DateTime>();


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

    if (label != 'Custom date range') {
      customStartDate.value = null;
      customEndDate.value = null;
    }
  }

  void toggleCustomDatePicker(bool open) {
    if (!open) {
      customStartDate.value = null;
      customEndDate.value = null;
    }
    isCustomDatePickerOpen.value = open;
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  // String get selectedDateRange {
  //   final selectedRange = dateRanges.firstWhere(
  //         (range) => range['label'] == selectedDateLabel.value,
  //     orElse: () => {'range': ''},
  //   );
  //   return selectedRange['range'] ?? '';
  // }

  String get selectedDateRange {
    if (selectedDateLabel.value == 'Custom date range') {
      final formattedStart = customStartDate.value != null
          ? DateFormat('MMM dd, yyyy').format(customStartDate.value!)
          : '';
      final formattedEnd = customEndDate.value != null
          ? DateFormat('MMM dd, yyyy').format(customEndDate.value!)
          : '';
      return '$formattedStart - $formattedEnd';
    }

    final selectedRange = dateRanges.firstWhere(
          (range) => range['label'] == selectedDateLabel.value,
      orElse: () => {'range': ''},
    );
    return selectedRange['range'] ?? '';
  }

  void updateCustomDateRange() {
    if (customStartDate.value != null && customEndDate.value != null) {
      final formattedStart = DateFormat('MMM dd, yyyy').format(customStartDate.value!);
      final formattedEnd = DateFormat('MMM dd, yyyy').format(customEndDate.value!);

      dateRanges.firstWhere((element) => element['label'] == 'Custom date range')['range'] = '$formattedStart - $formattedEnd';

      update();
    }
  }
}


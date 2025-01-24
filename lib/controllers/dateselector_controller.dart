import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateSelectorController extends GetxController {
  final selectedDateLabel = "Current activity".obs;
  final dateRanges = <Map<String, String>>[].obs;
  final isCustomDatePickerOpen = false.obs;

  final customStartDate = Rxn<DateTime>();
  final customEndDate = Rxn<DateTime>();

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    generateDateRanges();
    _setCurrentActivityRange();
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
        'range': '${_formatDate(now.subtract(Duration(days: 30)))} - ${_formatDate(now)}',
      },
    ]);
  }


  void _setCurrentActivityRange() {
    final now = DateTime.now();
    final activityStart = now.subtract(Duration(days: 30));
    customStartDate.value = activityStart;
    customEndDate.value = now;

    final currentActivityIndex = dateRanges.indexWhere(
          (element) => element['label'] == 'Current activity',
    );
    if (currentActivityIndex != -1) {
      dateRanges[currentActivityIndex]['range'] =
      '${_formatDate(activityStart)} - ${_formatDate(now)}';
      dateRanges.refresh();
    }
  }



  void selectDateLabel(String label) {
    selectedDateLabel.value = label;

    if (label == 'Custom date range') {
      return;

    } else {
      final selectedRange = dateRanges.firstWhere(
            (range) => range['label'] == label,
        orElse: () => {'range': ''},
      )['range'] ?? '';

      if (selectedRange.isNotEmpty) {
        final dates = selectedRange.split(' - ').map((date) {
          return DateFormat('MMM dd, yyyy').parse(date);
        }).toList();

        customStartDate.value = dates.first;
        customEndDate.value = dates.last;

        updateCustomDateRange();
      }
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
    final formattedStart = customStartDate.value != null
        ? _formatDate(customStartDate.value!)
        : '';
    final formattedEnd = customEndDate.value != null
        ? _formatDate(customEndDate.value!)
        : '';

    final range = '$formattedStart - $formattedEnd';

    final customDateRangeIndex = dateRanges.indexWhere(
          (element) => element['label'] == 'Custom date range',
    );

    if (customDateRangeIndex != -1) {
      dateRanges[customDateRangeIndex]['range'] = range;
      dateRanges.refresh();
    }
  }
}
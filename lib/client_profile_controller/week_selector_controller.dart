import 'package:get/get.dart';

class WeekSelectorController extends GetxController {
  var currentMonth = DateTime.now().obs;
  var selectedStartDate = DateTime.now().obs;
  var selectedEndDate = DateTime.now().obs;

  // Week days
  final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  // Month names
  final months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  @override
  void onInit() {
    super.onInit();
    // Set default selected week (May 26 - Jun 1, 2025)
    selectedStartDate.value = DateTime(2025, 5, 26);
    selectedEndDate.value = DateTime(2025, 6, 1);
    currentMonth.value = DateTime(2025, 5, 1);
  }

  // Navigate to previous month
  void previousMonth() {
    currentMonth.value = DateTime(currentMonth.value.year, currentMonth.value.month - 1);
  }

  // Navigate to next month
  void nextMonth() {
    currentMonth.value = DateTime(currentMonth.value.year, currentMonth.value.month + 1);
  }

  // Get days in current month
  List<DateTime?> getDaysInMonth() {
    final firstDay = DateTime(currentMonth.value.year, currentMonth.value.month, 1);
    final lastDay = DateTime(currentMonth.value.year, currentMonth.value.month + 1, 0);

    // Get the weekday of first day (1 = Monday, 7 = Sunday)
    int firstWeekday = firstDay.weekday;

    List<DateTime?> days = [];

    // Add previous month's trailing days
    for (int i = 1; i < firstWeekday; i++) {
      final prevDay = firstDay.subtract(Duration(days: firstWeekday - i));
      days.add(prevDay);
    }

    // Add current month's days
    for (int day = 1; day <= lastDay.day; day++) {
      days.add(DateTime(currentMonth.value.year, currentMonth.value.month, day));
    }

    return days;
  }

  // Check if a date is selected (within the selected week range)
  bool isDateSelected(DateTime date) {
    return date.isAfter(selectedStartDate.value.subtract(Duration(days: 1))) &&
        date.isBefore(selectedEndDate.value.add(Duration(days: 1)));
  }

  // Check if date is start of selected week
  bool isStartDate(DateTime date) {
    return isSameDay(date, selectedStartDate.value);
  }

  // Check if date is end of selected week
  bool isEndDate(DateTime date) {
    return isSameDay(date, selectedEndDate.value);
  }

  // Check if two dates are the same day
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  // Handle date selection (select week starting from Monday)
  void selectDate(DateTime date) {
    // Find the Monday of the week containing this date
    int daysFromMonday = date.weekday - 1;
    DateTime weekStart = date.subtract(Duration(days: daysFromMonday));
    DateTime weekEnd = weekStart.add(Duration(days: 6));

    selectedStartDate.value = weekStart;
    selectedEndDate.value = weekEnd;
  }

  // Get formatted month year string
  String getMonthYearString() {
    return '${months[currentMonth.value.month - 1]} ${currentMonth.value.year}';
  }

  // Get formatted selected week string
  String getSelectedWeekString() {
    final startMonth = months[selectedStartDate.value.month - 1];
    final endMonth = months[selectedEndDate.value.month - 1];

    if (selectedStartDate.value.month == selectedEndDate.value.month) {
      return '$startMonth ${selectedStartDate.value.day} - ${selectedEndDate.value.day}, ${selectedStartDate.value.year}';
    } else {
      return '$startMonth ${selectedStartDate.value.day} - $endMonth ${selectedEndDate.value.day}, ${selectedStartDate.value.year}';
    }
  }

  // Move to the previous week
  void previousWeek() {
    selectedStartDate.value = selectedStartDate.value.subtract(Duration(days: 7));
    selectedEndDate.value = selectedEndDate.value.subtract(Duration(days: 7));

    // Update the calendar view if month changes
    currentMonth.value = DateTime(
      selectedStartDate.value.year,
      selectedStartDate.value.month,
      1,
    );
  }

  // Move to the next week
  void nextWeek() {
    selectedStartDate.value = selectedStartDate.value.add(Duration(days: 7));
    selectedEndDate.value = selectedEndDate.value.add(Duration(days: 7));

    // Update the calendar view if month changes
    currentMonth.value = DateTime(
      selectedStartDate.value.year,
      selectedStartDate.value.month,
      1,
    );
  }
}
import 'package:get/get.dart';

import '../models/day_timesheet_model.dart';
import '../models/timesheet_transaction_model.dart';

class TimesheetController extends GetxController {
  var selectedTab = 0.obs;

  final RxString userName = 'Harshad'.obs;
  final RxString userRole = 'Cofounderslab Admin'.obs;
  final RxString location = 'United States'.obs;
  final RxString lastWorked = '49 minutes ago'.obs;

  final RxDouble last24Hours = 0.0.obs;
  final RxDouble thisWeek = 0.0.obs;
  final RxDouble lastWeek = 0.0.obs;
  final RxDouble sinceStart = 0.0.obs;

  final RxDouble hourlyRate = 0.0.obs;
  final RxDouble totalAmount = 0.0.obs;
  final RxString dateRange = 'Feb 24 - Mar 2, 2025'.obs;

  final RxList<DayTimesheet> weeklyTimesheet = <DayTimesheet>[].obs;
  final RxDouble trackedHours = 2.10.obs;
  final RxDouble manualHours = 0.00.obs;
  final RxDouble overtimeHours = 0.00.obs;

  final RxDouble last7DaysAmount = 0.0.obs;
  final RxDouble last30DaysAmount = 0.0.obs;
  final RxDouble sinceStartAmount = 0.0.obs;
  final RxList<TimesheetTransaction> transactions = <TimesheetTransaction>[].obs;

  final RxDouble earningThisWeek = 0.0.obs;
  final RxDouble contractRate = 0.0.obs;
  final RxDouble weekTracked = 0.0.obs;
  final RxInt weeklyLimit = 40.obs;


  @override
  void onInit() {
    super.onInit();
    initializeWeeklyTimesheet();
    initializeTransactions();
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void initializeWeeklyTimesheet() {
    weeklyTimesheet.value = [
      DayTimesheet(day: "Monday", date: 24, hours: 2.10, isTracked: true),
      DayTimesheet(day: "Tuesday", date: 25, hours: 0.00, isTracked: false),
      DayTimesheet(day: "Wednesday", date: 26, hours: 0.00, isTracked: false),
      DayTimesheet(day: "Thursday", date: 27, hours: 0.00, isTracked: false),
      DayTimesheet(day: "Friday", date: 28, hours: 0.00, isTracked: false),
      DayTimesheet(day: "Saturday", date: 1, hours: 0.00, isTracked: false),
      DayTimesheet(day: "Sunday", date: 2, hours: 0.00, isTracked: false),
    ];
  }

  void initializeTransactions() {
    transactions.value = [
      TimesheetTransaction(date: 'Feb 21', description: 'WHT', amount: 25.00, isPositive: false),
      TimesheetTransaction(date: 'Feb 21', description: 'Service Fee', amount: 15.50, isPositive: false),
      TimesheetTransaction(date: 'Feb 21', description: 'GST', amount: 10.00, isPositive: false),
      TimesheetTransaction(date: 'Feb 21', description: 'Hourly', amount: 250.00, isPositive: true),
      TimesheetTransaction(date: 'Feb 14', description: 'Service Fee', amount: 15.50, isPositive: false),
      TimesheetTransaction(date: 'Feb 14', description: 'GST', amount: 10.00, isPositive: false),
    ];

    // Initialize summary amounts
    last7DaysAmount.value = 500.00;
    last30DaysAmount.value = 2000.00;
    sinceStartAmount.value = 5000.00;
  }

}

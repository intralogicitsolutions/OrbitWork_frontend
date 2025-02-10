import 'package:get/get.dart';

import '../models/month_model.dart';

class MonthController extends GetxController {
  var selectedMonth = Rx<MonthModel?>(null);

  final List<MonthModel> months = [
    MonthModel(name: 'January', index: 0),
    MonthModel(name: 'February', index: 1),
    MonthModel(name: 'March', index: 2),
    MonthModel(name: 'April', index: 3),
    MonthModel(name: 'May', index: 4),
    MonthModel(name: 'June', index: 5),
    MonthModel(name: 'July', index: 6),
    MonthModel(name: 'August', index: 7),
    MonthModel(name: 'September', index: 8),
    MonthModel(name: 'October', index: 9),
    MonthModel(name: 'November', index: 10),
    MonthModel(name: 'December', index: 11),
  ];

  void selectMonth(MonthModel month) {
    selectedMonth.value = month;
    Get.back(result: month);
  }
}
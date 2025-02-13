import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoostProfileController extends GetxController {
  final RxInt connects = 0.obs;
  final RxBool isDailySelected = true.obs;
  final RxString selectedDate = ''.obs;
  final TextEditingController connectTextController = TextEditingController();

  void toggleDailyTotal(bool isDaily) {
    isDailySelected.value = isDaily;
  }

  void setDate(String date) {
    selectedDate.value = date;
  }
}
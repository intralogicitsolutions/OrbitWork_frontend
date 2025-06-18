import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetUserRateController extends GetxController {
  final hourlyRateController = TextEditingController();
  RxDouble hourlyRate = 0.0.obs;
  RxDouble serviceFee = 0.0.obs;
  RxDouble receiveAmount = 0.0.obs;

  void calculateFee(String value) {
    final rate = double.tryParse(value) ?? 0.0;
    hourlyRate.value = rate;
    serviceFee.value = rate * 0.10;
    receiveAmount.value = rate - serviceFee.value;
  }

  @override
  void onClose() {
    hourlyRateController.dispose();
    super.onClose();
  }
}

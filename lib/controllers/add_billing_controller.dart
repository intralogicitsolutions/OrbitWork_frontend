import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBillingController extends GetxController {
  final RxString selectedMethod = ''.obs;

  final cardNumberController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final expiryMonthController = TextEditingController();
  final expiryYearController = TextEditingController();
  final securityCodeController = TextEditingController();
  final addressLine1Controller = TextEditingController();
  final addressLine2Controller = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();

  final selectedCountry = 'India'.obs;
  final countries = ['India', 'USA', 'UK', 'Canada', 'Australia'].obs;

  final selectedCardType = 'visa'.obs;

  @override
  void onClose() {
    cardNumberController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    expiryMonthController.dispose();
    expiryYearController.dispose();
    securityCodeController.dispose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    super.onClose();
  }

  void setSelectedMethod(String method) {
    selectedMethod.value = method;
  }

  void addPaymentMethod() {
    Get.back();
  }
}
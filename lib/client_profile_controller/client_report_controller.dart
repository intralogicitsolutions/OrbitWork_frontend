import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientReportController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;

  final List<String> tabTitles = [
    'Weekly Summary',
    'Transaction History',
    'Timesheet',
    'Time by Freelancer',
    'Time by Activity',
  ];

  @override
  void onInit() {
    tabController = TabController(length: tabTitles.length, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
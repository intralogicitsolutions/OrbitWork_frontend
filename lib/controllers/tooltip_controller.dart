import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_tooltip/super_tooltip.dart';

class TooltipController extends GetxController {

  final SuperTooltipController tooltipController = SuperTooltipController();
  var tooltipText = ''.obs;

  void showTooltip() {
    //tooltipText.value = text;
    tooltipController.showTooltip();
  }

  void hideTooltip() {
    tooltipController.hideTooltip();
  }

  
}
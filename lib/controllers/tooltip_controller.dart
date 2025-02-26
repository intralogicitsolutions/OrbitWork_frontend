import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_tooltip/super_tooltip.dart';

class TooltipController extends GetxController {

  final SuperTooltipController tooltipController = SuperTooltipController();
  var tooltipText = ''.obs;

  // final RxBool isVisible = false.obs;
  // final RxDouble xPosition = 0.0.obs;
  // final RxDouble yPosition = 0.0.obs;
  // final RxString currentTooltip = ''.obs;
  //
  // void showTooltip(String tooltipText, BuildContext context, GlobalKey key) {
  //   // Get the RenderBox of the icon
  //   final RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
  //   final Size size = renderBox.size;
  //   final Offset position = renderBox.localToGlobal(Offset.zero);
  //
  //   // Calculate position for tooltip
  //   xPosition.value = position.dx;
  //   yPosition.value = position.dy + size.height + 5;
  //   currentTooltip.value = tooltipText;
  //   isVisible.value = true;
  // }
  //
  // void hideTooltip() {
  //   isVisible.value = false;
  // }


  void showTooltip(String text) {
    tooltipText.value = text;
    tooltipController.showTooltip();
  }

  void hideTooltip() {
    tooltipController.hideTooltip();
  }

  
}
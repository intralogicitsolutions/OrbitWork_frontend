import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Drawercontroller extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void openDrawer() {
    animationController.forward(); // Start animation to open the drawer
  }

  void closeDrawer() {
    animationController.reverse(); // Reverse animation to close the drawer
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

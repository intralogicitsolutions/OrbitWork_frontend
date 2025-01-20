import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/theme_controller.dart';

class Drawercontroller extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  //final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  final themeController = Get.find<ThemeController>();

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

  void openBottomSheet(BuildContext context){
    Get.bottomSheet(
        //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          //color: Colors.white,
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 30,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Theme",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () {
                    Get.back(); // Close bottom sheet
                  },
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.phone_android),
              title: Text('Auto'),
              subtitle: Text('Use the same theme as your device'),
              onTap: (){
                // themeMode.value = ThemeMode.system;
                // Get.changeThemeMode(ThemeMode.system);
                themeController.setAutoTheme();
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.light_mode),
              title: Text('Light'),
              subtitle: Text('Light background with dark text'),
              onTap: (){
                // themeMode.value = ThemeMode.light;
                // Get.changeThemeMode(ThemeMode.light);
                themeController.setLightTheme();
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Dark'),
              subtitle: Text('dark background with light text'),
              onTap: (){
                // themeMode.value = ThemeMode.dark;
                // Get.changeThemeMode(ThemeMode.dark);
                themeController.setDarkTheme();
                Get.back();
              },
            ),
          ],
        ),
      )
    );
  }
}

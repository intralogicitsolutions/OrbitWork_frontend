  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:orbitwork/routes/app_page.dart';
  import 'package:orbitwork/routes/app_routes.dart';

import 'comms/global/global_binding.dart';
import 'controllers/theme_controller.dart';

  void main() {
    Get.put(ThemeController());
    GlobalBindings().dependencies();
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return Obx(() {
        final themeController = Get.find<ThemeController>();
      return GetMaterialApp(
        title: 'Orbitwork',
        theme: themeController.lightTheme,
        darkTheme: themeController.darkTheme,
        themeMode: themeController.themeMode.value,
        initialRoute: AppRoutes.onboarding,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      );
      });
    }
  }


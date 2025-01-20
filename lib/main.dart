  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:orbitwork/routes/app_page.dart';
  import 'package:orbitwork/routes/app_routes.dart';

import 'controllers/theme_controller.dart';

  void main() {
    Get.put(ThemeController());
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
        // theme: ThemeData.light(),
        // darkTheme: ThemeData.dark(),
        // themeMode: themeController.themeMode.value,
        theme: themeController.lightTheme,
        darkTheme: themeController.darkTheme,
        themeMode: themeController.themeMode.value,
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        initialRoute: AppRoutes.onboarding,
        getPages: AppPages.routes,
        // home: SignUpPage(),
        debugShowCheckedModeBanner: false,
      );
      });
    }
  }


  import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
  import 'package:get/get.dart';
  import 'package:orbitwork/routes/app_page.dart';
  import 'package:orbitwork/routes/app_routes.dart';
import 'package:orbitwork/socket/notification_service/notification_service.dart';

import 'comms/global/global_binding.dart';
import 'controllers/theme_controller.dart';

  void main() async {
    Get.put(ThemeController());
    GlobalBindings().dependencies();
    WidgetsFlutterBinding.ensureInitialized();
   // await NotificationService().init();
    await Get.putAsync(() => NotificationService().init());
    Stripe.publishableKey = 'pk_test_51RBCKHFyOk7VHYFBqI6GpHJrJtkYEZXO19LJlPdzs4tVhVWwq4eESguKYGvKqI0pgx3kIdPfLxaRjUxqlOhqnJo400PcoB55JS';
    await Stripe.instance.applySettings();
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


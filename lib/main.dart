  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:orbitwork/routes/app_page.dart';
  import 'package:orbitwork/routes/app_routes.dart';

  void main() {
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return GetMaterialApp(
        title: 'Orbitwork',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.onboarding,
        getPages: AppPages.routes,
        // home: SignUpPage(),
        debugShowCheckedModeBanner: false,
      );
    }
  }


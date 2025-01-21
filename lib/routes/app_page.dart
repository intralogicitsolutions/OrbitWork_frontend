import 'package:get/get.dart';
import 'package:orbitwork/routes/app_routes.dart';
import 'package:orbitwork/views/homescreen.dart';
import 'package:orbitwork/views/login.dart';
import 'package:orbitwork/views/onboarding.dart';
import 'package:orbitwork/views/reports_page.dart';
import 'package:orbitwork/views/signup.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.login, page: () => LoginPage()),
    GetPage(name: AppRoutes.signup, page: () => SignUpPage()),
    GetPage(name: AppRoutes.onboarding, page: () => OnboardingPage()),
    GetPage(name: AppRoutes.homeScreen, page: () => HomeScreen()),
    GetPage(name: AppRoutes.reports, page: () => ReportsPage()),
  ];
}
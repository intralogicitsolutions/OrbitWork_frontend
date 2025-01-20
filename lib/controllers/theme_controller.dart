import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Reactive variable to manage theme mode
  Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  // Light theme configuration
  ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
    ),
  );

  // Dark theme configuration
  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.black, // Correct background property
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
  );

  // Method to switch to light theme
  void setLightTheme() {
    themeMode.value = ThemeMode.light;
    Get.changeThemeMode(ThemeMode.light);
  }

  // Method to switch to dark theme
  void setDarkTheme() {
    themeMode.value = ThemeMode.dark;
    Get.changeThemeMode(ThemeMode.dark);
  }

  // Method to switch to system theme
  void setAutoTheme() {
    themeMode.value = ThemeMode.system;
    Get.changeThemeMode(ThemeMode.system);
  }
}

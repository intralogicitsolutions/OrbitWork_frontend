import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

// class NotificationService {
//   static final NotificationService _instance = NotificationService._internal();
//
//   factory NotificationService() => _instance;
//
//   NotificationService._internal();
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   Future<void> init() async {
//     final AndroidInitializationSettings androidSettings =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     // final IOSInitializationSettings iosSettings = IOSInitializationSettings(
//     //   requestSoundPermission: true,
//     //   requestBadgePermission: true,
//     //   requestAlertPermission: true,
//     // );
//
//     final InitializationSettings initSettings = InitializationSettings(
//       android: androidSettings,
//      // iOS: iosSettings,
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(initSettings);
//   }
//
//   Future<void> requestAndroidNotificationPermission() async {
//     if (await Permission.notification.isDenied ||
//         await Permission.notification.isPermanentlyDenied) {
//       await Permission.notification.request();
//     }
//   }
//
//   Future<void> showNotification({
//     required String title,
//     required String body,
//     String? payload,
//   }) async {
//     const AndroidNotificationDetails androidDetails =
//     AndroidNotificationDetails(
//       'chat_channel', // channel ID
//       'Chat Notifications', // channel name
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//
//     const NotificationDetails platformDetails = NotificationDetails(
//       android: androidDetails,
//     );
//
//     await flutterLocalNotificationsPlugin.show(
//       DateTime.now().millisecondsSinceEpoch ~/ 1000,
//       title,
//       body,
//       platformDetails,
//       payload: payload,
//     );
//   }
// }


import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationService extends GetxService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<NotificationService> init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // app icon

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    return this;
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? imageUrl, // This can be used for images
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'chat_channel', // channel ID
      'Chat Messages', // channel name
      channelDescription: 'Channel for chat message notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: imageUrl != null
          ? BigPictureStyleInformation(
        FilePathAndroidBitmap(imageUrl),
        contentTitle: title,
        summaryText: body,
      )
          : null,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}


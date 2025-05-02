import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class FileDownloadController extends GetxController {
  RxDouble progress = 0.0.obs;
  RxBool isDownloading = false.obs;
  RxBool isDownloaded = false.obs;

  Future<String> getDownloadPath(String fileName) async {
    Directory? directory;
    if (Platform.isAndroid) {
     // directory = Directory('/storage/emulated/0/Download');
      directory = Directory('/storage/emulated/0/Download'); // For Android
     // directory = await getExternalStorageDirectory();

    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    return '${directory.path}/$fileName';
  }

  Future<bool> fileAlreadyExists(String fileName) async {
    final path = await getDownloadPath(fileName);
    return File(path).exists();
  }

  Future<void> downloadFile(String url, String fileName) async {
    final status = await Permission.storage.request();
    // if (!status.isGranted) {
    //   print('"Permission Denied", "Storage permission is required."');
    //   Get.snackbar("Permission Denied", "Storage permission is required.");
    //   return;
    // }
    // if (status.isDenied || status.isPermanentlyDenied) {
    //   Get.snackbar(
    //     "Permission Denied",
    //     "Storage permission is required.",
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.red.shade100,
    //     colorText: Colors.black,
    //   );
    //   return;
    // }
    //
    // // For Android 11+ (API 30+), might need this too:
    // if (Platform.isAndroid && await Permission.manageExternalStorage.isDenied) {
    //   final manageStorage = await Permission.manageExternalStorage.request();
    //   if (!manageStorage.isGranted) {
    //     Get.snackbar(
    //       "Permission Denied",
    //       "Manage External Storage permission is required.",
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.red.shade100,
    //       colorText: Colors.black,
    //     );
    //     return;
    //   }
    // }
    try {
      if (!await checkAndRequestStoragePermission()) return;

      final filePath = await getDownloadPath(fileName);
      final request = await http.Client().send(http.Request('GET', Uri.parse(url)));
      final contentLength = request.contentLength ?? 0;
      final file = File(filePath);
      if (await file.exists()) {
        isDownloaded.value = true;
        return;
      }

      isDownloading.value = true;
      progress.value = 0.0;



      final total = request.contentLength ?? 0;
      final bytes = <int>[];
      int received = 0;


      await for (var chunk in request.stream) {
        bytes.addAll(chunk);
        received += chunk.length;
        progress.value = received / contentLength;
      }

      await file.writeAsBytes(bytes);
      isDownloading.value = false;
      isDownloaded.value = true;

      await OpenFilex.open(filePath);
    } catch (e) {
      isDownloading.value = false;
      print("download failed =====> ${e.toString()}");
      Get.snackbar("Download Failed", e.toString());

    }
  }

  Future<bool> checkAndRequestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.isGranted) {
        return true;
      }

      final result = await Permission.manageExternalStorage.request();
      if (result.isGranted) {
        return true;
      } else {
        Get.snackbar(
          "Permission Denied",
          "Storage permission is required to save files.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } else {
      return true; // iOS handles permissions differently
    }
  }


// Future<bool> checkAndRequestStoragePermission() async {
  //   // For Android 13+ use READ_MEDIA permissions
  //   if (await Permission.storage.isGranted || await Permission.mediaLibrary.isGranted) {
  //     return true;
  //   }
  //
  //   final result = await Permission.storage.request();
  //   if (result.isGranted) {
  //     return true;
  //   } else {
  //     Get.snackbar(
  //       "Permission Denied",
  //       "Storage permission is required.",
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     return false;
  //   }
  // }
}

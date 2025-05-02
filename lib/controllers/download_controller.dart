import 'package:get/get.dart';

class DownloadController extends GetxController {
  var downloadProgress = <String, double>{}.obs; // Map<fileName, progress>

  void setProgress(String fileName, double progress) {
    downloadProgress[fileName] = progress;
  }

  double getProgress(String fileName) {
    return downloadProgress[fileName] ?? 0.0;
  }

  bool isDownloading(String fileName) {
    final progress = downloadProgress[fileName];
    return progress != null && progress < 1.0;
  }
}

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  /// Opens a URL in an external browser (e.g., Chrome)
  static Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error', 'Could not open the link');
    }
  }
}

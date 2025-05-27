// lib/controllers/notification_controller.dart
import 'package:get/get.dart';

import '../socket/notification_service/notification_service.dart';
import '../socket/socket_service/notification_socket.dart';


class NotificationController extends GetxController {
  final NotificationService notificationService = Get.find();
  final String userId;

  NotificationController(this.userId);

  @override
  void onInit() {
    super.onInit();
    _initializeSocket();
  }

  void _initializeSocket() {
    final socketService = SocketService(userId);
    socketService.init().then((_) {
      socketService.listenForNotifications(_handleSocketNotification);
    });
  }

  void _handleSocketNotification(dynamic data) {
    if (data is Map<String, dynamic>) {
      final title = 'New Proposal';
      final body = data['message'] ?? 'You have a new job proposal';

      notificationService.showNotification(
        id: DateTime.now().millisecondsSinceEpoch,
        title: title,
        body: body,
        payload: data['proposalId']?.toString(),
      );

      // Show a snackbar if app is in foreground
      if (Get.isSnackbarOpen == false) {
        Get.snackbar(title, body);
      }
    }
  }
}
// lib/services/socket_service.dart
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxService {
  late IO.Socket socket;
  final String userId;

  SocketService(this.userId);

  Future<SocketService> init() async {
    // Initialize socket connection
    socket = IO.io(
      'https://317b-2405-f600-8-42f1-44bd-8921-b790-13dc.ngrok-free.app', // Replace with your server URL
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setPath('/socket.io') // If your server uses a specific path
          .build(),
    );

    // Connect to notifications namespace
    socket.onConnect((_) {
      print('Connected to socket server');
      // Register user with their ID
      socket.emit('register', userId);
    });

    // socket.onDisconnect((_) => print('Disconnected from socket server'));
    // socket.onError((error) => print('Socket error: $error'));

    return this;
  }

  void listenForNotifications(Function(dynamic) onNotification) {
    socket.on('new_notification', (data) {
      onNotification(data);
    });
  }

  @override
  void onClose() {
    socket.disconnect();
    super.onClose();
  }
}
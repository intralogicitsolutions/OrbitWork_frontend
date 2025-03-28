import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxService {
   IO.Socket? socket;

  @override
  void onInit() {
    super.onInit();
    connectToSocket();
  }

  void connectToSocket() {
    socket = IO.io(
      'https://orbitwork-backend.onrender.com',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket!.onConnect((_) {
      print("Connected to socket");
    });

    socket!.on("connect_user", (data) {
      print("User connected: $data");
    });

    socket!.on("chat_message", (data) {
      print("New message received: $data");
    });

    socket!.connect();
  }

  // void sendMessage(
  //     {String? senderId,
  //     String? receiverId,
  //     String? message,
  //     String? attachmentId,
  //     String? messageType}) {
  //   socket!.emit("chat_message", {
  //     "sender_id": senderId,
  //     "receiver_id": receiverId,
  //     "message": message,
  //     "attechment_id": attachmentId,
  //     "message_type": messageType,
  //   });
  // }
  // void sendMessage(Map<String, dynamic> messageData) {
  //   socket.emit("chat_message", messageData);
  // }

  // void connectUser(String userId) {
  //   socket!.emit('connect_user', {"userId": userId});
  // }
}

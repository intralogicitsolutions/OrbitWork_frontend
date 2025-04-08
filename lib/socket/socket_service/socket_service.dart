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
      //'https://orbitwork-backend.onrender.com',
      'https://c534-2405-f600-8-f614-595a-951a-fbfd-ddb3.ngrok-free.app',
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

    socket!.on('message_seen', (data) {
    print("message seen: $data");
    },);

    socket!.connect();
  }
   void updateMessage(String messageId, String updatedText) {
     socket?.emit('update_message', {
       'messageId': messageId,
       'message': updatedText,
     });
   }

   void deleteMessage(String messageId, String userId, {bool deleteForEveryone = false}) {
     socket?.emit('delete_message', {
       'messageId': messageId,
       'userId': userId,
       'deleteForEveryone': deleteForEveryone,
     });
   }

   void emitMessageSeen(String messageId, String userId) {
     socket?.emit('message_seen', {
       'messageId': messageId,
       'user_id': userId,
     });
   }

   void listenForUpdatedMessages(Function(Map data) onUpdated) {
     socket?.on('message_updated', (data) {
       onUpdated(data);
     });
   }

   void listenForDeletedMessages(Function(Map data) onDeleted) {
     socket?.on('message_deleted', (data) {
       onDeleted(data);
     });
   }

   void listenForSeenMessages(Function(Map data) onSeen) {
     socket?.on('message_seen', (data) {
       onSeen(data);
     });
   }

}

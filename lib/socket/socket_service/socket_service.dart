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
      'https://8643-2405-f600-8-162a-dcd7-6c76-cd28-f28b.ngrok-free.app',
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

    socket!.on(
      'message_seen',
      (data) {
        print("message seen: $data");
      },
    );

    socket!.connect();
  }

  void connectUser(String userId) {
    socket!.emit('connect_user', {'user_id': userId});
  }

  void leaveRoom(String roomId, String userId) {
    if (socket == null) {
      print('Socket is null. Cannot leave room.');
      return;
    }
    socket!.emit('leave_room', {
      'room_id': roomId,
      'user_id': userId,
    });
  }

  void joinRoom(String userId, String roomId) {
    socket!.emit('join_room', {
      'user_id': userId,
      'room_id': roomId,
    });
  }

  void sendGroupMessage(Map<String, dynamic> messageData) {
    socket!.emit('chat_message', messageData);
  }

  void updateMessage(String messageId, String updatedText) {
    socket?.emit('update_message', {
      'messageId': messageId,
      'message': updatedText,
    });
  }

  void updateGroupMessage(String messageId, String roomId, String updatedText) {
    socket!.emit('update_group_message', {
      'messageId': messageId,
      'room_id': roomId,
      'message': updatedText,
    });
  }

  void deleteMessage(String messageId, String userId,
      {bool deleteForEveryone = false}) {
    socket?.emit('delete_message', {
      'messageId': messageId,
      'userId': userId,
      'deleteForEveryone': deleteForEveryone,
    });
  }

  void deleteGroupMessage(String messageId, String roomId,) {
    socket!.emit('delete_group_message', {
      'messageId': messageId,
      'room_id': roomId,
      //'deleteForEveryone': deleteForEveryone,
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

  void listenToGroupMessages(Function(dynamic) onMessageReceived) {
    socket!.on('chat_message', onMessageReceived);
  }

  void listenToGroupMessageUpdate(Function(Map data) onUpdated) {
    socket!.on('group_message_updated', (data){
      onUpdated(data);
    });
  }

  void listenToGroupMessageDelete(Function(Map data) onDeleted) {
    socket!.on('group_message_deleted', (data) {
      onDeleted(data);
    });
  }

  void listenForLeftRoom(Function(dynamic) onLeftRoom) {
    socket?.on('left_room', onLeftRoom);
  }

  // void updateGroupMessage(Map<String, dynamic> data) {
  //   socket!.emit('update_group_message', data);
  // }

  // void deleteGroupMessage(String messageId, String roomId) {
  //   socket!.emit('delete_group_message', {
  //     'messageId': messageId,
  //     'room_id': roomId,
  //   });
  // }
}

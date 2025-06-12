import 'package:get/get.dart';
import 'package:orbitwork/global/global.dart';
import 'package:orbitwork/models/group_message_model.dart';
import 'package:orbitwork/models/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService extends GetxService {
  IO.Socket? socket;

  final RxBool isConnected = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   connectToSocket();
  // }
  //
  // void connectToSocket() {
  //   socket = IO.io(
  //     'https://5b61-2405-f600-8-51d5-2924-9248-488-2392.ngrok-free.app',
  //     IO.OptionBuilder()
  //         .setTransports(['websocket'])
  //         .disableAutoConnect()
  //         .build(),
  //   );
  //
  //   socket!.onConnect((_) {
  //     print("Socket connected");
  //   });
  //
  //   socket!.onDisconnect((_) {
  //     print("Socket disconnected");
  //   });
  //
  //   socket!.onConnectError((err) => print("Connect error: $err"));
  //
  //   socket!.on("connect_user", (data) {
  //     print("User connected: $data");
  //   });
  //
  //   socket!.on("chat_message", (data) {
  //     print("New message received: $data");
  //   });
  //
  //   socket!.connect();
  // }

  Future<void> connectSocket(String userId) async {
    socket = IO.io('https://23df-2405-f600-8-cf71-6d71-e581-623e-e8f7.ngrok-free.app', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket?.connect();

    socket?.onConnect((_) {
      isConnected.value = true;
      print('✅ Socket connected');
      socket?.emit('connect_user', {'user_id': userId});
    });

    socket?.onDisconnect((_) {
      isConnected.value = false;
      print('❌ Socket disconnected');
    });

    socket?.onConnectError((data) {
      print('❗ Socket Connect Error: $data');
    });

    socket?.onError((data) {
      print('❗ Socket Error: $data');
    });
  }

  // void connectUser(String userId) {
  //   socket!.emit('connect_user', {'user_id': userId});
  // }

  // =========================
  //  User Presence
  // =========================

  void emitUserOnline(String userId) {
    socket?.emit('user_online', userId);
    print("Emitted user_online: $userId");
  }

  void emitUserLeftMessagePage(String userId) {
    socket?.emit('user_left_message_page', userId);
    print("Emitted user_left_message_page: $userId");
  }

  // =========================
  //  User Room Management
  // =========================

  void joinRoom(String userId, String roomId) {
    socket!.emit('join_room', {
      'user_id': userId,
      'room_id': roomId,
    });
  }

  void leaveRoom(String roomId, String userId) {
    socket!.emit('leave_room', {
      'room_id': roomId,
      'user_id': userId,
    });
  }

  // =========================
  //  Message Emitters
  // =========================

  void sendMessage(MessageModel messageData) {
    socket?.emit('chat_message', messageData);
  }

  void sendGroupMessage(GroupMessageModel messageData) {
    socket?.emit('chat_message', messageData);
  }

  void emitMessageSeen(String messageId, String userId, bool isGroup) {
    socket?.emit('message_seen', {
      'messageId': messageId,
      'user_id': userId,
      'isGroup': isGroup,
    });
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

  void deleteMessage(String messageId){
    socket?.emit('delete_message', {
      'messageId': messageId
    });
  }

  void deleteGroupMessage(String messageId){
    socket?.emit('delete_group_message', {
      'messageId': messageId
    });
  }

  // void sendGroupMessage(Map<String, dynamic> messageData) {
  //   socket!.emit('chat_message', messageData);
  // }
  //=========================
  // Event Listeners
  // =========================

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

  void listenForSeenGroupMessages(Function(Map data) onSeen) {
    socket?.on('message_seen', (data) {
      onSeen(data);
    });
  }

  void listenForDeliveredMessages(Function(Map<String, dynamic> data) onDelivered){
    socket?.on('message_delivered', (data) {
      print("📨 message_delivered event received: $data");
      if (data is Map<String, dynamic>) {
      onDelivered(data);
      } else if (data is Map) {
        onDelivered(Map<String, dynamic>.from(data));}
      else {
        print("⚠️ Invalid data type for message_delivered: $data");
      }
    });
  }

  void listenForDeliveredGroupMessages(Function(Map data) onDelivered){
    socket?.on('message_delivered', (data) {
      onDelivered(data);
    });
  }

  void listenToReceivedMessages(Function(Map<String, dynamic>) onReceived){
    socket?.on('chat_message', (data) {
      print('📨 Received direct message: $data');
      if (data is Map<String, dynamic>) {
      onReceived(data);
      }
    });
  }

  void listenToNewMessages(Function(Map<String, dynamic>) onData) {
    socket?.on('new_message', (data) {
      print('🆕 New message: $data');
      onData(Map<String, dynamic>.from(data));
    });
  }


  void listenToGroupMessages(Function(Map<String, dynamic>) onMessageReceived) {
    socket?.on('chat_message', (data) {
      print('📨 Received direct group message: $data');
      if (data is Map<String, dynamic>) {
        onMessageReceived(data);
      }
    });
  }

  void listenToGroupMessageUpdate(Function(Map data) onUpdated) {
    socket?.on('group_message_updated', (data){
      onUpdated(data);
    });
  }

  void listenToGroupMessageDelete(Function(Map data) onDeleted) {
    socket?.on('group_message_deleted', (data) {
      onDeleted(data);
    });
  }

  void listenForLeftRoom(Function(dynamic) onLeftRoom) {
    socket?.on('left_room', onLeftRoom);
  }

  void listenForPresenceUpdates(Function(String userId, bool isOnline) onChange) {
    socket?.on('presence_update', (data) {
      final userId = data['userId'];
      final isOnline = data['isOnline'];
      if (userId != null && isOnline != null) {
        onChange(userId, isOnline);
      }
    });
  }

  // =========================
  // NOTIFICATION LISTENER
  // =========================

  void onReceiveNotification(Function(dynamic data) callback) {
    socket?.on('receiveNotification', (data){
      print("Notification received: $data");
      callback(data);
    });
  }

  // // Optional: Chat related
  // void onNewMessage(Function(dynamic data) callback) {
  //   socket?.on('new_message', callback);
  // }
  //
  // void emitChatMessage(Map<String, dynamic> message) {
  //   socket?.emit('chat_message', message);
  // }

  void setupMessageListeners({
    //required Function(dynamic data) onNewMessage,
    required Function(dynamic data) onNotification,
  }) {
    //socket?.on('new_message', onNewMessage);
    socket?.on('receiveNotification', onNotification);
  }



  void on(String event, Function(dynamic) callback) {
    socket?.on(event, callback);
  }

  void off(String event) {
    socket?.off(event);
  }

  // =========================
  //  Cleanup
  // =========================

  /// Disconnects from the socket server.
  // void disconnect() {
  //   socket?.emit('user_left_message_page', Global.userId);
  //   socket?.disconnect();
  //   socket?.destroy();
  // }
}

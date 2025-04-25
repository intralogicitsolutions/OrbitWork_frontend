import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/upload_file_controller.dart';
import 'package:orbitwork/global/global.dart';
import 'package:orbitwork/models/user_model.dart';
import 'package:orbitwork/repository/api/api_constants.dart';
import '../comms/enum/message.dart';
import '../global/tokenStorage.dart';
import '../models/chat_item_model.dart';
import '../models/group_message_model.dart';
import '../models/message_model.dart';
import '../models/upload_file_model.dart';
import '../models/user_details_model.dart';
import '../socket/notification_service/notification_service.dart';
import '../socket/socket_service/socket_service.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class ChatController extends GetxController {
  final String? receiverId;
  final String? roomId;
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final RxList<GroupMessageModel> groupMessages = <GroupMessageModel>[].obs;
  final RxString messageText = ''.obs;

  final RxList<Map<String, dynamic>> notifications = <Map<String, dynamic>>[].obs;

  final SocketService socketService = Get.put(SocketService());
  final UploadFileController uploadController = Get.put(UploadFileController());

  Rx<MessageModel?> replyMessage = Rx<MessageModel?>(null);
  Rx<GroupMessageModel?> replyGroupMessage = Rx<GroupMessageModel?>(null);

  final ScrollController _scrollController = ScrollController();
  final notificationService = Get.find<NotificationService>();


  ChatController({this.roomId, this.receiverId});

  @override
  void onInit() {
    super.onInit();
    if(roomId != null){
      fetchGroupMessages(roomId);
    }else{
      fetchMessage(receiverId);
    }
    _registerSocketListeners();
  }

  @override
  void onClose() {
    if (socketService.socket != null) {
      socketService.socket!.off("chat_message");
      socketService.socket?.off("group_message");
    }
    super.onClose();
  }

  void _registerSocketListeners() {
    socketService
      ..listenForUpdatedMessages(_onMessageUpdated)
      ..listenForDeletedMessages(_onMessageDeleted)
      ..listenToGroupMessageUpdate(_onGroupMessageUpdated)
      ..listenToGroupMessageDelete(_onGroupMessageDeleted)
      ..listenForSeenMessages(_onMessageSeen)
      ..listenForDeliveredMessages(_onMessageDelivered)
      ..listenForSeenGroupMessages(_onGroupMessageSeen)
      ..listenForDeliveredGroupMessages(_onGroupMessageDelivered)
      ..listenToReceivedMessages(receiveMessage)
      ..listenToNewMessages(newMessage)
      ..listenToGroupMessages(receiveGroupMessage);
    //  ..onReceiveNotification(_onReceiveNotification);
      // ..setupMessageListeners(
      // //   onNewMessage: (data) {
      // //   final msg = GroupMessageModel.fromJson(data);
      // //   groupMessages.insert(0, msg);
      // //   update();
      // // },
      //   onNotification: (data) {
      //   print('🔔 Notification received: $data');
      //
      //   final isGroup = data['isGroup'] ?? false;
      //   final senderId = data['senderId'];
      //   final message = data['message'];
      //   final createdAt = data['createdAt'];
      //
      //   // ✅ 1. Show toast
      //   // Fluttertoast.showToast(
      //   //   msg: isGroup
      //   //       ? "📢 Group Message from $senderId: $message"
      //   //       : "📩 Direct Message from $senderId: $message",
      //   //   toastLength: Toast.LENGTH_SHORT,
      //   //   gravity: ToastGravity.TOP,
      //   //   backgroundColor: const Color(0xFF323232),
      //   //   textColor: Colors.white,
      //   //   fontSize: 16.0,
      //   // );
      //
      //   // ✅ 2. Optionally show GetX Snackbar
      //   Get.snackbar(
      //     isGroup ? '📢 Group Message' : '📩 New Message',
      //     '$message',
      //     snackPosition: SnackPosition.TOP,
      //     duration: const Duration(seconds: 3),
      //     backgroundColor: Colors.black.withOpacity(0.8),
      //     colorText: Colors.white,
      //   );
      // },);
      // ..listenToGroupMessages((data) {
      //   receiveGroupMessage(Map<String, dynamic>.from(data));
      // });
  }


  void initSocket({required String userId,  String? roomId}) {

    socketService.connectSocket(userId);
    if(roomId != null){
      socketService.joinRoom(userId, roomId);
    }
    // socketService.joinRoom(userId, roomId!);

    // Listen for chat messages
    socketService.on('chat_message', (data) {
      print('📩 New message: $data');
     // messages.add(data);
      try {
        final message = MessageModel.fromJson(data);
        messages.add(message);
      } catch (e, stack) {
        print("❌ Failed to parse message: $e");
        print(stack);
      }
    });

    // Listen for notifications
    socketService.on('receiveNotification', (data) {
      print('🔔 Notification: $data');
     // notifications.add(Map<String, dynamic>.from(data));
      final notification = MessageModel.fromJson(data);
      final groupNotification = GroupMessageModel.fromJson(data);
      if(notification.roomId != null){
        handleMessageNotification(notification);
      }else{
        handleGroupMessageNotification(groupNotification);
      }
    });

    // Listen for delivery confirmations
    socketService.on('message_delivered', (data) {
      print('✅ Delivered: $data');
      if(roomId != null){
        _onGroupMessageDelivered(data);
      }else{
        _onMessageDelivered(data);
      }

    });

    // Optional
    socketService.on('joined_room', (data) {
      print('🚪 Joined room: $data');
    });
  }

  // void sendMessage(String messageText, {String? replyTo}) {
  //   final message = {
  //     'sender_id': Global.userId,
  //     'room_id': roomId,
  //     'message': messageText,
  //     if (replyTo != null) 'replyTo': replyTo,
  //   };
  //
  //   socketService.sendMessage(message);
  // }


  void setReplyToMessage(MessageModel message) {
    replyMessage.value = message;
  }

  void setReplyToGroupMessage(GroupMessageModel groupMessage) {
    replyGroupMessage.value = groupMessage;
  }

  void clearReplyToMessage() {
    replyMessage.value = null;
  }

  void clearReplyToGroupMessage() {
    replyGroupMessage.value = null;
  }

  void sendMessage(String receiverId, MessageType type) {
    if (messageText.value.isNotEmpty && socketService.socket != null) {
      final message = MessageModel(
        senderId: Global.userId!,
        receiverId: receiverId,
        message: messageText.value,
        attachmentId: [],
        messageType: type.toString().split('.').last,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        messageStatus: 'sent',
        replyTo: replyMessage.value,
        senderDetails: [UserDetails(
          id: Global.userId!,
          firstname: Global.userFirstname!,
          lastname: Global.userLastname!,
          email: Global.email!,
          // other fields if needed
        )],
        replyToDetails: replyMessage.value,
      );

      messages.insert(0, message); // insert at top since ListView is reversed
      _scrollToBottom();
      update(); // notify GetX

      socketService.sendMessage(message);


      //socketService.socket!.emit("chat_message", message.toJson());

      // socketService.socket?.emit("new_message", message.toJson());
      //
      // // 🔔 Emit Notification to Receiver
      // socketService.socket?.emit('receiveNotification', {
      //   'receiver_id': receiverId,
      //   'sender_id': Global.userId,
      //   'message': messageText.value,
      //   'message_type': type.toString().split('.').last,
      //   //'type': roomId != null ? 'group-message' : 'message',
      // });
     // messages.add(message);
      messageText.value = "";
      clearReplyToMessage();
    }
  }

  Future<void> uploadAndSendFile(String receiverId, {List<File>? file}) async {
    if (file == null || file.isEmpty) return;
    for (var files in file) {
      UploadFile? uploadedFile = await uploadController.uploadFile(files);
      if (uploadedFile != null && socketService.socket != null) {
        final message = MessageModel(
          senderId: Global.userId!,
          receiverId: receiverId,
          message: "",
          attachmentId: uploadedFile.id != null ? [uploadedFile.id!] : null,
          messageType: uploadedFile.fileType,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          messageStatus: 'sent',
          replyTo: replyMessage.value,
          senderDetails: [UserDetails(
            id: Global.userId!,
            firstname: Global.userFirstname!,
            lastname: Global.userLastname!,
            email: Global.email!,
          )],
          replyToDetails: replyMessage.value,
        );

        messages.insert(0, message);
        _scrollToBottom();
        update();

        socketService.sendMessage(message);
        clearReplyToMessage();

        // Map<String, dynamic> messageData = {
        //   "senderId": message.senderId,
        //   "receiverId": message.receiverId,
        //   "message": message.message,
        //   "attachmentId": message.attachmentId ?? "",
        //   "messageType": message.messageType,
        // };

      //  print("Sending message to socket: $messageData");

        // socketService.socket!.emit("chat_message", message.toJson());
        // socketService.socket?.emit("new_message", message.toJson());
        // messages.add(message);
      }
    }
  }

  void sendLocation(Position position, String receiverId,) {
    final message = MessageModel(
      senderId: Global.userId!,
      receiverId: receiverId,
      messageType: "location",
      latitude: position.latitude,
      longitude: position.longitude,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      messageStatus: 'sent',
      replyTo: replyMessage.value,
      senderDetails: [UserDetails(
        id: Global.userId!,
        firstname: Global.userFirstname!,
        lastname: Global.userLastname!,
        email: Global.email!,
      )],
      replyToDetails: replyMessage.value,
    );

    messages.insert(0, message);
    _scrollToBottom();
    update();

    socketService.sendMessage(message);
    clearReplyToMessage();

    // socketService.socket!.emit("chat_message", message.toJson());
    // socketService.socket?.emit("new_message", message.toJson());
    // messages.add(message);
  }

  void receiveMessage(Map<String, dynamic> data) {
    final newMessage = MessageModel.fromJson(data);
  //  messages.add(MessageModel.fromJson(data));
    messages.insert(0, newMessage); // Show instantly at top (because reverse: true)
    _scrollToBottom();
    update();
  }

  void newMessage(Map<String, dynamic> data) {
    final msg = GroupMessageModel.fromJson(data);
    groupMessages.insert(0, msg);
    update();
  }

  Future<void> fetchMessage(String? receiverId) async {
    String? token = await TokenStorage.getToken();
    final url = '${ApiConstants.GET_MESSAGE_LIST}?user_id=$receiverId';
    print('fetch message url : ${url}');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['body'] is List) {
          messages.value = (jsonData['body'] as List)
              .map((msg) => MessageModel.fromJson(msg))
              .toList();
        } else {
          List<dynamic> messageList = jsonData['body'];
          messages.value =
              messageList.map((msg) => MessageModel.fromJson(msg)).toList();
        }
        print('message value ==> ${messages.value}');
      } else {
        print("Failed to load messages: ${response.body}");
      }
    } catch (e) {
      print("Error fetching messages: $e");
    }
  }

  void _onMessageUpdated(Map data) {
    //  final jsonData = Map<String, dynamic>.from(data);
    final index = messages.indexWhere((m) => m.messageId == data['messageId']);
    if (index != -1) {
      //messages[index] = MessageModel.fromJson(jsonData);
      messages[index] = messages[index].copyWith(message: data['message'],);
      messages.refresh();
    }
  }

  void _onGroupMessageUpdated(Map data) {
    // final jsonData = Map<String, dynamic>.from(data);
    final index = groupMessages.indexWhere((m) => m.id == data['messageId']);
    if (index != -1) {
      // groupMessages[index] = GroupMessageModel.fromJson(jsonData);
      groupMessages[index] = groupMessages[index].copyWith(message: data['message'],);
      groupMessages.refresh();
    }
  }

  // void _onMessageDeleted(Map data) {
  //   final index = messages.indexWhere((m) => m.messageId == data['messageId']);
  //   if (index != -1) {
  //     messages.removeAt(index);
  //   }
  // }
  void _onMessageDeleted(Map data) {
    // final index = messages.indexWhere((m) => m.messageId == data['messageId']);
    // if (index != -1) {
    //   // final updated = messages[index].copyWith(isDeleted: true);
    //   // messages[index] = updated;
    //   messages.removeAt(index);
    // }
    messages.removeWhere((m) => m.messageId == data['messageId']);
  }

  void _onGroupMessageDeleted(Map data) {
    // final index = groupMessages.indexWhere((m) => m.id == data['messageId']);
    // if (index != -1) {
    //   // final updated = groupMessages[index].copyWith(isDeleted: true);
    //   // groupMessages[index] = updated;
    //   groupMessages.removeAt(index);
    // }
    groupMessages.removeWhere((m) => m.id == data['messageId']);
  }

  void _onMessageSeen(Map data) {
    final index = messages.indexWhere((msg) => msg.messageId == data['_id']);
    if (index != -1) {
      messages[index].messageStatus = data['message_status'];
      messages.refresh();
    }
  }

  void _onMessageDelivered(Map<String, dynamic> data) {
    final messageId = data['_id'];
    if (messageId == null) {
      print('⚠️ Warning: Received null messageId in delivered event');
      return;
    }
    final index = messages.indexWhere((msg) => msg.messageId == messageId);
    if (index != -1) {
      messages[index].messageStatus = data['message_status'] ?? messages[index].messageStatus;
      messages.refresh();
    }
  }

  void _onGroupMessageSeen(Map data) {
    final index = groupMessages.indexWhere((msg) => msg.id == data['_id']);
    if (index != -1) {
      groupMessages[index].messageStatus = data['message_status'];
      groupMessages.refresh();
    }
  }

  void _onGroupMessageDelivered(Map data) {
    final messageId = data['_id'];
    if (messageId == null) {
      print('⚠️ Warning: Received null messageId in delivered event');
      return;
    }
    final index = groupMessages.indexWhere((msg) => msg.id == messageId);
    if (index != -1) {
      groupMessages[index].messageStatus = data['message_status'];
      groupMessages.refresh();
    }
  }

  //
  // void _onGroupMessageDeleted(Map data) {
  //   final index = groupMessages.indexWhere((m) => m.id == data['messageId']);
  //   if (index != -1) {
  //     groupMessages.removeAt(index);
  //   }
  // }

  void updateMessage(String? messageId, String newText) {
    if (messageId != null) {
      socketService.updateMessage(messageId, newText);
     fetchMessage(receiverId);
    }
  }

  void deleteMessage(String? messageId) {
    if (messageId != null) socketService.deleteMessage(messageId);
  }

  void markMessageAsSeen(String messageId, String userId, bool isGroup) {
    socketService.emitMessageSeen(messageId, userId, isGroup);
  }

  // void _onMessageSeen(Map data) {
  //   String messageId = data['_id'];
  //   String status = data['message_status'];
  //
  //   int index = messages.indexWhere((msg) => msg.messageId == messageId);
  //   if (index != -1) {
  //     messages[index].messageStatus = status;
  //     update(); // or setState if using StatefulWidget
  //   }
  // }



  // Group Methods

  void sendGroupMessage(String roomId, MessageType type) {
    if (messageText.value.isNotEmpty && socketService.socket != null) {
      final groupMessage = GroupMessageModel(
        senderId: Global.userId!,
        roomId: roomId,
        message: messageText.value,
        attachmentId: [],
        messageType: type.toString().split('.').last,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        messageStatus: 'sent',
        isDeleted: false,
        status: 1,
        replyTo: replyGroupMessage.value,
        senderDetails: [UserDetails(
          id: Global.userId!,
          firstname: Global.userFirstname!,
          lastname: Global.userLastname!,
          email: Global.email!,
          // other fields if needed
        )],
        replyToDetails: replyGroupMessage.value,
      );

      groupMessages.insert(0, groupMessage);
      _scrollToBottom();
      update();

      socketService.sendGroupMessage(groupMessage);

      // socketService.socket!.emit("chat_message", groupMessage.toJson());
      // socketService.socket?.emit("new_message", groupMessage.toJson());
    //  groupMessages.add(groupMessage);

      // 🔔 Emit Notification to Receiver
      // socketService.socket?.emit('receiveNotification', {
      //   'receiver_ids': receiverId,
      //   'sender_id': Global.userId,
      //   'message': messageText.value,
      //   'message_type': type.toString().split('.').last,
      //   //'type': roomId != null ? 'group-message' : 'message',
      // });

      messageText.value = "";
      clearReplyToGroupMessage();
    }
  }

  Future<void> uploadAndSendGroupFile(String roomId, {List<File>? files}) async {
    if (files == null || files.isEmpty) return;
    for (var file in files) {
      UploadFile? uploadedFile = await uploadController.uploadFile(file);
      if (uploadedFile != null && socketService.socket != null) {
        final groupMessage = GroupMessageModel(
          senderId: Global.userId!,
          roomId: roomId,
          message: "",
          attachmentId: uploadedFile.id != null ? [uploadedFile.id!] : null,
          messageType: uploadedFile.fileType,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          messageStatus: 'sent',
          isDeleted: false,
          status: 1,
          replyTo: replyGroupMessage.value,
          senderDetails: [UserDetails(
            id: Global.userId!,
            firstname: Global.userFirstname!,
            lastname: Global.userLastname!,
            email: Global.email!,
            // other fields if needed
          )],
          replyToDetails: replyGroupMessage.value,
        );
        groupMessages.insert(0, groupMessage);
        _scrollToBottom();
        update();

        socketService.sendGroupMessage(groupMessage);
        clearReplyToGroupMessage();
        // socketService.socket!.emit("chat_message", groupMessage.toJson());
        // socketService.socket?.emit("new_message", groupMessage.toJson());
        // groupMessages.add(groupMessage);
      }
    }
  }

  void receiveGroupMessage(Map<String, dynamic> data) {
   // groupMessages.add(GroupMessageModel.fromJson(data));
    final newMessage = GroupMessageModel.fromJson(data);
    groupMessages.insert(0, newMessage); // Show instantly at top (because reverse: true)
    _scrollToBottom();
    update();
  }

  void sendGroupLocation(Position position, String roomId,) {
    final groupMessage = GroupMessageModel(
      senderId: Global.userId!,
      roomId: roomId,
      messageType: "location",
      latitude: position.latitude,
      longitude: position.longitude,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      messageStatus: 'sent',
      replyTo: replyGroupMessage.value,
      senderDetails: [UserDetails(
        id: Global.userId!,
        firstname: Global.userFirstname!,
        lastname: Global.userLastname!,
        email: Global.email!,
        // other fields if needed
      )],
      replyToDetails: replyGroupMessage.value,
    );

    groupMessages.insert(0, groupMessage);
    _scrollToBottom();
    update();

    socketService.sendGroupMessage(groupMessage);
    clearReplyToGroupMessage();
    // socketService.socket!.emit("chat_message", message.toJson());
    // socketService.socket?.emit("new_message", message.toJson());
    // groupMessages.add(message);
  }

  Future<void> fetchGroupMessages(String? roomId) async {
    String? token = await TokenStorage.getToken();
    final url = '${ApiConstants.GET_GROUP_MESSAGE_LIST}?room_id=$roomId';
    print('fetch group message url ==> ${url}');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['body'] is List) {
          groupMessages.value =
              GroupMessageModel.fromJsonList(jsonData['body']);
        }
      }
      // if (response.statusCode == 200) {
      //   final List<dynamic> jsonData = json.decode(response.body)['body'];
      //   groupMessages.assignAll(
      //       jsonData.map((e) => GroupMessageModel.fromJson(e)).toList());
      // }
      else {
        print("Failed to load group messages: ${response.body}");
      }
    } catch (e) {
      print("Error fetching group messages: $e");
    }
  }

  void updateGroupMessage(String? messageId, String newText) {
    socketService.updateGroupMessage(messageId!, roomId ?? '', newText);
    fetchGroupMessages(roomId);
  }

  void deleteGroupMessage(String? messageId) {
    socketService.deleteGroupMessage(messageId!);
  }

  void joinGroup(String userId, String roomId) {
    socketService.joinRoom(userId, roomId);
  }

  void leaveGroup(String userId, String roomId) {
    socketService.leaveRoom(userId, roomId);
  }

  // void _onReceiveNotification(dynamic data) {
  //   print("🔔 Notification received in controller: $data");
  //   final String sender = data['senderId']?.toString() ?? 'Someone';
  //   final String message = data['message'] ?? 'New message';
  //   final isGroup = data['isGroup'] ?? false;
  //   final attachmentData = data['attachmentData'];
  //   // final location = data['location'];
  //   //
  //   // NotificationService().showNotification(
  //   //   title: data['senderId'] != null ? 'New Message' : 'New Group Message',
  //   //   body: "$sender: $message",
  //   // );
  //
  //   // Example: you can update UI, show a local toast, badge, etc.
  //   if (data['type'] == 'message') {
  //     // Handle direct message notification
  //   } else if (data['type'] == 'group-message') {
  //     // Handle group message notification
  //   }
  // }

  Future<void> _scrollToBottom() async {
    await Future.delayed(Duration(milliseconds: 100));
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0, // because reverse: true
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }


  void handleMessageNotification(MessageModel notification){
    messages.add(notification);

    if(notification.messageType == 'image'){
      notificationService.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: 'New Image Message',
        body: notification.message ?? 'You received an image!',
        imageUrl: notification.attachmentDetails?.first.url, // Pass the URL of the image
      );
    }
    else if(notification.messageType == 'document'){
      notificationService.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: 'New Document',
        body: 'You received a document: ${notification.attachmentDetails?.first.name}',
      );
    }
    else if (notification.messageType == 'video') {
      notificationService.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: 'New Video',
        body: 'Video',
      );
    }
    else if (notification.messageType == 'audio') {
      notificationService.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: 'New Audio',
        body: 'Video',
      );
    }
    else if (notification.messageType == 'location') {
      notificationService.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: 'New Location',
        body: 'Location',
      );
    }else {
      notificationService.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: 'New Message',
        body: notification.message ?? '',
      );
    }

  }

  void handleGroupMessageNotification(GroupMessageModel notification){
    groupMessages.add(notification);
    notificationService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: '📢 Group Message',
      body: notification.message ?? '',
    );
    // Get.snackbar(
    //   '📢 Group Message',
    //   '${notification.message}',
    //   snackPosition: SnackPosition.TOP,
    //   duration: const Duration(seconds: 3),
    //   backgroundColor: Colors.black.withOpacity(0.8),
    //   colorText: Colors.white,
    // );
  }

}

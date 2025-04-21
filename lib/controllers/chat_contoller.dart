import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/upload_file_controller.dart';
import 'package:orbitwork/global/global.dart';
import 'package:orbitwork/repository/api/api_constants.dart';
import '../comms/enum/message.dart';
import '../global/tokenStorage.dart';
import '../models/chat_item_model.dart';
import '../models/group_message_model.dart';
import '../models/message_model.dart';
import '../models/upload_file_model.dart';
import '../socket/socket_service/socket_service.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  final String? receiverId;
  final String? roomId;
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final RxList<GroupMessageModel> groupMessages = <GroupMessageModel>[].obs;
  final RxString messageText = ''.obs;

  final SocketService socketService = Get.put(SocketService());
  final UploadFileController uploadController = Get.put(UploadFileController());

  Rx<MessageModel?> replyMessage = Rx<MessageModel?>(null);


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
      ..listenToGroupMessages(receiveGroupMessage);
      // ..listenToGroupMessages((data) {
      //   receiveGroupMessage(Map<String, dynamic>.from(data));
      // });
  }

  void setReplyTo(MessageModel message) {
    replyMessage.value = message;
  }

  void clearReplyTo() {
    replyMessage.value = null;
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
        replyTo: replyMessage.value
      );
      socketService.socket!.emit("chat_message", message.toJson());
      socketService.socket?.emit("new_message", message.toJson());
      messages.add(message);
      messageText.value = "";
      clearReplyTo();
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
        );

        Map<String, dynamic> messageData = {
          "senderId": message.senderId,
          "receiverId": message.receiverId,
          "message": message.message,
          "attachmentId": message.attachmentId ?? "",
          "messageType": message.messageType,
        };

        print("Sending message to socket: $messageData");

        socketService.socket!.emit("chat_message", message.toJson());
        socketService.socket?.emit("new_message", message.toJson());
        messages.add(message);
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
    );
    socketService.socket!.emit("chat_message", message.toJson());
    socketService.socket?.emit("new_message", message.toJson());
    messages.add(message);
  }

  void receiveMessage(Map<String, dynamic> data) {
    messages.add(MessageModel.fromJson(data));
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

  void _onMessageDelivered(Map data) {
    final index = messages.indexWhere((msg) => msg.messageId == data['_id']);
    if (index != -1) {
      messages[index].messageStatus = data['message_status'];
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
    final index = groupMessages.indexWhere((msg) => msg.id == data['_id']);
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
      );

      socketService.socket!.emit("chat_message", groupMessage.toJson());
      socketService.socket?.emit("new_message", groupMessage.toJson());
      groupMessages.add(groupMessage);
      messageText.value = "";
    }
  }

  Future<void> uploadAndSendGroupFile(String roomId, List<File> files) async {
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
        );

        socketService.socket!.emit("chat_message", groupMessage.toJson());
        socketService.socket?.emit("new_message", groupMessage.toJson());
        groupMessages.add(groupMessage);
      }
    }
  }

  void receiveGroupMessage(Map<String, dynamic> data) {
    groupMessages.add(GroupMessageModel.fromJson(data));
  }

  void sendGroupLocation(Position position, String roomId,) {
    final message = GroupMessageModel(
      senderId: Global.userId!,
      roomId: roomId,
      messageType: "location",
      latitude: position.latitude,
      longitude: position.longitude,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      messageStatus: 'sent',
    );

    socketService.socket!.emit("chat_message", message.toJson());
    socketService.socket?.emit("new_message", message.toJson());
    groupMessages.add(message);
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

  void setReplyMessage(MessageModel message){
    replyMessage.value = message;
  }

  void clearReplyMessage(){
    replyMessage.value = null;
  }
}

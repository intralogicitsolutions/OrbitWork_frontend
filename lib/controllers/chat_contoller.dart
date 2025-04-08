import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orbitwork/controllers/upload_file_controller.dart';
import 'package:orbitwork/global/global.dart';
import 'package:orbitwork/repository/api/api_constants.dart';
import '../comms/enum/message.dart';
import '../global/tokenStorage.dart';
import '../models/message_model.dart';
import '../models/chat_user_model.dart';
import '../models/upload_file_model.dart';
import '../socket/socket_service/socket_service.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  //var messages = <Map<String, dynamic>>[].obs;
  var messages = <MessageModel>[].obs;
  var messageText = ''.obs;
  final String receiverId;
  final socketService = Get.put(SocketService());
  final uploadController = Get.put(UploadFileController());

  ChatController({required this.receiverId});

  void sendMessage(String receiverId, MessageType type) {
    if (messageText.value.isNotEmpty  && socketService.socket != null) {
      final message = MessageModel(
        senderId: Global.userId!,
        receiverId: receiverId,
        message: messageText.value,
        attachmentId: [],
        messageType: type.toString().split('.').last,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        messageStatus: 'sent',
      );

      // Pass individual properties, not a JSON object
      socketService.socket!.emit("chat_message", message.toJson());
      messages.add(message);
      messageText.value = "";
    }
  }


 Future<void> uploadAndSendFile(String receiverId, {List<File>? file,Location? location})  async {
   if (file == null || file.isEmpty) return;
   for (var files in file) {
     UploadFile? uploadedFile = await uploadController.uploadFile(files);
     print('uploadFile ==> ${uploadedFile}');
     if (uploadedFile != null && socketService.socket != null) {
       final message = MessageModel(
         senderId: Global.userId!,
         receiverId: receiverId,
         message: "",
         attachmentId: uploadedFile.id != null ? [uploadedFile.id!] : null,
         // messageType: messageType.toString().split('.').last,
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
       messages.add(message);
     }
   }
 }

  void sendLocation(Position position, String receiverId,) {
   // final locationMessage = "Location: ${position.latitude}, ${position.longitude}";
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
    messages.add(message);
   // sendMessage(receiverId, MessageType.location);
  }

  void receiveMessage(Map<String, dynamic> data) {
    messages.add(MessageModel.fromJson(data));
  }

  Future<void> fetchMessage(String receiverId) async {
    String? token = await TokenStorage.getToken();
    try{
      final response = await http.get(
        Uri.parse("${ApiConstants.GET_MESSAGE_LIST}?user_id=$receiverId"),
        headers: {
          'Authorization': '$token',
          'Content-Type': 'application/json'
        },
      );

      print('url ==> ${ApiConstants.GET_MESSAGE_LIST}?user_id=${Global.userId}');
      print('statuscode ==> ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData['body'] is List) {
          messages.value = (jsonData['body'] as List)
              .map((msg) => MessageModel.fromJson(msg))
              .toList();
        } else {
          List<dynamic> messageList = jsonData['body'];
          messages.value = messageList.map((msg) => MessageModel.fromJson(msg)).toList();
        }
        print('message value ==> ${messages.value}');
      } else {
        print("Failed to load messages: ${response.body}");
      }
    }catch (e) {
      print("Error fetching messages: $e");
    }
  }

  void _onMessageUpdated(Map data) {
    final jsonData = Map<String, dynamic>.from(data);
    final index = messages.indexWhere((m) => m.messageId == data['messageId']);
    if (index != -1) {
      messages[index] = MessageModel.fromJson(jsonData);
    }
  }

  void _onMessageDeleted(Map data) {
    final index = messages.indexWhere((m) => m.messageId == data['messageId']);
    if (index != -1) {
      messages.removeAt(index);
    }
  }

  void updateMessage(String? messageId, String newText) {
    socketService.updateMessage(messageId!, newText);
  }

  void deleteMessage(String? messageId, String userId, {bool deleteForEveryone = false}) {
    socketService.deleteMessage(messageId!, userId, deleteForEveryone: deleteForEveryone);
  }

  void _onMessageSeen(Map data) {
    String messageId = data['messageId'];
    String status = data['message_status'];

    int index = messages.indexWhere((msg) => msg.messageId == messageId);
    if (index != -1) {
      messages[index].messageStatus = status;
      update(); // or setState if using StatefulWidget
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchMessage(receiverId);
    socketService.listenForUpdatedMessages(_onMessageUpdated);
    socketService.listenForDeletedMessages(_onMessageDeleted);
    if (socketService.socket != null) {
      socketService.socket!.on("chat_message", (data) {
        print("Received message: $data");
        receiveMessage(data);
      });
    }
    socketService.listenForSeenMessages(_onMessageSeen);
  }

  @override
  void onClose() {
    if (socketService.socket != null) {
      socketService.socket!.off("chat_message"); // Remove listener when controller is disposed
    }
    super.onClose();
  }
}

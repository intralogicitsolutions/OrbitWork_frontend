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

class ChatsController extends GetxController {
  final messages = <Message>[].obs;
  var messageText = ''.obs;
  var selectedFilePath = ''.obs;
  // final currentUser = Rxn<ChatUser>();
  // final otherUser = Rxn<ChatUser>();
  final currentUser = Rxn<ChatUser>(ChatUser(id: "1", name: "Me", ));
  final otherUser = Rxn<ChatUser>(ChatUser(id: "2", name: "John", ));


  void sendMessage(String content) {
    if (content.trim().isEmpty) return;

    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: currentUser.value!.id,
      receiverId: otherUser.value!.id,
      content: content,
      timestamp: DateTime.now(),
    );
    messages.add(message);
  }

  void sendImage(String imagePath) {
    // Logic to send an image
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: currentUser.value!.id,
      receiverId: otherUser.value!.id,
      content: "",
      timestamp: DateTime.now(),
      imagePath: imagePath,
    );
    messages.add(message);
    print("Sending image from path: $imagePath");
  }

  void sendFile(String filePath) {
    // Logic to send a file
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: currentUser.value!.id,
      receiverId: otherUser.value!.id,
      content: "",
      timestamp: DateTime.now(),
      filePath: filePath,
    );
    messages.add(message);
    print("Sending file from path: $filePath");
  }

  void sendLocation(double latitude, double longitude) {
    // Logic to send location
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: currentUser.value!.id,
      receiverId: otherUser.value!.id,
      content: "",
      timestamp: DateTime.now(),
      latitude: latitude,
      longitude: longitude,

    );
    messages.add(message);
    print("Sending location: ($latitude, $longitude)");
  }
  void updateMessageText(String text) {
    messageText.value = text;
  }

  void loadMessages(String chatId) {
    // TODO: Implement API call to load messages
    // This is a mock implementation
    messages.value = [
      Message(
        id: '1',
        senderId: currentUser.value!.id,
        receiverId: otherUser.value!.id,
        content: 'Hello!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      // Add more mock messages as needed
    ];
  }
}



/// for chat socket io call ///



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
      );

      // Pass individual properties, not a JSON object
      socketService.socket!.emit("chat_message", message.toJson());
      // socketService.sendMessage(
      //   senderId: message.senderId,
      //   receiverId: message.receiverId,
      //   message: message.message,
      //  attachmentId: message.attachmentId ?? "",
      //   messageType: message.messageType,
      // );


      // Convert `MessageModel` to JSON before adding to `messages`
      messages.add(message);
      messageText.value = "";
    }
  }

  // Future<void> uploadAndSendFile(File file, String receiverId, MessageType messageType) async {
  //   String? fileBase64;
  //   String? fileName = file.path.split('/').last;
  //   String? fileType = fileName.split('.').last;
  //
  //   try {
  //     // Read the file as bytes and encode it to Base64
  //     List<int> fileBytes = await file.readAsBytes();
  //     fileBase64 = base64Encode(fileBytes);
  //   } catch (e) {
  //     print("Error encoding file: $e");
  //     return;
  //   }
  //
  //   // Construct the message model with actual file data
  //   final message = {
  //     "senderId": Global.userId!,
  //     "receiverId": receiverId,
  //     "message": "",
  //     "fileName": fileName,
  //     "fileType": fileType,
  //    // "fileData": fileBase64,  // Base64 encoded file
  //     "messageType": messageType.toString().split('.').last, // Adjust based on actual type
  //     "createdAt": DateTime.now().toIso8601String(),
  //     "updatedAt": DateTime.now().toIso8601String(),
  //   };
  //
  //   print("Sending message to socket: $message");
  //
  //   // Send the message to the socket
  //   socketService.sendMessage(message);
  //   messages.add(MessageModel.fromJson(message));
  //
  //   // Add the message to the UI
  // //  messages.add(message);
  // }


  // Future<void> uploadAndSendFile(File file, String receiverId, MessageType messageType) async {
  //   String fileName = file.path.split('/').last;
  //   String fileType = fileName.split('.').last;
  //
  //   // Convert file to Base64
  //   List<int> fileBytes = await file.readAsBytes();
  //   String fileBase64 = base64Encode(fileBytes);
  //   String base64Image = await convertFileToBase64(file);
  //
  //   // Construct the message payload
  //   final messageData = {
  //     "sender_id": Global.userId!,
  //     "receiver_id": receiverId,
  //     "message": "Check this image",  // Message text
  //     "files": "data:image/$fileType;base64,$base64Image", // Base64 file
  //     "message_type": messageType.toString().split('.').last
  //   };
  //
  //   print("Sending message to socket: $messageData");
  //
  //   socketService.socket!.emit('chat_message', messageData);
  //
  //   // Emit the message over WebSocket
  //   messages.add(MessageModel.fromJson(messageData));
  //   //socket!.emit('chat_message', messageData);
  // }

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
       );

       Map<String, dynamic> messageData = {
         "senderId": message.senderId,
         "receiverId": message.receiverId,
         "message": message.message,
         "attachmentId": message.attachmentId ?? "",
         "messageType": message.messageType,
       };

       print("Sending message to socket: $messageData");

       // socketService.sendMessage(
       //   senderId: message.senderId,
       //   receiverId: message.receiverId,
       //   message: message.message,
       //   attachmentId: message.attachmentId ?? "",
       //   messageType: message.messageType,
       // );
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
    );
    socketService.socket!.emit("chat_message", message.toJson());
    messages.add(message);
   // sendMessage(receiverId, MessageType.location);
  }

  void receiveMessage(Map<String, dynamic> data) {
    messages.add(MessageModel.fromJson(data));
  }

  Future<void> fetchMessage(String receiverId) async{
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
         // print("Unexpected response format: ${jsonData['body']}");
          List<dynamic> messageList = jsonData['body'];
          messages.value = messageList.map((msg) => MessageModel.fromJson(msg)).toList();
        }
        // List<dynamic> messageList = jsonData['body'];
        //
        // messages.value = messageList.map((msg) => MessageModel.fromJson(msg)).toList();

        print('message value ==> ${messages.value}');
      } else {
        print("Failed to load messages: ${response.body}");
      }
    }catch (e) {
      print("Error fetching messages: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchMessage(receiverId);
    if (socketService.socket != null) {
      socketService.socket!.on("chat_message", (data) {
        print("Received message: $data");
        receiveMessage(data);
      });
    }
    // socketService.socket!.on("chat_message", (data) {
    //   print("Received message: $data");
    //   messages.add(MessageModel.fromJson(data));
    // });
  }

  @override
  void onClose() {
    if (socketService.socket != null) {
      socketService.socket!.off("chat_message"); // Remove listener when controller is disposed
    }
    super.onClose();
  }
}

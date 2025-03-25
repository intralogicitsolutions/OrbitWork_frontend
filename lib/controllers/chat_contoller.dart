import 'dart:convert';

import 'package:get/get.dart';
import 'package:orbitwork/global/global.dart';
import 'package:orbitwork/repository/api/api_constants.dart';
import '../global/tokenStorage.dart';
import '../models/message_model.dart';
import '../models/chat_user_model.dart';
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

  ChatController({required this.receiverId});

  void sendMessage(String receiverId) {
    if (messageText.value.isNotEmpty) {
      final message = MessageModel(
        senderId: Global.userId!,
        receiverId: receiverId,
        message: messageText.value,
        attachmentId: "",
        messageType: "text",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Pass individual properties, not a JSON object
      socketService.sendMessage(
        senderId: message.senderId,
        receiverId: message.receiverId,
        message: message.message,
        attachmentId: message.attachmentId ?? "",
        messageType: message.messageType ?? "text",
      );


      // Convert `MessageModel` to JSON before adding to `messages`
      messages.add(message);

      messageText.value = "";
    }
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
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        List<dynamic> messageList = jsonData['body'];

        messages.value = messageList.map((msg) => MessageModel.fromJson(msg)).toList();

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
    socketService.socket.on("chat_message", (data) {
      messages.add(data);
    });
  }
}

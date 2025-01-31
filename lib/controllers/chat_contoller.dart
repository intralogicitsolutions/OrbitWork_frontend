import 'package:get/get.dart';
import '../models/message_model.dart';
import '../models/chat_user_model.dart';

class ChatController extends GetxController {
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

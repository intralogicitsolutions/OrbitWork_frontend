import 'package:get/get.dart';
import '../models/message_model.dart';

class MessageController extends GetxController {
  var messages = <MessageModel>[].obs;
  var filteredMessages = <MessageModel>[].obs;
  var searchQuery = ''.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
  }

  void fetchMessages() async{
    await Future.delayed(Duration(seconds: 2));
    messages.value = [
      MessageModel(
        name: "Quentin Leopold, kfzBlitz24 GmbH",
        title: "Flutter App Developer",
        lastMessage: "You: Quentin Leopold",
        date: "12/27/24",
      ),
      MessageModel(
        name: "John Doe",
        title: "React Developer",
        lastMessage: "You: Thanks for the update!",
        date: "12/26/24",
      ),
      // Add more messages...
    ];
    isLoading.value = false;
    filteredMessages.value = messages;
  }

  void filterMessages(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredMessages.value = messages;
    } else {
      filteredMessages.value = messages
          .where((message) =>
      message.name.toLowerCase().contains(query.toLowerCase()) ||
          message.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../component/chat/chat_input_field.dart';
import '../component/chat/chat_message_bubble.dart';
import '../controllers/chat_contoller.dart';
import '../models/message_model.dart';

class ChatPage extends StatelessWidget {
  final String name;
  final ChatController chatController = Get.put(ChatController());

  ChatPage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              Map<String, List<Message>> groupedMessages = {};
              for (var msg in chatController.messages) {
                String date = "${msg.timestamp.day}/${msg.timestamp.month}/${msg.timestamp.year}";
                groupedMessages[date] ??= [];
                groupedMessages[date]!.add(msg);
              }

              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: groupedMessages.keys.length,
                itemBuilder: (context, index) {
                  String date = groupedMessages.keys.elementAt(index);
                  List<Message> messages = groupedMessages[date]!;

                  final message = messages[index];
                  final previousMessage = index > 0 ? messages[index - 1] : null;

                  bool showDateSeparator = previousMessage == null ||
                      !isSameDate(previousMessage.timestamp, message.timestamp);

                  return Column(
                    children: [
                      if (showDateSeparator) chatDateSeparator(message.timestamp),
                      ChatBubble(
                        message: "Hello! How are you?",
                        isSentByMe: false,
                        time: DateTime.now().subtract(Duration(minutes: 10)),
                      ),
                      ChatBubble(
                        message: "I'm good! What about you?",
                        isSentByMe: true,
                        time: DateTime.now().subtract(Duration(days: 1)),
                      ),
                      ChatBubble(
                        message: "I'm doing well, just working on my project.",
                        isSentByMe: false,
                        time: DateTime.now().subtract(Duration(days: 3)),
                      ),
                      ChatBubble(
                        message: "That sounds great!",
                        isSentByMe: true,
                        time: DateTime.now().subtract(Duration(days: 8)),
                      ),
                      ...messages.map((msg) => ChatBubble(
                        message: msg.content,
                        isSentByMe: msg.senderId == chatController.currentUser.value?.id,
                        time: msg.timestamp,
                        imagePath: msg.imagePath,
                        filePath: msg.filePath,
                        latitude: msg.latitude,
                        longitude: msg.longitude,
                        id: msg.id,
                        //time: "${msg.timestamp.hour}:${msg.timestamp.minute}",
                      )),
                    ],
                  );
                },
              );
            }),
          ),
          ChatInputField(),
        ],
      ),
    );
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return DateFormat('yyyy-MM-dd').format(date1) == DateFormat('yyyy-MM-dd').format(date2);
  }

  /// **Function to generate date separator like WhatsApp**
  Widget chatDateSeparator(DateTime dateTime) {
    String formattedDate = _formatDate(dateTime);
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1, endIndent: 8)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration( borderRadius: BorderRadius.circular(8)),
          child: Text(formattedDate, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey.shade700)),
        ),
        Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1, indent: 8)),
      ],
    );
  }

  /// **Formats date to show 'Today', 'Yesterday', or exact date**
  String _formatDate(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));

    if (DateFormat('yyyy-MM-dd').format(dateTime) == DateFormat('yyyy-MM-dd').format(now)) {
      return "Today";
    } else if (DateFormat('yyyy-MM-dd').format(dateTime) == DateFormat('yyyy-MM-dd').format(yesterday)) {
      return "Yesterday";
    } else if (now.difference(dateTime).inDays < 7) {
      return DateFormat('EEEE').format(dateTime); // Day name
    } else {
      return DateFormat('d MMM yyyy').format(dateTime); // Full date
    }
  }
}


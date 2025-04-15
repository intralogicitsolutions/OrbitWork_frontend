import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../component/chat/chat_input_field.dart';
import '../component/chat/chat_message_bubble.dart';
import '../controllers/chat_contoller.dart';
import '../global/global.dart';
import '../routes/app_routes.dart';

class GroupChatPage extends StatelessWidget {
  final String name;
  final String? roomId;

  final ChatController chatController;
  final ScrollController _scrollController = ScrollController();

  GroupChatPage({Key? key, required this.name, this.roomId})
      : chatController = Get.put(ChatController(roomId: roomId)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          PopupMenuButton<String>(
            color: Get.theme.scaffoldBackgroundColor,
            onSelected: (value) {
              if (value == 'edit') {
                // Handle edit action
                print("Edit clicked");
              }
              // else if (value == 'add') {
              //   // Handle add action
              //   print("Add clicked");
              // }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit'),
                  onTap: () {
                    Get.toNamed(AppRoutes.groupEdit, arguments: {
                      'roomId': roomId,
                    });
                  },
                ),
                // // if (chatController.isAdmin.value)
                //   PopupMenuItem<String>(
                //     value: 'add',
                //     child: Text('Add'),
                //   ),
              ];
            },
          ),
        ],

      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                controller: _scrollController,
                reverse: true,
                itemCount: chatController.groupMessages.length,
                itemBuilder: (context, index) {
                  var message = chatController.groupMessages[index];
                  bool isMe = message.senderId == Global.userId;

                  DateTime messageDate = message.createdAt;
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(messageDate);

                  bool showDateHeader =
                      index == chatController.groupMessages.length - 1 ||
                          DateFormat('dd-MM-yyyy').format(chatController
                                  .groupMessages[index + 1].createdAt) !=
                              formattedDate;
                  return Column(
                    children: [
                      if (showDateHeader)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      ChatBubble(groupMessage: message, isMe: isMe),
                    ],
                  );
                },
              );
            }),
          ),
          ChatInputField(
            roomId: roomId,
          ),
        ],
      ),
    );
  }
}

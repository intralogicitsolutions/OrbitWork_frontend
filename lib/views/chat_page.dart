import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../component/chat/chat_input_field.dart';
import '../component/chat/chat_message_bubble.dart';
import '../controllers/chat_contoller.dart';
import '../global/global.dart';
import '../socket/socket_service/socket_service.dart';

class ChatPage extends StatefulWidget {
  final String name;
  final String? receiverId;

  //final ChatController chatController = Get.put(ChatController());
  final ChatController chatController;

  ChatPage({Key? key, this.receiverId, required this.name,})
      : chatController = Get.put(ChatController(receiverId: receiverId)),
        super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatController chatController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    chatController = Get.put(ChatController(receiverId: widget.receiverId));

    // Emit user_online when entering the chat
    final socketService = Get.find<SocketService>();
    socketService.emitUserOnline(Global.userId??'');
  }

  @override
  void dispose() {
    // Emit user_left_message_page when leaving the chat
    final socketService = Get.find<SocketService>();
    socketService.emitUserLeftMessagePage(Global.userId??'');
   // socketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                controller: _scrollController,
                  reverse: true,
                  itemCount: widget.chatController.messages.length,
                  itemBuilder: (context, index) {
                    var message = widget.chatController.messages[index];
                    bool isMe = message.senderId == Global.userId;

                    DateTime messageDate = message.createdAt;
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(messageDate);

                    bool showDateHeader = index ==
                            widget.chatController.messages.length - 1 ||
                        DateFormat('dd-MM-yyyy').format(
                                widget.chatController.messages[index + 1].createdAt) !=
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
                        ChatBubble(message: message, isMe: isMe),
                      ],
                    );
                  },
                );}),
          ),
          ChatInputField(
            receiverId: widget.receiverId??'',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../comms/zoom_meeting_creation.dart';
import '../component/chat/chat_input_field.dart';
import '../component/chat/chat_message_bubble.dart';
import '../controllers/chat_contoller.dart';
import '../global/global.dart';
import '../routes/app_routes.dart';

class GroupChatPage extends StatefulWidget {
  final String name;
  final String? roomId;

  final ChatController chatController;

  GroupChatPage({Key? key, required this.name, this.roomId})
      : chatController = Get.put(ChatController(roomId: roomId)),
        super(key: key);

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
   ChatController? chatController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    chatController?.initSocket(userId: Global.userId ?? '', roomId: widget.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          PopupMenuButton<String>(
            color: Get.theme.scaffoldBackgroundColor,
            onSelected: (value) {
              if (value == 'edit') {
                print("Edit clicked");
              }
            },
            icon: Icon(Icons.call),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icon/zoom.png',
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(width: 10,),
                      Text('Zoom Meeting')
                    ],
                  ),
                  onTap: () async{
                    await Future.delayed(Duration(milliseconds: 200)); // fixes onTap delay issue
                    //_handleZoomMeetingCreation();
                    ZoomMeetingHelper.handleZoomMeetingCreation(
                      context: context,
                      chatController: chatController,
                    );
                  },
                ),
              ];
            },
          ),
          PopupMenuButton<String>(
            color: Get.theme.scaffoldBackgroundColor,
            onSelected: (value) {
              if (value == 'edit') {
                print("Edit clicked");
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit'),
                  onTap: () {
                    Get.toNamed(AppRoutes.groupEdit, arguments: {
                      'roomId': widget.roomId,
                    });
                  },
                ),
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
                itemCount: widget.chatController.groupMessages.length,
                itemBuilder: (context, index) {
                  var message = widget.chatController.groupMessages[index];
                  bool isMe = message.senderId == Global.userId;

                  DateTime messageDate = message.createdAt;
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(messageDate);

                  bool showDateHeader =
                      index == widget.chatController.groupMessages.length - 1 ||
                          DateFormat('dd-MM-yyyy').format(widget.chatController
                                  .groupMessages[index + 1].createdAt) !=
                              formattedDate;

                  bool showSenderName = index == widget.chatController.groupMessages.length - 1 ||
                      widget.chatController.groupMessages[index + 1].senderId != message.senderId ||
                      DateFormat('dd-MM-yyyy').format(widget.chatController.groupMessages[index + 1].createdAt) != formattedDate ||
                      (widget.chatController.groupMessages[index + 1].createdAt.isBefore(message.createdAt.add(Duration(minutes: -3))));

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
                      ChatBubble(groupMessage: message, isMe: isMe, showSenderName: showSenderName,),
                    ],
                  );
                },
              );
            }),
          ),
          ChatInputField(
            roomId: widget.roomId,
          ),
        ],
      ),
    );
  }
}

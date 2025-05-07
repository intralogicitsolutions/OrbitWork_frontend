import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../comms/zoom_meeting_creation.dart';
import '../component/chat/chat_input_field.dart';
import '../component/chat/chat_message_bubble.dart';
import '../controllers/chat_contoller.dart';
import '../global/global.dart';
import '../socket/socket_service/socket_service.dart';

class ChatPage extends StatefulWidget {
  final String name;
  final String? receiverId;

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
   // chatController.initSocket(userId: Global.userId ?? '');
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
          )
        ],
      ),
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


                    bool showSenderName = index == widget.chatController.messages.length - 1 ||
                        widget.chatController.messages[index + 1].senderId != message.senderId ||
                         DateFormat('dd-MM-yyyy').format(widget.chatController.messages[index + 1].createdAt) != formattedDate ||
                        (widget.chatController.messages[index + 1].createdAt.isBefore(message.createdAt.add(Duration(minutes: -3))));                        // widget.chatController.messages[index + 1].createdAt.difference(message.createdAt).inMinutes >= 3;

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
                        ChatBubble(message: message, isMe: isMe,showSenderName: showSenderName, ),
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

  // void _handleZoomMeetingCreation() async {
  //   final DateTime? selectedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2100),
  //   );
  //
  //   if (selectedDate == null) return;
  //
  //   final TimeOfDay? selectedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //
  //   if (selectedTime == null) return;
  //
  //   final DateTime combinedDateTime = DateTime(
  //     selectedDate.year,
  //     selectedDate.month,
  //     selectedDate.day,
  //     selectedTime.hour,
  //     selectedTime.minute,
  //   );
  //
  //  // final String isoString = combinedDateTime.toUtc().toIso8601String();
  //
  //   try {
  //     final joinUrl = await chatController.createZoomMeetingAPI(combinedDateTime);
  //     print('joinUrl ==> ${joinUrl}');
  //     if (joinUrl != null) {
  //       chatController.textController.text = joinUrl;
  //       chatController.messageText.value = joinUrl;
  //     // chatController.sendMessage(widget.receiverId ?? '', joinUrl); // call your ChatInputField logic
  //     } else {
  //       Get.snackbar('Error', 'Failed to create Zoom meeting');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed: $e');
  //   }
  // }

}

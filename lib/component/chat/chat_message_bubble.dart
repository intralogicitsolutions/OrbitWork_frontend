// import 'package:flutter/material.dart';
// import '../../controllers/chat_contoller.dart';
// import '../../models/message_model.dart';
// import 'package:get/get.dart';
//
//
// class ChatMessageBubble extends StatelessWidget {
//   final Message message;
//   final ChatController controller = Get.find();
//
//   ChatMessageBubble({
//     Key? key,
//     required this.message,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final isMe = message.senderId == controller.currentUser.value?.id;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment:
//         isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: [
//           Container(
//             constraints: BoxConstraints(
//               maxWidth: MediaQuery.of(context).size.width * 0.7,
//             ),
//             padding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 10,
//             ),
//             decoration: BoxDecoration(
//               color: isMe ? Colors.blue : Colors.grey[200],
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Text(
//               message.content,
//               style: TextStyle(
//                 color: isMe ? Colors.white : Colors.black,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:orbitwork/component/chat/pdf_view_page.dart';
import 'package:orbitwork/component/chat/video_bubble.dart';
import 'package:orbitwork/models/group_message_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../comms/global/string_utils.dart';
import '../../controllers/chat_contoller.dart';
import '../../global/global.dart';
import '../../models/message_model.dart';
import 'audio_player.dart';
import 'full_screeen_video.dart';
import 'full_screen_image.dart';

///use chat_bubble library  for chat ui
class ChatBubble extends StatefulWidget {
  final MessageModel? message;
  final bool isMe;
  final GroupMessageModel? groupMessage;

  ChatBubble({this.message, required this.isMe, this.groupMessage});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool _seenEmitted = false;

  final ChatController controller = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_seenEmitted && !widget.isMe) {
        final bool isGroup = widget.groupMessage != null;

        final String? messageId = isGroup
            ? widget.groupMessage?.id
            : widget.message?.messageId;

        final String? status = isGroup
            ? widget.groupMessage?.messageStatus
            : widget.message?.messageStatus;

        if (messageId != null && status != 'seen') {
          controller.markMessageAsSeen(messageId, Global.userId ?? '', isGroup);
          _seenEmitted = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isGroup = widget.groupMessage != null;
    final dynamic msg = isGroup ? widget.groupMessage : widget.message;
    final String? text = msg.message;
    final DateTime createdAt = msg.createdAt;
    final String? messageType = msg.messageType;
    final List<dynamic>? attachmentDetails = msg.attachmentDetails;
    final double? latitude = msg.latitude;
    final double? longitude = msg.longitude;
    final String? status = isGroup ? widget.groupMessage?.messageStatus : widget.message?.messageStatus;
    final String formattedTime = DateFormat('hh:mm a').format(createdAt);
    final textFocusNode = FocusNode();
    //final status = message.messageStatus;
    return Align(
      alignment: widget.isMe ? Alignment.centerLeft : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          _showEditDeleteOptions(context);
        },
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
            // Swipe right detected
            controller.setReplyTo(widget.message!);
            FocusScope.of(context).requestFocus(textFocusNode);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.all(12),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          decoration: BoxDecoration(
            //  color: isMe ? Colors.green[300] : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15),
              bottomLeft: widget.isMe ? const Radius.circular(15) : Radius.zero,
              bottomRight: widget.isMe ? Radius.zero : const Radius.circular(15),
            ),
            // border: Border.all(
            //   // color: Colors.black.withOpacity(0.3),
            //   color: Get.theme.disabledColor,
            //   width: 1.0,
            // ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    // Ensures the dot can overflow outside the stack
                    children: [
                      CircleAvatar(
                        backgroundColor:
                        Colors.grey.shade400,
                        child: Text(
                          StringUtils.getInitials("${widget.message?.senderDetails?.first.firstname} ${widget.message?.senderDetails?.first.lastname}"),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      // if(!chatUser.isRoom)
                        Positioned(
                          top: 1,
                          left: 1,
                          child: Container(
                            width: 9, // Size of the dot
                            height: 9,
                            decoration: BoxDecoration(
                              color:  Get.theme.scaffoldBackgroundColor,
                              // Dot color
                              shape: BoxShape
                                  .circle, // Makes the container circular
                            ),
                          ),
                        ),
                      //if(!chatUser.isRoom)
                        Positioned(
                          top: 2,
                          left: 2,
                          child: Container(
                            width: 6, // Size of the dot
                            height: 6,
                            decoration: BoxDecoration(
                              color: Get.theme.unselectedWidgetColor,
                              // Dot color
                              shape: BoxShape
                                  .circle, // Makes the container circular
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${widget.message?.senderDetails?.first.firstname} ${widget.message?.senderDetails?.first.lastname}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              formattedTime,
                              style: TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        ),
                        // Text(
                        //   //  message.title,
                        //   //   "${user.email}",
                        //   chatUser.messageWithPrefix??'',
                        //   style: TextStyle(
                        //       color: Colors.grey.shade500),
                        // ),
                        if (widget.message?.replyToDetails  != null) ...[
                          Container(
                            padding: const EdgeInsets.all(6),
                            margin: EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // "Reply to: ${controller.replyMessage.value?.message ?? ''}",
                                  "${widget.message?.replyToDetails?.message ??''}",
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12,
                                  ),
                                ),
                                if (widget.message?.replyToDetails?.messageType == 'image')
                                  Image.network(widget.message!.replyToDetails!.attachmentDetails!.first.url??''),
                              ],
                            ),
                          ),
                          // Text(widget.message?.message??''),
                          const SizedBox(height: 5),
                        ],

                        // Image Message
                        //if (message.messageType == "image" && message.attachmentDetails?.url != null) ...[
                        if (messageType == "image" && attachmentDetails != null) ...[
                          for (var file in attachmentDetails)
                            if (file.url != null)
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => FullScreenImage(imageUrl: file.url!));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    file.url!,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          const SizedBox(height: 5),
                        ],

                        if (messageType == "video" && attachmentDetails != null) ...[
                          for (var file in attachmentDetails)
                            if (file.url != null) VideoBubble(videoUrl: file.url!)
                        ],

                        if (messageType == "audio" && attachmentDetails != null) ...[
                          for (var file in attachmentDetails)
                            if (file.url != null) AudioPlayerWidget(audioUrl: file.url!),
                          const SizedBox(height: 5),
                        ],

                        // File Attachment
                        if (messageType == "document" && attachmentDetails != null) ...[
                          for (var file in attachmentDetails)
                            if (file.name != null && file.url != null)
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    final url = file.url;
                                    //final originalName = document["originalName"];
                                    final originalName = file.name;

                                    if (url != null && originalName != null) {
                                      final directory = await getTemporaryDirectory();
                                      final filePath = "${directory.path}/$originalName";

                                      final file = File(filePath);
                                      if (!file.existsSync()) {
                                        final response = await http.get(Uri.parse(url));
                                        if (response.statusCode == 200) {
                                          await file.writeAsBytes(response.bodyBytes);
                                        } else {
                                          throw Exception("Failed to download file");
                                        }
                                      }

                                      final result = await OpenFilex.open(filePath);
                                      if (result.type != ResultType.done) {
                                        print('error opening file : ${result.message}');
                                        throw Exception(
                                            "Error opening file: ${result.message}");
                                      }
                                    } else {
                                      throw Exception("Invalid file data");
                                    }
                                  } catch (e) {
                                    print('error : ${e.toString()}');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Error: ${e.toString()}")),
                                    );
                                  }
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.attach_file, color: Colors.blue),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        file.name!,
                                        // basename(message.attachmentId!),
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          const SizedBox(height: 5),
                        ],

                        if (messageType == "location" && latitude != null && longitude != null) ...[
                          GestureDetector(
                            onTap: () {
                              String mapUrl =
                                  "https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}";
                              launchUrl(Uri.parse(mapUrl),
                                  mode: LaunchMode.externalApplication);
                              // String mapUrl = "https://www.openstreetmap.org/?mlat=${message.latitude}&mlon=${message.longitude}&zoom=15";
                              // launchUrl(Uri.parse(mapUrl), mode: LaunchMode.externalApplication);
                            },
                            child: Container(
                              height: 150,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue[100],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  // "https://maps.googleapis.com/maps/api/staticmap?center=${message.latitude},${message.longitude}&zoom=15&size=200x150&markers=color:red%7C${message.latitude},${message.longitude}&key=YOUR_GOOGLE_MAPS_API_KEY",
                                  "https://static-maps.yandex.ru/1.x/?lang=en-US&ll=${longitude},${latitude}&z=15&l=map&size=200,150",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],

                        // Text Message
                        if (text != null && text.isNotEmpty) ...[
                          Text(
                            text,
                            style: const TextStyle(fontSize: 16),
                            softWrap: true,
                          ),
                        ],

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Text(
                            //   formattedTime,
                            //   style: TextStyle(fontSize: 10, color: Colors.grey),
                            // ),
                            const SizedBox(width: 4),
                            if (widget.isMe)
                              Text(
                                _getStatusText(status ?? ''),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getStatusColor(status ?? ''),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),


                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _showEditDeleteOptions(BuildContext context) {
   // final controller = Get.find<ChatController>();
    final bool isGroup = widget.groupMessage != null;
    final dynamic msg = isGroup ? widget.groupMessage : widget.message;

    // Calculate elapsed time in minutes
    final createdAt = msg?.createdAt; // Ensure this is a DateTime object
    final elapsedMinutes = DateTime.now().difference(createdAt!).inMinutes;

    final canEdit = widget.isMe && elapsedMinutes <= 60;
    final canDelete = widget.isMe && elapsedMinutes <= 180;

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              if (widget.isMe && canEdit && (widget.message?.messageType == 'text' || widget.groupMessage?.messageType == 'text') )// Only sender can edit
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text("Edit"),
                  onTap: () {
                    Navigator.pop(context);
                    _showEditDialog(context);
                  },
                ),
              if (widget.isMe && canDelete) // Only sender can delete
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text("Delete"),
                  onTap: () async {
                    Navigator.pop(context); // Close the bottom sheet

                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Delete message?"),
                        content: Text(
                            "Are you sure you want to delete this message?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text("Delete",
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      if (isGroup) {
                        controller.deleteGroupMessage(widget.groupMessage?.id);
                      } else {
                        controller.deleteMessage(widget.message?.messageId);
                      }
                    }
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void _showEditDialog(BuildContext context) {
    //final controller = Get.find<ChatController>();
    final bool isGroup = widget.groupMessage != null;
    final textController = TextEditingController(
        text: isGroup ? widget.groupMessage?.message : widget.message?.message);
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Edit Message"),
          content: TextField(
            controller: textController,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                isGroup
                    ? controller.updateGroupMessage(
                        widget.groupMessage?.id, textController.text.trim())
                    : controller.updateMessage(
                        widget.message?.messageId, textController.text.trim());
                //isGroup ? controller.fetchMessage(message?.receiverId) : controller.fetchGroupMessages(groupMessage?.roomId);
                Navigator.pop(context);

              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'seen':
        return '✓✓';
      case 'delivered':
        return '✓✓';
      case 'sent':
        return '✓';
      default:
        return '';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'seen':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

// class ChatMessageBubble extends StatelessWidget {
//   final MessageModel message;
//   final bool isMe;
//   final bool showDateHeader;
//
//   const ChatMessageBubble({
//     Key? key,
//     required this.message,
//     required this.isMe,
//     this.showDateHeader = false,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     DateTime createdAt = message.createdAt;
//     String formattedDate =
//         '${createdAt.day}/${createdAt.month}/${createdAt.year}';
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (showDateHeader)
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Center(
//               child: Text(
//                 formattedDate,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ),
//           ),
//         _buildMessageWidget(message, isMe, context),
//       ],
//     );
//   }
//
//   Widget _buildMessageWidget(
//       MessageModel message, bool isMe, BuildContext context) {
//     final status = message.messageStatus;
//
//     bool isSeen = status == 'seen';
//     bool isDelivered = isSeen || status == 'delivered';
//     bool isSent = isDelivered || status == 'sent';
//
//     switch (message.messageType) {
//       case 'text':
//         return GestureDetector(
//           onLongPress: () {
//             _showEditDeleteOptions(context);
//           },
//           child: Column(
//             children: [
//               BubbleNormal(
//                 text: message.message ?? '',
//                 isSender: isMe,
//                 color: isMe ? Color(0xFFE1FFC7) : Colors.grey.shade200,
//                 tail: true,
//                 // sent: isSent,  // apply logic for the sent click
//                 // seen: isSeen, // apply logic of sent
//                 // delivered: isDelivered, // apply logic of delivered
//                 textStyle: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black,
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     DateFormat('hh:mm a').format(message.createdAt),
//                     style: TextStyle(fontSize: 10, color: Colors.grey),
//                   ),
//                   const SizedBox(width: 4),
//                   if (isMe)
//                     Text(
//                       _getStatusText(status),
//                       style: TextStyle(
//                         fontSize: 10,
//                         color: _getStatusColor(status),
//                       ),
//                     ),
//                 ],
//               ),
//             ],
//           ),
//         );
//
//       case 'image':
//         return Column(
//           crossAxisAlignment:
//               isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: message.attachmentDetails!
//               .map((file) => GestureDetector(
//                     onTap: () {
//                       Get.to(() => FullScreenImage(imageUrl: file.url!));
//                     },
//                     onLongPress: () {
//                       _showEditDeleteOptions(context);
//                     },
//                     child: BubbleNormalImage(
//                       id: file.url!,
//                       image: Image.network(file.url!, fit: BoxFit.cover),
//                       isSender: isMe,
//                       tail: true,
//                       sent: isSent,
//                       seen: isSeen,
//                       delivered: isDelivered,
//                     ),
//                   ))
//               .toList(),
//         );
//
//       case 'video':
//         return Row(
//           mainAxisAlignment:
//               isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//           children: message.attachmentDetails!
//               .map((file) => GestureDetector(
//                   onLongPress: () {
//                     _showEditDeleteOptions(context);
//                   },
//                   child: VideoBubble(videoUrl: file.url!)))
//               .toList(),
//         );
//
//       case 'audio':
//         return Column(
//           crossAxisAlignment:
//               isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: message.attachmentDetails!
//               .map((file) => GestureDetector(
//                   onLongPress: () {
//                     _showEditDeleteOptions(context);
//                   },
//                   child: AudioPlayerWidget(audioUrl: file.url!)))
//               .toList(),
//         );
//
//       case 'document':
//         return Column(
//           crossAxisAlignment:
//               isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: message.attachmentDetails!
//               .map((file) => BubbleNormal(
//                     text: file.name ?? "Document",
//                     isSender: isMe,
//                     color: Colors.blue[100]!,
//                     tail: true,
//                     seen: isSeen,
//                     sent: isSent,
//                     delivered: isDelivered,
//                     textStyle: TextStyle(
//                       color: Colors.blue,
//                       // decoration: TextDecoration.underline,
//                     ),
//                   ))
//               .toList(),
//         );
//
//       default:
//         return SizedBox.shrink();
//     }
//   }
//
//   void _showEditDeleteOptions(BuildContext context) {
//     final controller = Get.find<ChatController>();
//
//     showModalBottomSheet(
//       context: context,
//       builder: (_) {
//         return SafeArea(
//           child: Wrap(
//             children: [
//               if (isMe) // Only sender can edit
//                 ListTile(
//                   leading: Icon(Icons.edit),
//                   title: Text("Edit"),
//                   onTap: () {
//                     Navigator.pop(context);
//                     _showEditDialog(context);
//                   },
//                 ),
//               ListTile(
//                   leading: Icon(Icons.delete),
//                   title: Text("Delete"),
//                   // onTap: () {
//                   //   Navigator.pop(context);
//                   //   controller.deleteMessage(message.messageId, Global.userId!, deleteForEveryone: true);
//                   // },
//                   onTap: () async {
//                     Navigator.pop(
//                         context); // Close the bottom sheet or list tile menu first
//
//                     final result = await showDialog<String>(
//                       context: context,
//                       builder: (context) {
//                         return SimpleDialog(
//                           title: Text("Delete message?"),
//                           children: [
//                             SimpleDialogOption(
//                               onPressed: () {
//                                 Navigator.pop(context, "everyone");
//                               },
//                               child: Text("Delete for everyone"),
//                             ),
//                             SimpleDialogOption(
//                               onPressed: () {
//                                 Navigator.pop(context, "me");
//                               },
//                               child: Text("Delete for me"),
//                             ),
//                             SimpleDialogOption(
//                               onPressed: () {
//                                 Navigator.pop(context, "cancel");
//                               },
//                               child: Text("Cancel",
//                                   style: TextStyle(color: Colors.red)),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//
//                     if (result == "everyone") {
//                       controller.deleteMessage(message.messageId);
//                     } else if (result == "me") {
//                       controller.deleteMessage(message.messageId);
//                     }
//                   }),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _showEditDialog(BuildContext context) {
//     final controller = Get.find<ChatController>();
//     final textController = TextEditingController(text: message.message);
//
//     showDialog(
//       context: context,
//       builder: (_) {
//         return AlertDialog(
//           title: Text("Edit Message"),
//           content: TextField(
//             controller: textController,
//             autofocus: true,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 controller.updateMessage(
//                     message.messageId, textController.text.trim());
//                 Navigator.pop(context);
//               },
//               child: Text("Save"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   String _getStatusText(String status) {
//     switch (status) {
//       case 'seen':
//         return '✓✓ Seen';
//       case 'delivered':
//         return '✓✓';
//       case 'sent':
//         return '✓';
//       default:
//         return '';
//     }
//   }
//
//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'seen':
//         return Colors.blue;
//       default:
//         return Colors.grey;
//     }
//   }
// }


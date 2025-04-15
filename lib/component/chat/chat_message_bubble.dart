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
import '../../controllers/chat_contoller.dart';
import '../../global/global.dart';
import '../../models/message_model.dart';
import 'audio_player.dart';
import 'full_screeen_video.dart';
import 'full_screen_image.dart';
///use chat_bubble library  for chat ui
class ChatBubble extends StatelessWidget {
  final MessageModel? message;
  final bool isMe;
  final GroupMessageModel? groupMessage;

  ChatBubble({this.message, required this.isMe, this.groupMessage});

  @override
  Widget build(BuildContext context) {
    final bool isGroup = groupMessage != null;
    final dynamic msg = isGroup ? groupMessage : message;

    final String? text = msg.message;
    final DateTime createdAt = msg.createdAt;
    final String? messageType = msg.messageType;
    final List<dynamic>? attachmentDetails = msg.attachmentDetails;
    final double? latitude = msg.latitude;
    final double? longitude = msg.longitude;
    final String? status = isGroup ? null : message?.messageStatus;

    String formattedTime = DateFormat('hh:mm a').format(createdAt);
    //final status = message.messageStatus;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          _showEditDeleteOptions(context);
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
              bottomLeft: isMe ? const Radius.circular(15) : Radius.zero,
              bottomRight: isMe ? Radius.zero : const Radius.circular(15),
            ),
            border: Border.all(
             // color: Colors.black.withOpacity(0.3),
              color: Get.theme.disabledColor,
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Message
              //if (message.messageType == "image" && message.attachmentDetails?.url != null) ...[
              if (messageType == "image" &&
                  attachmentDetails != null) ...[
                for (var file in attachmentDetails!)
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

              if (messageType == "video" &&
                  attachmentDetails != null) ...[
                for (var file in attachmentDetails!)
                  if (file.url != null)
                    VideoBubble(videoUrl: file.url!)
              ],

              if (messageType == "audio" &&
                  attachmentDetails != null) ...[
                for (var file in attachmentDetails!)
                  if (file.url != null)
                    AudioPlayerWidget(audioUrl: file.url!),
                const SizedBox(height: 5),
              ],

              // File Attachment
              if (messageType == "document" &&
                  attachmentDetails != null) ...[
                for (var file in attachmentDetails!)
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

              if (messageType == "location" &&
                  latitude != null &&
                  longitude != null) ...[

                GestureDetector(
                  onTap: () {
                    String mapUrl =
                        "https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}";
                    launchUrl(Uri.parse(mapUrl), mode: LaunchMode.externalApplication);
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
              if (text != null && text!.isNotEmpty) ...[
                Text(
                  text!,
                  style: const TextStyle(fontSize: 16),
                  softWrap: true,
                ),
              ],

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('hh:mm a').format(createdAt),
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  const SizedBox(width: 4),
                  if (isMe)
                    Text(
                      _getStatusText(status??''),
                      style: TextStyle(
                        fontSize: 10,
                        color: _getStatusColor(status??''),
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
    final controller = Get.find<ChatController>();
    final bool isGroup = groupMessage != null;
    final dynamic msg = isGroup ? groupMessage : message;

    // Calculate elapsed time in minutes
    final createdAt = msg?.createdAt; // Ensure this is a DateTime object
    final elapsedMinutes = DateTime.now().difference(createdAt!).inMinutes;

    final canEdit = isMe && elapsedMinutes <= 60;
    final canDeleteForEveryone = isMe && elapsedMinutes <= 180;

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              if (isMe && canEdit) // Only sender can edit
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit"),
                onTap: () {
                  Navigator.pop(context);
                  _showEditDialog(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text("Delete"),
                // onTap: () {
                //   Navigator.pop(context);
                //   controller.deleteMessage(message.messageId, Global.userId!, deleteForEveryone: true);
                // },
                  onTap: () async {
                    Navigator.pop(context); // Close the bottom sheet or list tile menu first

                    final result = await showDialog<String>(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: Text("Delete message?"),
                          children: [
                            if (canDeleteForEveryone)
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, "everyone");
                              },
                              child: Text("Delete for everyone"),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, "me");
                              },
                              child: Text("Delete for me"),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, "cancel");
                              },
                              child: Text("Cancel", style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        );
                      },
                    );

                    if (result == "everyone") {
                      isGroup ?  controller.deleteGroupMessage(groupMessage?.id, deleteForEveryone: true)
                          : controller.deleteMessage(message?.messageId, Global.userId!, deleteForEveryone: true);
                    } else if (result == "me") {
                      isGroup ? controller.deleteGroupMessage(groupMessage?.id, deleteForEveryone: false)
                      : controller.deleteMessage(message?.messageId, Global.userId!, deleteForEveryone: false);
                    }
                  }
              ),


            ],
          ),
        );
      },
    );
  }

  void _showEditDialog(BuildContext context) {
    final controller = Get.find<ChatController>();
    final bool isGroup = groupMessage != null;
    final textController = TextEditingController(text: isGroup? groupMessage?.message : message?.message);


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
                isGroup ? controller.updateGroupMessage(groupMessage?.id, textController.text.trim())
                    :controller.updateMessage(message?.messageId, textController.text.trim());
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
        return '✓✓ Seen';
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






class ChatMessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMe;
  final bool showDateHeader;

  const ChatMessageBubble({
    Key? key,
    required this.message,
    required this.isMe,
    this.showDateHeader = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime createdAt = message.createdAt;
    String formattedDate = '${createdAt.day}/${createdAt.month}/${createdAt.year}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        _buildMessageWidget(message, isMe, context),
      ],
    );
  }

  Widget _buildMessageWidget(MessageModel message, bool isMe, BuildContext context) {
    final status = message.messageStatus;

    bool isSeen = status == 'seen';
    bool isDelivered = isSeen || status == 'delivered';
    bool isSent = isDelivered || status == 'sent';

    switch (message.messageType) {
      case 'text':
        return GestureDetector(
          onLongPress: () {
            _showEditDeleteOptions(context);
          },
          child: Column(
            children: [
              BubbleNormal(
                text: message.message ?? '',
               isSender: isMe,
                color: isMe ? Color(0xFFE1FFC7) : Colors.grey.shade200,
                tail: true,
                // sent: isSent,  // apply logic for the sent click
                // seen: isSeen, // apply logic of sent
                // delivered: isDelivered, // apply logic of delivered
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('hh:mm a').format(message.createdAt),
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  const SizedBox(width: 4),
                  if (isMe)
                    Text(
                      _getStatusText(status),
                      style: TextStyle(
                        fontSize: 10,
                        color: _getStatusColor(status),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );

      case 'image':
        return Column(
          crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: message.attachmentDetails!
              .map((file) => GestureDetector(
            onTap: () {
              Get.to(() => FullScreenImage(imageUrl: file.url!));
            },
            onLongPress: () {
              _showEditDeleteOptions(context);
            },
            child: BubbleNormalImage(
              id: file.url!,
              image: Image.network(file.url!, fit: BoxFit.cover),
              isSender: isMe,
              tail: true,
              sent: isSent,
              seen: isSeen,
              delivered: isDelivered,
            ),
          ))
              .toList(),
        );

      case 'video':
        return Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: message.attachmentDetails!
              .map((file) => GestureDetector(
            onLongPress: () {
              _showEditDeleteOptions(context);
            },
              child: VideoBubble(videoUrl: file.url!)))
              .toList(),
        );

      case 'audio':
        return Column(
          crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: message.attachmentDetails!
              .map((file) => GestureDetector(
            onLongPress: () {
              _showEditDeleteOptions(context);
            },
              child: AudioPlayerWidget(audioUrl: file.url!)))
              .toList(),
        );

      case 'document':
        return Column(
          crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: message.attachmentDetails!
              .map((file) => BubbleNormal(
            text: file.name ?? "Document",
            isSender: isMe,
            color: Colors.blue[100]!,
            tail: true,
            seen: isSeen,
            sent: isSent,
            delivered: isDelivered,
            textStyle: TextStyle(
              color: Colors.blue,
             // decoration: TextDecoration.underline,
            ),
          ))
              .toList(),
        );

      default:
        return SizedBox.shrink();
    }
  }

  void _showEditDeleteOptions(BuildContext context) {
    final controller = Get.find<ChatController>();

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              if (isMe) // Only sender can edit
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit"),
                onTap: () {
                  Navigator.pop(context);
                  _showEditDialog(context);
                },
              ),
              ListTile(
                  leading: Icon(Icons.delete),
                  title: Text("Delete"),
                  // onTap: () {
                  //   Navigator.pop(context);
                  //   controller.deleteMessage(message.messageId, Global.userId!, deleteForEveryone: true);
                  // },
                  onTap: () async {
                    Navigator.pop(context); // Close the bottom sheet or list tile menu first

                    final result = await showDialog<String>(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: Text("Delete message?"),
                          children: [
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, "everyone");
                              },
                              child: Text("Delete for everyone"),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, "me");
                              },
                              child: Text("Delete for me"),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, "cancel");
                              },
                              child: Text("Cancel", style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        );
                      },
                    );

                    if (result == "everyone") {
                      controller.deleteMessage(message.messageId, Global.userId!, deleteForEveryone: true);
                    } else if (result == "me") {
                      controller.deleteMessage(message.messageId, Global.userId!, deleteForEveryone: false);
                    }
                  }
              ),


            ],
          ),
        );
      },
    );
  }

  void _showEditDialog(BuildContext context) {
    final controller = Get.find<ChatController>();
    final textController = TextEditingController(text: message.message);

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
                controller.updateMessage(message.messageId, textController.text.trim());
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
        return '✓✓ Seen';
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




//
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:path/path.dart';
//
// class ChatBubble extends StatelessWidget {
//   final String message;
//   final bool isSentByMe;
//   final DateTime time;
//   final String? imagePath;
//   final String? filePath;
//   final double? latitude;
//   final double? longitude;
//   final String? id;
//
//   const ChatBubble({
//     Key? key,
//     required this.message,
//     required this.isSentByMe,
//     required this.time,
//     this.imagePath,
//     this.filePath,
//     this.latitude,
//     this.longitude,
//     this.id,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     String formattedTime = DateFormat('hh:mm a').format(time);
//     return Align(
//       alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width * 0.7,
//         ),
//         decoration: BoxDecoration(
//          // color: isSentByMe ? Colors.green.shade400 : Colors.grey.shade500,
//           borderRadius: BorderRadius.only(
//             topLeft: const Radius.circular(15),
//             topRight: const Radius.circular(15),
//             bottomLeft: isSentByMe ? const Radius.circular(15) : Radius.zero,
//             bottomRight: isSentByMe ? Radius.zero : const Radius.circular(15),
//           ),
//           border: Border.all(
//             color: Colors.black.withOpacity(0.3), // Border color
//             width: 1.0, // Border width
//           ),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min, // Shrinks to fit content
//           crossAxisAlignment: CrossAxisAlignment.end, // Aligns text to bottom
//           children: [
//             if (imagePath != null)
//               Stack(
//                 children: [
//                   SizedBox(
//                     width: 200,
//                     child: Image.file(File(imagePath!), fit: BoxFit.cover),
//                   ),
//                   Positioned(
//                     bottom: 5,
//                     right: 5,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
//                       decoration: BoxDecoration(
//                         color: Colors.black54,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text(
//                         formattedTime,
//                         style: const TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             if (filePath != null)
//               Row(
//                 children: [
//                   Icon(Icons.attach_file, color: Colors.blue),
//                   const SizedBox(width: 5),
//                   Text(basename(filePath!), style: TextStyle(color: Colors.blue)),
//                 ],
//               ),
//             if (latitude != null && longitude != null)
//               Container(
//                 width: 200,
//                 height: 150,
//                 child: GoogleMap(
//                   initialCameraPosition: CameraPosition(
//                     target: LatLng(latitude!, longitude!),
//                     zoom: 14,
//                   ),
//                   markers: {
//                     Marker(
//                       markerId: MarkerId(id!),
//                       position: LatLng(latitude!, longitude!),
//                     ),
//                   },
//                 ),
//               ),
//
//             if (message.isNotEmpty)...[
//               Flexible(
//                 child: Text(
//                   message,
//                   style: const TextStyle(fontSize: 16),
//                   softWrap: true,
//                 ),
//               ),
//               SizedBox(width: 5,),
//               Text(
//                 formattedTime,
//                 style: const TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//             ]
//
//           ],
//         ),
//
//       ),
//     );
//   }
// }

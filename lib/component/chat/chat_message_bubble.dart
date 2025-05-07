
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:orbitwork/component/chat/video_bubble.dart';
import 'package:orbitwork/controllers/download_controller.dart';
import 'package:orbitwork/models/group_message_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:swipe_to/swipe_to.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../comms/global/string_utils.dart';
import '../../controllers/chat_contoller.dart';
import '../../global/global.dart';
import '../../models/message_model.dart';
import '../../models/upload_file_model.dart';
import 'audio_player.dart';
import 'downloadable_file_widget.dart';
import 'full_screen_image.dart';
import 'package:orbitwork/extensions/upload_file_utils.dart';

///use chat_bubble library  for chat ui
class ChatBubble extends StatefulWidget {
  final MessageModel? message;
  final bool isMe;
  final GroupMessageModel? groupMessage;
  final bool showSenderName;

  ChatBubble({this.message, required this.isMe, this.groupMessage, this.showSenderName = false});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool _seenEmitted = false;

  final ChatController controller = Get.put(ChatController());
  final DownloadController downloadController = Get.put(DownloadController());
  final textFocusNode = FocusNode();

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
    final isGroup = widget.groupMessage != null;
    final dynamic msg = isGroup ? widget.groupMessage : widget.message;
    final String? text = msg.message;
    final DateTime createdAt = msg.createdAt;
    final localTime = createdAt.toLocal();
    final String? messageType = msg.messageType;
    final List<dynamic>? attachmentDetails = msg.attachmentDetails;
    final double? latitude = msg.latitude;
    final double? longitude = msg.longitude;
    final String? status = isGroup ? widget.groupMessage?.messageStatus : widget.message?.messageStatus;
    final String formattedTime = DateFormat('hh:mm a').format(localTime);
    //final sender = msg.senderDetails?.first;
    final sender = (msg.senderDetails != null && msg.senderDetails!.isNotEmpty)
        ? msg.senderDetails!.first
        : null;
    final replyTo = msg.replyToDetails;

    //final status = message.messageStatus;
    return Align(
      alignment: widget.isMe ? Alignment.centerLeft : Alignment.centerLeft,
      child: SwipeTo(
        onRightSwipe: (details) {
          if (isGroup) {
            controller.setReplyToGroupMessage(widget.groupMessage!);
          } else {
            controller.setReplyToMessage(widget.message!);
          }
          FocusScope.of(context).requestFocus(textFocusNode);
        },
        iconOnRightSwipe: Icons.arrow_forward_ios,
        rightSwipeWidget: SizedBox.shrink(),
        child: GestureDetector(
          onLongPress: () {
            _showEditDeleteOptions(context);
          },

          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
           padding: const EdgeInsets.symmetric(horizontal: 8),

            decoration: BoxDecoration(
              //  color: isMe ? Colors.green[300] : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: widget.isMe ? const Radius.circular(15) : Radius.zero,
                bottomRight: widget.isMe ? Radius.zero : const Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.showSenderName ?
                    Stack(
                      clipBehavior: Clip.none,
                      // Ensures the dot can overflow outside the stack
                      children: [
                        CircleAvatar(
                          backgroundColor:
                          Colors.grey.shade400,
                          child: Text(
                            StringUtils.getInitials("${sender?.firstname ?? ''} ${sender?.lastname ?? ''}"),
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

                          Positioned(
                            top: 2,
                            left: 2,
                            child: Container(
                              width: 6, // Size of the dot
                              height: 6,
                              decoration: BoxDecoration(
                                color: widget.isMe ? Get.theme.primaryColor : Get.theme.unselectedWidgetColor,
                                // Dot color
                                shape: BoxShape
                                    .circle, // Makes the container circular
                              ),
                            ),
                          ),
                      ],
                    ) : SizedBox( width: 40 ,),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          if(widget.showSenderName)
                          Row(
                            children: [
                              Text(
                             "${sender?.firstname ?? ''} ${sender?.lastname ?? ''}",
                                style: TextStyle(
                                  fontSize: 16,
                                    fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                formattedTime,
                                style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),

                          if (replyTo != null) ...[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      if (replyTo.message != null)
                                        Text(
                                          replyTo.message!,
                                          style:  TextStyle(
                                              fontSize: 14,
                                            fontWeight: FontWeight.w500
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      if (replyTo.messageType == 'image')
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(6),
                                          child: Image.network(
                                            replyTo.attachmentDetails!.first.url ?? '', height: 80, width: 80, fit: BoxFit.cover,
                                          ),
                                        ),
                                      if(replyTo.messageType == 'video')
                                        VideoBubble(videoUrl: replyTo?.attachmentDetails?.first.url ?? '', width: 50, height: 50, iconSize: 20,
                                        ),
                                      if(replyTo.messageType == 'audio')
                                        SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: AudioPlayerWidget(audioUrl: replyTo?.attachmentDetails?.first.url ?? '')),
                                      if(replyTo.messageType == 'document')
                                        Row(
                                          children: [
                                            Icon(Icons.file_copy_rounded, color: Colors.grey, size: 20,),
                                            SizedBox(width: 20,),
                                            Text(replyTo?.attachmentDetails?.first.name??'')
                                          ],
                                        ),
                                      if(replyTo.messageType == 'location')
                                        SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(
                                              "https://static-maps.yandex.ru/1.x/?lang=en-US&ll=${replyTo?.latitude},${replyTo?.longitude}&z=15&l=map&size=150,150",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                          ],

                          Row(
                            children: [
                              replyTo != null ? Image.asset(
                                'assets/icon/reply_message.png',
                                height: 20,
                                width: 20,
                              ): SizedBox.shrink(),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Container(
                                  padding: replyTo != null ? const EdgeInsets.all(8) : null,
                                  margin: replyTo != null ? const EdgeInsets.only(bottom: 6): null,
                                  decoration: replyTo != null ? BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ) : null,
                                  child: Row(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                     if( replyTo != null )...[
                                       CircleAvatar(
                                         radius: 14,
                                         backgroundColor:
                                         Colors.grey.shade400,
                                         child: Text(
                                           StringUtils.getInitials("${sender?.firstname ?? ''} ${sender?.lastname ?? ''}"),
                                           style: TextStyle(
                                               fontSize: 12,
                                               fontWeight: FontWeight.bold,
                                               color: Colors.white),
                                         ),
                                       ),
                                       SizedBox(width: 10,)
                                     ],
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if (messageType == "image" && attachmentDetails != null) ...[
                                              for (var file in attachmentDetails)
                                                if (file.url != null)
                                                  Stack(
                                                    children: [
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
                                                      // Positioned(child: IconButton(
                                                      //     onPressed: () {
                                                      //       controller.downloadAndSaveFile(file.url!, 'image');
                                                      //     },
                                                      //     icon: const Icon(Icons.download, color: Colors.white),))
                                                    ],
                                                  ),
                                              const SizedBox(height: 5),
                                            ],

                                            if (messageType == "video" && attachmentDetails != null) ...[
                                              for (var file in attachmentDetails)
                                                if (file.url != null) Stack(
                                                  children: [
                                                    VideoBubble(videoUrl: file.url!, width: 200, height: 200, iconSize: 50,),
                                                    Positioned(
                                                      right: 8,
                                                      bottom: 8,
                                                      child: IconButton(
                                                        icon: const Icon(Icons.download, color: Colors.white),
                                                        onPressed: () {
                                                          controller.downloadAndSaveFile(file.url!, 'video');
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                )
                                            ],

                                            if (messageType == "audio" && attachmentDetails != null) ...[
                                              for (var file in attachmentDetails)
                                                if (file.url != null) Stack(
                                                  children: [
                                                    AudioPlayerWidget(audioUrl: file.url!),
                                                    IconButton(
                                                      icon: const Icon(Icons.download),
                                                      onPressed: () {
                                                        controller.downloadAndSaveFile(file.url!, 'audio');
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              const SizedBox(height: 5),
                                            ],

                                            // File Attachment
                                            // if (messageType == "document" && attachmentDetails != null) ...[
                                            //   for (var file in attachmentDetails)
                                            //     if (file.name != null && file.url != null)
                                            //       DownloadableFileWidget(
                                            //         fileUrl: file.url!,
                                            //         fileName: file.name!,
                                            //         fileSize: file.size,
                                            //         isSender: widget.isMe,
                                            //       ),
                                            // ],

                                            if (messageType == "document" && attachmentDetails != null) ...[
                                              // for (var file in attachmentDetails)
                                              //   if (file.name != null && file.url != null)
                                                  ...attachmentDetails.map<Widget>((dynamic file) {
                                                      if (file is! UploadFile || file.name == null || file.url == null) return const SizedBox.shrink();
                                                      return FutureBuilder<bool>(
                                                          future: file.isFileDownloadedLocally(),
                                                        builder: (context, snapshot) {
                                                          bool downloaded = snapshot.data ?? false;
                                                          return GestureDetector(
                                                            onTap: () async {
                                                              try {
                                                                if (!downloaded) {
                                                                  final path = await ChatController().downloadFileToLocal(file);
                                                                  if (path != null) {
                                                                    await OpenFilex.open(path);
                                                                    // Trigger UI update by notifying controller
                                                                   // downloadController.updateDownloadedStatus(file.name!);
                                                                  }
                                                                } else {
                                                                  final dir = await getApplicationDocumentsDirectory();
                                                                 // final path = '${dir.path}/${file.name}';
                                                                  final path = '/storage/emulated/0/Download/${file.name}';
                                                                  await OpenFilex.open(path);
                                                                }
                                                              } catch (e) {
                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(content: Text("Error: ${e.toString()}")),
                                                                );
                                                              }
                                                            },
                                                            // onTap: () async {
                                                            //   try {
                                                            //     final url = file.url;
                                                            //     //final originalName = document["originalName"];
                                                            //     final originalName = file.name;
                                                            //
                                                            //     if (url != null && originalName != null) {
                                                            //       final directory = await getTemporaryDirectory();
                                                            //       final filePath = "${directory.path}/$originalName";
                                                            //
                                                            //       final file = File(filePath);
                                                            //       if (!file.existsSync()) {
                                                            //         final response = await http.get(Uri.parse(url));
                                                            //         if (response.statusCode == 200) {
                                                            //           await file.writeAsBytes(response.bodyBytes);
                                                            //         } else {
                                                            //           throw Exception("Failed to download file");
                                                            //         }
                                                            //       }
                                                            //
                                                            //       final result = await OpenFilex.open(filePath);
                                                            //       if (result.type != ResultType.done) {
                                                            //         print('error opening file : ${result.message}');
                                                            //         throw Exception(
                                                            //             "Error opening file: ${result.message}");
                                                            //       }
                                                            //     } else {
                                                            //       throw Exception("Invalid file data");
                                                            //     }
                                                            //   } catch (e) {
                                                            //     print('error : ${e.toString()}');
                                                            //     ScaffoldMessenger.of(context).showSnackBar(
                                                            //       SnackBar(content: Text("Error: ${e.toString()}")),
                                                            //     );
                                                            //   }
                                                            // },
                                                            child: Row(
                                                              children: [
                                                                Stack(
                                                                  alignment: Alignment.center,
                                                                  children: [
                                                                    Container(
                                                                        padding: const EdgeInsets.all(8),
                                                                        decoration: BoxDecoration(
                                                                          color: Colors.grey.shade200,
                                                                          shape: BoxShape.circle,
                                                                        ),
                                                                        child: const Icon(Icons.insert_drive_file, color: Colors.grey, size: 18,)),
                                                                    Obx(() {
                                                                      // final progress = downloadController.getProgress(file.name!);
                                                                      // final isDownloading = downloadController.isDownloading(file.name!);
                                                                      final isDownloading = downloadController.isDownloading(file.name!);
                                                                      final progress = downloadController.getProgress(file.name!);
                                                                  //    final isDownloaded = downloadController.isDownloaded(file.name!);
                                                                      return isDownloading
                                                                          ? Text(
                                                                        '${(progress * 100).toStringAsFixed(0)}%',
                                                                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                                                      )
                                                                          : ((!downloaded && !widget.isMe)
                                                                          ? const Icon(Icons.download, size: 16, color: Colors.black87)
                                                                          : const SizedBox());
                                                                    }),
                                                                  ],
                                                                ),
                                                                SizedBox(width: 5,),
                                                                const SizedBox(width: 5),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      file.name!,
                                                                      // basename(message.attachmentId!),
                                                                      style:  TextStyle(
                                                                        fontSize: 14,
                                                                          fontWeight: FontWeight.w500,
                                                                          //color: Colors.blue,
                                                                          overflow: TextOverflow.ellipsis),
                                                                    ),
                                                                    Text(StringUtils.getFileSizeString(bytes: file.size!),
                                                                    style: TextStyle(
                                                                      fontSize: 12,
                                                                      color: Colors.grey
                                                                    ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }
                                                      );
                                                    }
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
                                              text.contains("zoom.us") ?
                                              GestureDetector(
                                                onTap: () async {
                                                  final url = Uri.parse(text);
                                                  if (await canLaunchUrl(url)) {
                                                    await launchUrl(url, mode: LaunchMode.externalApplication);
                                                  } else {
                                                    Get.snackbar('Error', 'Could not open Zoom link');
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue.shade50,
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(color: Colors.blue),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/icon/zoom.png',
                                                        height: 32,
                                                        width: 32,
                                                      ),
                                                      SizedBox(width: 12),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text("Zoom Meeting", style: TextStyle(fontWeight: FontWeight.bold)),
                                                            // You must extract datetime from message model (see step 2)
                                                           if (localTime != null)
                                                              Text(
                                                                DateFormat('MMM d, yyyy – hh:mm a').format(localTime),
                                                                style: TextStyle(color: Colors.grey[600]),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                              : Text(
                                                text,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: widget.message?.replyToDetails != null
                                                      ? Colors.grey.shade700
                                                      : Get.theme.secondaryHeaderColor,
                                                ),
                                                softWrap: true,
                                              ),
                                              // Linkify(
                                              //   text: text,
                                              //   style: TextStyle(
                                              //     fontSize: 14,
                                              //     fontWeight: FontWeight.w500,
                                              //     color: widget.message?.replyToDetails != null
                                              //         ? Colors.grey.shade700
                                              //         : Get.theme.secondaryHeaderColor,
                                              //   ),
                                              //   softWrap: true,
                                              //   onOpen: (link) async {
                                              //     final url = Uri.parse(link.url);
                                              //     if (await canLaunchUrl(url)) {
                                              //       await launchUrl(url, mode: LaunchMode.externalApplication);
                                              //     } else {
                                              //       Get.snackbar('Error', 'Could not launch ${link.url}');
                                              //     }
                                              //   },
                                              // )

                                            ],
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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



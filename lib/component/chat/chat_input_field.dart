import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:orbitwork/component/chat/audio_player.dart';
import 'package:orbitwork/component/chat/video_bubble.dart';
import 'package:orbitwork/models/message_model.dart';
import 'package:orbitwork/models/upload_file_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../comms/enum/message.dart';
import '../../controllers/chat_contoller.dart';
import '../../models/group_message_model.dart';

class ChatInputField extends StatefulWidget {
  final String? receiverId;
  final String? roomId;

  ChatInputField({super.key, this.receiverId, this.roomId});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final ChatController chatController = Get.find<ChatController>();
 // final TextEditingController textController = TextEditingController();
  MessageModel? message;
  GroupMessageModel? groupMessage;

  @override
  void dispose() {
    chatController.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Obx(() {
            final isGroup = widget.roomId != null;
            final dynamic msg = isGroup
                ? chatController.replyGroupMessage.value
                : chatController.replyMessage.value;
            // final replyMessage = chatController.replyMessage.value;
            // final replyGroupMessage = chatController.replyGroupMessage.value;
            // final reply = widget.receiverId != null
            //     ? chatController.replyMessage.value
            //     : chatController.replyGroupMessage.value;
            return (msg != null)
                ? Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Replying to",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              if (msg?.messageType == 'text')
                                Text("${msg?.message}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              if (msg?.messageType == 'image')
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    msg?.attachmentDetails?.first.url ?? '',
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              if (msg?.messageType == 'document')
                                Row(
                                  children: [
                                    Icon(
                                      Icons.file_copy_rounded,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(msg?.attachmentDetails?.first.name ??
                                        '')
                                  ],
                                ),
                              if (msg?.messageType == 'video')
                                VideoBubble(
                                  videoUrl:
                                      msg?.attachmentDetails?.first.url ?? '',
                                  width: 50,
                                  height: 50,
                                  iconSize: 20,
                                ),
                              if (msg?.messageType == 'audio')
                                SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: AudioPlayerWidget(
                                        audioUrl:
                                            msg?.attachmentDetails?.first.url ??
                                                '')),
                              if (msg?.messageType == 'location')
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      "https://static-maps.yandex.ru/1.x/?lang=en-US&ll=${msg?.latitude},${msg?.longitude}&z=15&l=map&size=150,150",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              widget.roomId != null
                                  ? chatController.clearReplyToGroupMessage()
                                  : chatController.clearReplyToMessage();
                            }),
                      ],
                    ),
                  )
                : SizedBox.shrink();
          }),
          Obx(() {
            final joinUrl = chatController.messageText.value;
            final isZoomLink = joinUrl.contains("zoom.us");

            if (isZoomLink) {
              final meetingTime = chatController.selectedMeetingTime.value;

              return Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: 6),
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
                          Text("Created a Zoom Meeting", style: TextStyle(fontWeight: FontWeight.bold)),
                          if (meetingTime != null)
                            Text(
                              DateFormat('MMM d, yyyy – hh:mm a').format(meetingTime),
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        chatController.messageText.value = '';
                        chatController.textController.clear();
                        chatController.selectedMeetingTime.value = null;
                      },
                    )
                  ],
                ),
              );
            }

            return SizedBox.shrink();
          }),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.attach_file, color: Colors.grey[600]),
                onPressed: () => _showAttachmentOptions(context),
              ),
              Expanded(
                child: TextField(
                  controller: chatController.textController,
                  onChanged: (text) => chatController.messageText.value = text,
                  decoration: InputDecoration(
                    hintText: "Type a message...",
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.green),
                onPressed: () {
                  if (chatController.textController.text.isNotEmpty) {
                    if (widget.receiverId != null) {
                      chatController.sendMessage(
                          widget.receiverId!, MessageType.text,);
                      chatController.fetchMessage(widget.receiverId!);
                    } else if (widget.roomId != null) {
                      chatController.sendGroupMessage(
                          widget.roomId!, MessageType.text);
                      chatController.fetchGroupMessages(widget.roomId!);
                    }
                    chatController.textController.clear();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Get.back();
                File? file = await _pickImage(ImageSource.camera);
                if (file != null) {
                  print('camera file ==> ${file}');
                  if (widget.receiverId != null) {
                    chatController.uploadAndSendFile(widget.receiverId!, file: [file]);
                    chatController.fetchMessage(widget.receiverId!);
                  } else if (widget.roomId != null) {
                    chatController.uploadAndSendGroupFile(widget.roomId!, files: [file]);
                    chatController.fetchGroupMessages(widget.roomId);
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () async {
                Get.back();
                print('Opening gallery picker...');
                List<File> file = await _pickMultipleImages();
                print('Picked file ==> ${file}');
                if (file.isNotEmpty) {
                  print('gallery image path ==> ${file}');
                  if(widget.receiverId != null){
                    chatController.uploadAndSendFile(widget.receiverId!, file: file);
                    chatController.fetchMessage(widget.receiverId);
                  } else if(widget.roomId != null){
                    chatController.uploadAndSendGroupFile(widget.roomId!, files: file);
                    chatController.fetchGroupMessages(widget.roomId);
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.audiotrack),
              title: const Text('Audio'),
              onTap: () async {
                Get.back();
                List<File> file = await _pickFile(FileType.audio);
                if (file.isNotEmpty) {
                  if(widget.receiverId != null){
                    chatController.uploadAndSendFile(widget.receiverId!,
                        file: file);
                    chatController.fetchMessage(widget.receiverId);
                  } else if(widget.roomId != null){
                    chatController.uploadAndSendGroupFile(widget.roomId!, files: file );
                    chatController.fetchGroupMessages(widget.roomId);
                  }

                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam),
              title: const Text('Video'),
              onTap: () async {
                Get.back();
                List<File> file = await _pickFile(FileType.video);
                if (file.isNotEmpty) {
                  if(widget.receiverId != null){
                    chatController.uploadAndSendFile(widget.receiverId!,
                        file: file);
                    chatController.fetchMessage(widget.receiverId);
                  }else if(widget.roomId != null){
                    chatController.uploadAndSendGroupFile(widget.roomId!, files: file);
                    chatController.fetchGroupMessages(widget.roomId);
                  }

                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file),
              title: const Text('Document'),
              onTap: () async {
                Get.back();
                List<File> file = await _pickFile(FileType.any);
                if (file.isNotEmpty) {
                  if (widget.receiverId != null) {
                    chatController.uploadAndSendFile(widget.receiverId!,
                        file: file);
                    chatController.fetchMessage(widget.receiverId!);
                  } else if (widget.roomId != null) {
                    chatController.uploadAndSendGroupFile(widget.roomId!,
                        files: file);
                    chatController.fetchGroupMessages(widget.roomId!);
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Location'),
              onTap: () async {
                LocationPermission permission =
                    await Geolocator.requestPermission();
                if (permission == LocationPermission.denied ||
                    permission == LocationPermission.deniedForever) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Location permission denied")));
                  return;
                }
                Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);
                if(widget.receiverId != null){
                  chatController.sendLocation(position, widget.receiverId!);
                  chatController.fetchMessage(widget.receiverId);
                }else if(widget.roomId != null){
                  chatController.sendGroupLocation(position, widget.roomId!);
                  chatController.fetchGroupMessages(widget.roomId);
                }

              },
            ),
          ],
        );
      },
    );
  }

  // Future<File?> _pickImage(ImageSource source) async {
  //   final pickedFile = await ImagePicker().pickImage(source: source);
  //   return pickedFile != null ? File(pickedFile.path) : null;
  // }
  Future<File?> _pickImage(ImageSource source) async {
    try {
      // Ask for permissions (especially for Android 13+)
      final permissionStatus = await Permission.camera.request();
      if (!permissionStatus.isGranted) {
        print('Camera permission denied.');
        return null;
      }

      final pickedFile = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1080,
        maxHeight: 1920,
        imageQuality: 75, // Compress to avoid crash on low-end devices
      );

      if (pickedFile == null) {
        print('No image selected (user canceled or error).');
        return null;
      }

      final file = File(pickedFile.path);
      print('Picked image path: ${file.path}');
      return file;
    } catch (e, stack) {
      print('Exception while picking image: $e');
      print('StackTrace: $stack');
      return null;
    }
  }


  Future<List<File>> _pickMultipleImages() async {
    final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
    return pickedFiles != null
        ? pickedFiles.map((xFile) => File(xFile.path)).toList()
        : [];
  }

  Future<List<File>> _pickFile(FileType fileType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType,
      allowMultiple: true,
    );
    return result != null
        ? result.files.map((file) => File(file.path!)).toList()
        : [];
  }
}

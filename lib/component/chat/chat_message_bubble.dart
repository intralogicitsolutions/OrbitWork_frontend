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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:orbitwork/component/chat/pdf_view_page.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../models/message_model.dart';
import 'audio_player.dart';
import 'full_screeen_video.dart';
import 'full_screen_image.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  final bool isMe;

  ChatBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('hh:mm a').format(message.createdAt);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
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
            color: Colors.black.withOpacity(0.3),
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Message
            //if (message.messageType == "image" && message.attachmentDetails?.url != null) ...[
            if (message.messageType == "image" &&
                message.attachmentDetails != null) ...[
              for (var file in message.attachmentDetails!)
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

            if (message.messageType == "video" &&
                message.attachmentDetails != null) ...[
              for (var file in message.attachmentDetails!)
                if (file.url != null)
                  GestureDetector(
                    onTap: () {
                      Get.to(() => FullScreenVideo(videoUrl: file.url!));
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black12,
                          ),
                          child: Icon(Icons.play_circle_fill,
                              color: Colors.white, size: 50),
                        ),
                      ],
                    ),
                  )
            ],

            if (message.messageType == "audio" &&
                message.attachmentDetails != null) ...[
              for (var file in message.attachmentDetails!)
                if (file.url != null)
                  AudioPlayerWidget(audioUrl: file.url!),
              const SizedBox(height: 5),
            ],

            // File Attachment
            if (message.messageType == "document" &&
                message.attachmentDetails != null) ...[
              for (var file in message.attachmentDetails!)
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

            if (message.messageType == "location" &&
                message.latitude != null &&
                message.longitude != null) ...[
              GestureDetector(
                onTap: () {
                  String mapUrl =
                      "https://www.google.com/maps/search/?api=1&query=${message.latitude},${message.longitude}";
                  launchUrl(Uri.parse(mapUrl), mode: LaunchMode.externalApplication);
                },
                child: Container(
                  height: 150,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[100],
                  ),
                  // child: Center(
                  //   child: Text("View Location",
                  //       style: TextStyle(color: Colors.blue)),
                  // ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://maps.googleapis.com/maps/api/staticmap?center=${message.latitude},${message.longitude}&zoom=15&size=200x150&markers=color:red%7C${message.latitude},${message.longitude}&key=YOUR_GOOGLE_MAPS_API_KEY",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],

            // Text Message
            if (message.message != null && message.message!.isNotEmpty) ...[
              Text(
                message.message!,
                style: const TextStyle(fontSize: 16),
                softWrap: true,
              ),
            ],
          ],
        ),
      ),
    );
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

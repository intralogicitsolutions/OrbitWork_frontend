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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  final DateTime time;
  final String? imagePath;
  final String? filePath;
  final double? latitude;
  final double? longitude;
  final String? id;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isSentByMe,
    required this.time,
    this.imagePath,
    this.filePath,
    this.latitude,
    this.longitude,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('hh:mm a').format(time);
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
         // color: isSentByMe ? Colors.green.shade400 : Colors.grey.shade500,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: isSentByMe ? const Radius.circular(15) : Radius.zero,
            bottomRight: isSentByMe ? Radius.zero : const Radius.circular(15),
          ),
          border: Border.all(
            color: Colors.black.withOpacity(0.3), // Border color
            width: 1.0, // Border width
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Shrinks to fit content
          crossAxisAlignment: CrossAxisAlignment.end, // Aligns text to bottom
          children: [
            if (imagePath != null)
              Stack(
                children: [
                  SizedBox(
                    width: 200,
                    child: Image.file(File(imagePath!), fit: BoxFit.cover),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        formattedTime,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            if (filePath != null)
              Row(
                children: [
                  Icon(Icons.attach_file, color: Colors.blue),
                  const SizedBox(width: 5),
                  Text(basename(filePath!), style: TextStyle(color: Colors.blue)),
                ],
              ),
            if (latitude != null && longitude != null)
              Container(
                width: 200,
                height: 150,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(latitude!, longitude!),
                    zoom: 14,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(id!),
                      position: LatLng(latitude!, longitude!),
                    ),
                  },
                ),
              ),

            if (message.isNotEmpty)...[
              Flexible(
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 16),
                  softWrap: true,
                ),
              ),
              SizedBox(width: 5,),
              Text(
                formattedTime,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ]

          ],
        ),

      ),
    );
  }
}

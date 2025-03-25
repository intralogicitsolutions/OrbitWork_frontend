// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:flutter_sound/public/flutter_sound_recorder.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:location/location.dart';
// import '../../controllers/chat_contoller.dart';
//
// class ChatInputField extends StatelessWidget {
//   final TextEditingController _controller = TextEditingController();
//   final ChatsController chatController = Get.find<ChatsController>();
//   final ImagePicker _picker = ImagePicker();
//   final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
//   final Location _location = Location();
//   bool _isRecording = false;
//   String _recordedAudioPath = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           if (_isRecording) ...[
//             // Audio recording UI
//             Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.stop, color: Colors.red),
//                   onPressed: () async {
//                     await _stopRecording();
//                     chatController.sendMessage(_recordedAudioPath);
//                   },
//                 ),
//                 Text('Recording...'),
//               ],
//             ),
//           ],
//           Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: _controller,
//                   onChanged: (text) {
//                     chatController.updateMessageText(text);
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Type a message...",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     suffixIcon:  Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.attach_file),
//                           onPressed: () async {
//                             _showFileOptionsBottomSheet(context);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.camera_alt),
//                           onPressed: () async {
//                             // Handle camera button
//                             final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//                             if (image != null) {
//                               chatController.sendImage(image.path);
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Obx(() {
//                 return IconButton(
//                   icon: Icon(
//                     chatController.messageText.value.isNotEmpty || chatController.selectedFilePath.value.isNotEmpty
//                         ? Icons.send
//                         : Icons.mic,
//                     color: chatController.messageText.value.isNotEmpty || chatController.selectedFilePath.value.isNotEmpty
//                         ? Colors.green
//                         : Colors.blue,
//                   ),
//                   onPressed: () {
//                     FocusScope.of(context).unfocus();
//                     if (chatController.messageText.value.isNotEmpty) {
//                       chatController.sendMessage(chatController.messageText.value);
//                       _controller.clear();
//                       chatController.messageText.value = "";
//                     } else if (chatController.selectedFilePath.value.isNotEmpty) {
//                       chatController.sendFile(chatController.selectedFilePath.value);
//                     } else {
//                       // Handle mic recording if needed
//                     }
//                   },
//                 );
//               }),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _startRecording() async {
//     await _audioRecorder.startRecorder(
//       toFile: 'audio.wav',
//       codec: Codec.pcm16WAV,
//     );
//     _isRecording = true;
//   }
//
//   Future<void> _stopRecording() async {
//     final String? path = await _audioRecorder.stopRecorder();
//     _recordedAudioPath = path!;
//     _isRecording = false;
//   }
//
//   void _showFileOptionsBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Wrap(
//           children: [
//             ListTile(
//               leading: Icon(Icons.photo),
//               title: Text("Gallery"),
//               onTap: () async {
//                 final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//                 if (image != null) {
//                   chatController.sendImage(image.path);
//                   chatController.selectedFilePath.value = image.path;
//                 }
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.camera),
//               title: Text("Camera"),
//               onTap: () async {
//                 final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//                 if (image != null) {
//                   chatController.sendImage(image.path);
//                   chatController.selectedFilePath.value = image.path;
//                 }
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.location_on),
//               title: Text("Location"),
//               onTap: () async {
//                 LocationData location = await _location.getLocation();
//                 chatController.sendLocation(location.latitude!, location.longitude!);
//                 chatController.selectedFilePath.value = ''; // Reset file path
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.insert_drive_file),
//               title: Text("Document"),
//               onTap: () async {
//                 FilePickerResult? result = await FilePicker.platform.pickFiles();
//                 if (result != null) {
//                   String filePath = result.files.single.path!;
//                   chatController.sendFile(filePath);
//                   chatController.selectedFilePath.value = filePath;
//                 }
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.mic),
//               title: Text("Audio"),
//               onTap: () async {
//                 // Handle audio selection logic if needed
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/chat_contoller.dart';

class ChatInputField extends StatelessWidget {
  final ChatController chatController = Get.find<ChatController>();
  final String receiverId;

  ChatInputField({super.key, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.attach_file, color: Colors.grey[600]),
            onPressed: () {
              // Handle file attachment (image, video, document)
              print("Attachment Clicked");
            },
          ),
          Expanded(
            child: TextField(
              controller: TextEditingController(text: chatController.messageText.value),
              onChanged: (text) => chatController.messageText.value = text,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.green),
            onPressed: () => chatController.sendMessage(receiverId),
          ),
        ],
      ),
    );
  }
}

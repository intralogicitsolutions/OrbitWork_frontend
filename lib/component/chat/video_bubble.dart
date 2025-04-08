// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
// import 'dart:io';
//
// import 'full_screeen_video.dart';
//
//
// class VideoBubble extends StatefulWidget {
//   final String videoUrl;
//
//   const VideoBubble({Key? key, required this.videoUrl}) : super(key: key);
//
//   @override
//   _VideoBubbleState createState() => _VideoBubbleState();
// }
//
// class _VideoBubbleState extends State<VideoBubble> {
//   String? thumbnailPath;
//
//   @override
//   void initState() {
//     super.initState();
//     _generateThumbnail();
//   }
//
//   Future<void> _generateThumbnail() async {
//     final thumb = await VideoThumbnail.thumbnailFile(
//       video: widget.videoUrl,
//       thumbnailPath: null, // Auto-save to temp directory
//       imageFormat: ImageFormat.JPEG,
//       maxHeight: 200,
//       quality: 75,
//     );
//     if (mounted) {
//       setState(() {
//         thumbnailPath = thumb;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Get.to(() => FullScreenVideo(videoUrl: widget.videoUrl));
//       },
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           thumbnailPath != null
//               ? ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.file(File(thumbnailPath!), width: 200, height: 200, fit: BoxFit.cover),
//           )
//               : Container(
//             width: 200,
//             height: 200,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.black12,
//             ),
//             child: Center(child: CircularProgressIndicator()), // Show loading while generating thumbnail
//           ),
//           const Icon(Icons.play_circle_fill, color: Colors.white, size: 50),
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/video_controller.dart';
import 'full_screeen_video.dart';


class VideoBubble extends StatelessWidget {
  final String videoUrl;
  final VideoController controller;

  VideoBubble({Key? key, required this.videoUrl})
      : controller = Get.put(VideoController(videoUrl)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => FullScreenVideo(videoUrl: videoUrl));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(() => controller.thumbnailPath.isNotEmpty
              ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              File(controller.thumbnailPath.value),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          )
              : Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black12,
            ),
            child: Center(child: CircularProgressIndicator()), // Loading
          )),
          const Icon(Icons.play_circle_fill, color: Colors.white, size: 50),
        ],
      ),
    );
  }
}

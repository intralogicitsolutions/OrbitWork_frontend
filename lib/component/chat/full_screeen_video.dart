import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../controllers/video_controller.dart';

class FullScreenVideo extends StatelessWidget {
  final String videoUrl;

  const FullScreenVideo({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoController = Get.put(VideoController(videoUrl));

    return WillPopScope(
      onWillPop: () async {
        videoController.videoPlayerController.pause();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: videoController.togglePlayPause,
          child: Center(
            child: Obx(() => videoController.isInitialized.value
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: videoController
                            .videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(videoController.videoPlayerController),
                      ),
                      if (!videoController.isPlaying.value)
                        const Icon(Icons.play_circle_fill,
                            size: 80, color: Colors.white),
                    ],
                  )
                : const CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

// class FullScreenVideo extends StatefulWidget {
//   final String videoUrl;
//
//   const FullScreenVideo({Key? key, required this.videoUrl}) : super(key: key);
//
//   @override
//   _FullScreenVideoState createState() => _FullScreenVideoState();
// }
//
// class _FullScreenVideoState extends State<FullScreenVideo> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//       });
//     _controller.addListener(() {
//       setState(() {
//         _isPlaying = _controller.value.isPlaying;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: _controller.value.isInitialized
//             ? AspectRatio(
//           aspectRatio: _controller.value.aspectRatio,
//           child: VideoPlayer(_controller),
//         )
//             : CircularProgressIndicator(),
//       ),
//     );
//   }
// }

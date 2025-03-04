import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile/video_introduction_controller.dart';

class AddVideoIntroductionSheet extends StatelessWidget {
  AddVideoIntroductionSheet({Key? key}) : super(key: key);

  final controller = Get.put(VideoIntroductionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: const Icon(Icons.close, size: 24),
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Add video introduction',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.more_vert),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),

                      // Content
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Link to your YouTube video',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Obx(() {
                                return TextField(
                                  controller: controller.videoLinkController,
                                  decoration: InputDecoration(
                                    hintText: 'Ex: https://www.youtube.com/watch?v=dQw4',
                                    hintStyle: TextStyle(color: Colors.grey[400]),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(color: controller.showError.value? Colors.red : Colors.black),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: BorderSide(color: controller.showError.value? Colors.red : Colors.black),
                                    ),
                                  ),
                                  onChanged: controller.validateVideoLink,
                                );
                              }
                            ),
                            Obx(() => controller.showError.value
                                ? Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Icon(Icons.error_outline,
                                      size: 16, color: Colors.red[400]),
                                  const SizedBox(width: 4),
                                  Text(
                                    'This field is required.',
                                    style: TextStyle(
                                      color: Colors.red[400],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : const SizedBox.shrink()),
                            const SizedBox(height: 24),
                            const Text(
                              'Does your video meet Upwork\'s guidelines?',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: controller.onCancel,
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    //const Spacer(),
                    Expanded(
                      child: Obx(() => TextButton(
                        onPressed: controller.isVideoLinkValid.value
                            ? controller.onSave
                            : null,
                        style: TextButton.styleFrom(
                          backgroundColor: controller.isVideoLinkValid.value
                              ? Colors.green
                              : Colors.grey[100],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: controller.isVideoLinkValid.value
                                ? Colors.white
                                : Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
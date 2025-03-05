import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../comms/url_launcher_helper.dart';
import '../controllers/photo_and_location_controller.dart';
import '../widgets/dotted_border_container.dart';

class PhotoUploadSheet extends GetView<PhotoAndLocationController> {
  final PhotoAndLocationController controller = Get.put(PhotoAndLocationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your photo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          controller.currentImage.value != null ?
              Column(
                children: [
                  Obx(() => Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: ClipOval(
                      child: Transform(
                        transform: controller.matrix.value,
                        alignment: Alignment.center,
                        //scale: controller.zoomLevel.value,
                        child: Image.file(
                          controller.currentImage.value!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        const Icon(Icons.zoom_out, color: Colors.black54),
                        Expanded(
                          child: Obx(() => Slider(
                            value: controller.zoomLevel.value,
                            min: 1.0,
                            max: 2.0,
                            activeColor: Colors.black,
                            inactiveColor: Colors.grey[300],
                            onChanged: (value) {
                              controller.updateZoomLevel(value);
                            },
                          )),
                        ),
                        const Icon(Icons.zoom_in, color: Colors.black54),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: controller.deleteCurrentImage,
                    icon: const Icon(Icons.delete_outline, color: Colors.green),
                    label: const Text(
                      'Delete current Image',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ) : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: DottedBorderContainer(
                  onTap: () => controller.pickImage(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 48,
                        color: Colors.black54,
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          children: [
                            TextSpan(
                              text: 'Upload',
                              style: TextStyle(
                                color: Colors.green,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(text: ' or drop\nimage here'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '250x250 Min / 5 MB Max',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),

          // Obx(() => Container(
          //   width: 250,
          //   height: 250,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Colors.grey[200],
          //   ),
          //   child: ClipOval(
          //     child: Transform.scale(
          //       scale: controller.zoomLevel.value,
          //       child: Image.file(
          //         controller.currentImage.value!,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // )),
          // const SizedBox(height: 16),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
          //   child: Row(
          //     children: [
          //       const Icon(Icons.zoom_out, color: Colors.black54),
          //       Expanded(
          //         child: Obx(() => Slider(
          //           value: controller.zoomLevel.value,
          //           min: 1.0,
          //           max: 2.0,
          //           activeColor: Colors.black,
          //           inactiveColor: Colors.grey[300],
          //           onChanged: controller.updateZoomLevel,
          //         )),
          //       ),
          //       const Icon(Icons.zoom_in, color: Colors.black54),
          //     ],
          //   ),
          // ),
          // TextButton.icon(
          //   onPressed: controller.deleteCurrentImage,
          //   icon: const Icon(Icons.delete_outline, color: Colors.green),
          //   label: const Text(
          //     'Delete current Image',
          //     style: TextStyle(
          //       color: Colors.green,
          //       fontSize: 16,
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 16),
          //
          //
          //
          //
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          //   child: DottedBorderContainer(
          //     onTap: () => controller.pickImage(),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         const Icon(
          //           Icons.person_outline,
          //           size: 48,
          //           color: Colors.black54,
          //         ),
          //         const SizedBox(height: 16),
          //         RichText(
          //           textAlign: TextAlign.center,
          //           text: const TextSpan(
          //             style: TextStyle(
          //               fontSize: 16,
          //               color: Colors.black54,
          //             ),
          //             children: [
          //               TextSpan(
          //                 text: 'Upload',
          //                 style: TextStyle(
          //                   color: Colors.green,
          //                   decoration: TextDecoration.underline,
          //                 ),
          //               ),
          //               TextSpan(text: ' or drop\nimage here'),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Text(
          //     '250x250 Min / 5 MB Max',
          //     style: TextStyle(
          //       color: Colors.black54,
          //       fontSize: 14,
          //     ),
          //   ),
          // ),



          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Must be an actual photo of you.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: [
                  const TextSpan(
                    text: 'Logos, clip-art, group photos, and digitally-altered images are not allowed. ',
                  ),
                  TextSpan(
                    text: 'Learn more',
                    style: const TextStyle(
                      color: Colors.green,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        UrlLauncherHelper.openUrl('https://www.google.com');
                      },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    controller.attachPhoto();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Attach photo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
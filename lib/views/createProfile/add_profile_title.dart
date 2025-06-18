import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_title_controller.dart';
import '../../routes/app_routes.dart';


class ProfileTitleView extends GetView<ProfileTitleController> {
  final ProfileTitleController controller = Get.put(ProfileTitleController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      const Text(
                        'Got it. Now, add a title to tell the world what you do.',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Subtitle
                      const Text(
                        'It\'s the very first thing clients see, so make it count. Stand out by describing your expertise in your own words.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Professional Role Label
                      const Text(
                        'Your professional role',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Text Field
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller.textController,
                                onChanged: controller.updateTitle,
                                decoration: const InputDecoration(
                                  hintText: 'Example: Web, Mobile & Software Dev',
                                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Obx(() => controller.professionalTitle.value.isNotEmpty
                                ? IconButton(
                              icon: const Icon(Icons.close, color: Colors.grey),
                              onPressed: controller.clearTitle,
                            )
                                : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

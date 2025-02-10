import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_title_controller.dart';
import '../../routes/app_routes.dart';


class ProfileTitleView extends GetView<ProfileTitleController> {
  final ProfileTitleController controller = Get.put(ProfileTitleController());
  //const ProfileTitleView({Key? key}) : super(key: key);

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
                      // Header
                      // Row(
                      //   children: [
                      //     Container(
                      //       width: 40,
                      //       height: 40,
                      //       decoration: const BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: Colors.grey,
                      //       ),
                      //       child: const Icon(
                      //         Icons.person_outline,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //     const SizedBox(width: 12),
                      //     const Text(
                      //       'Create Your Profile',
                      //       style: TextStyle(
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     const Spacer(),
                      //     IconButton(
                      //       icon: const Icon(Icons.more_vert),
                      //       onPressed: () {},
                      //     ),
                      //   ],
                      // ),

                      const SizedBox(height: 32),

                      // Main Title
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

                      // Error Message
                      Obx(() => controller.showError.value
                          ? const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'A descriptive title must have at least 4 letters.',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                          : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Navigation
            // Container(
            //   padding: const EdgeInsets.all(16),
            //   decoration: const BoxDecoration(
            //     border: Border(
            //       top: BorderSide(color: Colors.grey, width: 0.5),
            //     ),
            //   ),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     IconButton(
              //       icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
              //       onPressed: () => Get.back(),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {
              //         if (controller.canProceed()) {
              //           Get.toNamed(AppRoutes.addExperience);
              //         }
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.green,
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: 32,
              //           vertical: 16,
              //         ),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //       ),
              //       child: const Text(
              //         'Add experience',
              //         style: TextStyle(
              //           fontSize: 16,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
           // ),
          ],
        ),
      ),
    );
  }
}

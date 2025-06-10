import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../client_profile_controller/invite_job_controller.dart';

class JobInviteBottomSheet extends StatelessWidget {
  final JobInviteController controller = Get.put(JobInviteController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Get.theme.scaffoldBackgroundColor),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    width: 40,
                    height: 4,
                    margin: EdgeInsets.only(top: 12, bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Header with close button and menu
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(Icons.close, size: 24, color: Colors.black),
                        ),
                        Text(
                          "Invite to job",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Icon(Icons.more_vert, size: 24, color: Colors.black),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // Invite text
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Invite MarDesignStudio to apply regarding",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 25),

                  // Profile section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        // Profile image
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue[100],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/profile_image.jpg', // Replace with your image
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.blue[100],
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.blue[300],
                                    size: 30,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        SizedBox(width: 15),

                        // Profile details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mar D. (Agency business",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "manager)",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // Message section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Message",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Message box
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20),
                  //   child: Container(
                  //     width: double.infinity,
                  //     padding: EdgeInsets.all(20),
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey[50],
                  //       borderRadius: BorderRadius.circular(12),
                  //       border: Border.all(color: Colors.grey[300]!),
                  //     ),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           "Hello!",
                  //           style: TextStyle(
                  //             fontSize: 16,
                  //             color: Colors.black87,
                  //           ),
                  //         ),
                  //         SizedBox(height: 15),
                  //         Text(
                  //           "I'd like to invite you to take a look at the job I've posted. Please submit a proposal if you're available and interested.",
                  //           style: TextStyle(
                  //             fontSize: 16,
                  //             color: Colors.black87,
                  //             height: 1.4,
                  //           ),
                  //         ),
                  //         SizedBox(height: 20),
                  //         Text(
                  //           "Ishita P.",
                  //           style: TextStyle(
                  //             fontSize: 16,
                  //             color: Colors.black87,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: controller.greetingController,
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                            decoration: InputDecoration.collapsed(hintText: ""),
                          ),
                          SizedBox(height: 15),
                          TextField(
                            controller: controller.messageController,
                            maxLines: null,
                            style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.4),
                            decoration: InputDecoration.collapsed(hintText: ""),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: controller.nameController,
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                            decoration: InputDecoration.collapsed(hintText: ""),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 25),

                  // Consultation section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Want to talk to Mar D. (Agency business",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          "about your project?",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 12),
                        GestureDetector(
                          onTap: controller.scheduleConsultation,
                          child: Row(
                            children: [
                              Icon(
                                Icons.videocam_outlined,
                                color: Colors.green[600],
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Schedule a consultation",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green[600],
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.green[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
            child: Obx(() => SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.completeJobPost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: controller.isLoading.value
                    ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : Text(
                  "Complete Your Job Post",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
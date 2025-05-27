import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../global/global.dart';
import 'add_details_bottomsheet.dart';
import 'job_title_bottomsheet.dart';

class PostJobBottomsheet extends StatelessWidget {
  final RxBool showExplanation = false.obs;
  final RxBool showDetails = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post a job'),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.close)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                'assets/icon/ai.svg',
                height: 100,
                width: 100,
                // color: Colors.green, // Optional
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Welcome, ${Global.userFirstname}! Let\'s start with your first job post.',
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.w500, height: 1.3),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text('It\'s the fastest way to meet top talent.'),
              Text('Get help from AI and be done in no time.'),
              SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.bottomSheet(
                      AddDetailsBottomsheet(),
                      isScrollControlled: true,
                      ignoreSafeArea: false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.primaryColor,
                    // backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Get started using AI",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextButton(
                  onPressed: () {
                    Get.bottomSheet(
                      JobTitleBottomsheet(),
                      isScrollControlled: true,
                      ignoreSafeArea: false,
                    );
                  },
                  child: Text(
                    "I'll do it without AI",
                    style: TextStyle(color: Get.theme.primaryColor),
                  )),
              // Text.rich(
              //   TextSpan(
              //     style: TextStyle(fontSize: 14, color: Get.theme.hintColor),
              //     children: [
              //       TextSpan(
              //         text:
              //             'Beta feature powered by Uma, Orbitwork\'s Mindful AI. ',
              //       ),
              //       TextSpan(
              //         text: 'How it works',
              //         style: TextStyle(color: Get.theme.primaryColor),
              //       ),
              //     ],
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              // SizedBox(
              //   height: 24,
              // ),
              // Text(
              //     'We\'ll share your requirements for the job with OpenAI to help you draft a job post. Your use of this feature will be subject to OpenAI\'s Usage Policy and Privacy Policy.'),
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Initial RichText with optional "How it works"
                    Text.rich(
                      TextSpan(
                        style:
                            TextStyle(fontSize: 14, color: Get.theme.hintColor),
                        children: [
                          TextSpan(
                            text:
                                'Beta feature powered by Uma, Orbitwork\'s Mindful AI. ',
                          ),
                          if (!showDetails.value)
                            TextSpan(
                              text: 'How it works',
                              style: TextStyle(color: Get.theme.primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDetails.value = true;
                                },
                            ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // Show explanation after clicking "How it works"
                    if (showDetails.value) ...[
                      SizedBox(height: 12),
                      Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          style: TextStyle(fontSize: 14, color: Get.theme.hintColor),
                          children: [
                            TextSpan(
                              text:
                              'We\'ll share your requirements for the job with OpenAI to help you draft a job post. Your use of this feature will be subject to ',
                            ),
                            TextSpan(
                              text: 'Usage Policy',
                              style: TextStyle(color: Colors.green),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle usage policy tap
                                },
                            ),
                            TextSpan(
                              text: ' and ',
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(color: Colors.green),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle privacy policy tap
                                },
                            ),
                            TextSpan(
                              text: '.',
                            ),
                          ],
                        ),
                      )
                    ]
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class TextSpanWidget extends StatelessWidget {
  final String text;
  final Color color;

  const TextSpanWidget({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 14, color: color),
    );
  }
}

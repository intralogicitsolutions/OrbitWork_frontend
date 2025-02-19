import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/views/createProfile/specialized_profile_tab/specialized_profile_5.dart';

import '../../../controllers/profile/specialized_profile_controller.dart';

class SpecializedProfileStep4 extends StatelessWidget {
  final controller = Get.find<SpecializedProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.close),
      //     onPressed: () => Get.back(),
      //   ),
      //   title: Text('Create a Specialized Pr...'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.more_vert),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step indicator
              Obx(() => Text(
                'Step ${controller.currentStep.value + 1} of ${controller.totalSteps}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              )),
              SizedBox(height: 24),

              // Main description
              Text(
                'Use this space to show clients you have the skills and experience they\'re looking for.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 24),

              // Bullet points
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BulletPoint('Describe your strengths and skills'),
                  BulletPoint('Highlight projects, accomplishments and education'),
                  BulletPoint('Keep it short and make sure it\'s error-free'),
                ],
              ),
              SizedBox(height: 16),

              // Learn more link
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Learn more about building your profile',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Profile overview section
              Text(
                'Profile overview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),

              // Text field
              TextField(
                controller: TextEditingController(
                    text: 'Expertise in building cross - platform mobile applications using flutter. Proficient in flutter widgets , state management ( provider, riverpod, block), and using firebase'
                ),
                onChanged: controller.setProfileOverview,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              SizedBox(height: 8),

              // Characters left counter
              Obx(() => Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${controller.charactersLeft} characters left',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              )),

              // Spacer(),
              //
              // // Bottom navigation
              // Row(
              //   children: [
              //     Expanded(
              //       child: TextButton(
              //         onPressed: () {
              //           controller.previousStep();
              //           Get.back();
              //         },
              //         child: Text(
              //           'Back',
              //           style: TextStyle(
              //             color: Colors.green,
              //             fontSize: 16,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       child: ElevatedButton(
              //         onPressed: () {
              //           controller.nextStep();
              //           Get.to(() => SpecializedProfileStep5());
              //         },
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: Colors.green,
              //           padding: EdgeInsets.symmetric(vertical: 16),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //         ),
              //         child: Text(
              //           'Save & Continue',
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 16,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// Bullet point widget
class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
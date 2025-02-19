import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/views/createProfile/specialized_profile_tab/specialized_profile_4.dart';

import '../../../controllers/profile/specialized_profile_controller.dart';

class SpecializedProfileStep3 extends StatelessWidget {
  final controller = Get.find<SpecializedProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //       //   leading: IconButton(
      //       //     icon: Icon(Icons.close),
      //       //     onPressed: () => Get.back(),
      //       //   ),
      //       //   title: Text('Create a Specialized Pr...'),
      //       //   actions: [
      //       //     IconButton(
      //       //       icon: Icon(Icons.more_vert),
      //       //       onPressed: () {},
      //       //     ),
      //       //   ],
      //       // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step indicator
            Obx(() => Text(
              'Step ${controller.currentStep.value + 1 } of ${controller.totalSteps}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            )),
            SizedBox(height: 24),

            // Description text
            Text(
              'Enter a single sentence description of your professional skills/experience (e.g. Expert Web Designer with Ajax experience)',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 32),

            // Title section
            Text(
              'Your title',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),

            // Title input field
            TextField(
              controller: TextEditingController(text: 'Mobile app developer'),
              onChanged: (value) => controller.setTitle(value),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),

            // Spacer(),
            //
            // // Bottom navigation buttons
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
            //           Get.to(() => SpecializedProfileStep4());
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
    );
  }
}
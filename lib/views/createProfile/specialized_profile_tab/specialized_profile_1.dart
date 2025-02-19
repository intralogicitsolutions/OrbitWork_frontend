import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/views/createProfile/specialized_profile_tab/specialized_profile_2.dart';

import '../../../controllers/profile/specialized_profile_controller.dart';

class SpecializedProfileStep1 extends StatelessWidget {
  final controller = Get.put(SpecializedProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
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

            // Main text
            Text(
              'Specialized profiles help you more effectively highlight your strengths and market your services to clients.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24),

            Text(
              "We've suggested specialties below based on your profile.",
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Select a specialty to begin',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),

            // Suggested specialty
            ListTile(
              leading: Radio<String>(
                value: 'Mobile App Development',
                groupValue: controller.selectedSpecialty.value,
                onChanged: (value) => controller.setSpecialty(value!),
                activeColor: Colors.green,
              ),
              title: Text('Mobile App Development'),
              contentPadding: EdgeInsets.zero,
            ),

            // Dropdown section
            Text(
              'All specialties',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text('Select a specialty'),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: () {
                  // Implement dropdown logic here
                },
              ),
            ),

            SizedBox(height: 24),

            // Tip section
            Text(
              'Tip: Only create profiles in specializations that best describe the work you do.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),

            TextButton(
              onPressed: () {},
              child: Text(
                'See a full list of available specializations and their descriptions',
                style: TextStyle(
                  color: Colors.green,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            // Spacer(),
            //
            // // Bottom buttons
            // Row(
            //   children: [
            //     Expanded(
            //       child: TextButton(
            //         onPressed: () => Get.back(),
            //         child: Text(
            //           'Cancel',
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
            //           // Implement continue logic
            //           controller.nextStep();
            //           Get.to(() => SpecializedProfileStep2());
            //         },
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.green,
            //           padding: EdgeInsets.symmetric(vertical: 16),
            //         ),
            //         child: Text(
            //           'Continue',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
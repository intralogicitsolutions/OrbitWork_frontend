import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/profile/specialized_profile_controller.dart';

class SpecializedProfileStep5 extends StatelessWidget{
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text(
              'Step ${controller.currentStep.value + 1 } of ${controller.totalSteps}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            )),
            SizedBox(height: 24),
            Center(
              child: Image.asset(
                'assets/icon/letter.png',
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Review your specialized profile before publishing. particularly the Work History where projects were automatically updated.'),
            ),
            // Spacer(),
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
            //       flex: 2,
            //       child: ElevatedButton(
            //         onPressed: () {
            //           //controller.nextStep();
            //           // Get.to(() => SpecializedProfileStep5());
            //         },
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.green,
            //           padding: EdgeInsets.symmetric(vertical: 16),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(8),
            //           ),
            //         ),
            //         child: Text(
            //           'Review Specialized Profile',
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
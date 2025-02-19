import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/widgets/step_indicator.dart';

import '../controllers/profile/specialized_profile_controller.dart';
import '../views/createProfile/specialized_profile_tab/specialized_profile_1.dart';
import '../views/createProfile/specialized_profile_tab/specialized_profile_2.dart';
import '../views/createProfile/specialized_profile_tab/specialized_profile_3.dart';
import '../views/createProfile/specialized_profile_tab/specialized_profile_4.dart';
import '../views/createProfile/specialized_profile_tab/specialized_profile_5.dart';

class SpecializedProfileContainer extends StatelessWidget {
  //final controller = Get.find<SpecializedProfileController>();
  final SpecializedProfileController controller = Get.put(SpecializedProfileController());

  final List<Widget> steps = [
    SpecializedProfileStep1(),
    SpecializedProfileStep2(),
    SpecializedProfileStep3(),
    SpecializedProfileStep4(),
    SpecializedProfileStep5(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
        title: Text('Create a Specialized Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => steps[controller.currentStep.value]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Obx(() => StepIndicator(
              currentStep: controller.currentStep.value,
              totalSteps: controller.totalSteps,
            )),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Obx(
           () {
            return Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      controller.previousStep();
                     // Get.back();
                    },
                    child: Text(
                      controller.currentStep.value == 0 ? 'Cancle':'Back',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                Expanded(
                  flex: controller.currentStep.value == 4 ? 2 : 1,
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement next step logic
                      controller.nextStep();
                      //Get.to(() => SpecializedProfileStep3());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Obx(() {
                        return Text(
                          controller.currentStep.value == 0 ? 'Continue': controller.currentStep.value == 4 ? 'Review Specialized Profile':'Save & Continue',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}

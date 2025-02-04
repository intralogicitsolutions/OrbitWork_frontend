import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/widgets/custom_appbar.dart';
import 'package:orbitwork/widgets/step_indicator.dart';

import '../controllers/user_profile_controller.dart';
import '../views/createProfile/freelancing_setup.dart';
import '../views/createProfile/profile_setup.dart';

class ProfileSetupContainer extends StatelessWidget{
  final ProfilesController controller = Get.put(ProfilesController());

  final List<Widget> steps = [
    ProfileSetup(), // Step 1
    ProfileSetupView(), // Step 2
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isProfile: true,
        title: 'Create Your Profile',
        rightIcon:  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded)),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => controller.previousStep(),
              ),
              Row(
                children: [
                  TextButton(
                    child: const Text('Skip', style: TextStyle(color: Colors.green),),
                    onPressed: () => controller.nextStep(),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => controller.nextStep(),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

}
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_profile_controller.dart';
import '../../models/user_profile_model.dart';
import '../../widgets/step_indicator.dart';

class ProfileSetupView extends GetView<ProfilesController> {
  final ProfilesController controller = Get.put(ProfilesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Got it. What\'s your biggest\ngoal for freelancing?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Different people come to Upwork for various reasons. We want to highlight the opportunities that fit your goals best while still showing you all the possibilities.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Options
                    _buildOptionCard(
                      'To earn my main income',
                      'assets/icon/salary.png',
                      FreelanceGoal.income,
                    ),

                    const SizedBox(height: 16),

                    _buildOptionCard(
                      'To earn extra income',
                      'assets/icon/money.png',
                      FreelanceGoal.moneyOnSide,
                    ),
                    const SizedBox(height: 16),

                    _buildOptionCard(
                      'To get experience, for a full-time job',
                      'assets/icon/gold-medal.png',
                      FreelanceGoal.getExperience,
                    ),

                    const SizedBox(height: 16),

                    _buildOptionCard(
                      'I don\'t have a goal in mind yet',
                      'assets/icon/find-mobile.png',
                      FreelanceGoal.goalInMind,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(String text, String imagePath, FreelanceGoal goal) {
    return Obx(() {
      final isSelected = controller.userProfile.value.freelanceGoal == goal;

      return GestureDetector(
        onTap: () => controller.setFreelanceGoal(goal),
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.green : Colors.grey.shade300,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    imagePath,
                    height: 120,
                    width: 120,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  //const Spacer(),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Radio<FreelanceGoal>(
                  value: goal,
                  groupValue: controller.userProfile.value.freelanceGoal,
                  onChanged: (value) => controller.setFreelanceGoal(value!),
                  activeColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('ProfilesController', ProfilesController));
  }
}

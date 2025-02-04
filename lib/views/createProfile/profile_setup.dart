import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_profile_controller.dart';
import '../../models/user_profile_model.dart';

class ProfileSetup extends GetView<ProfilesController> {
  @override
  final ProfilesController controller = Get.put(ProfilesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'A few quick questions: first,\nhave you freelanced before?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'This lets us know how much help to give you along the way. We won\'t share your answer with anyone else, including potential clients.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 32),

                // Options
                _buildOptionCard(
                  'I am brand new to this',
                  'assets/icon/loupe.png',
                  FreelanceExperience.newUser,
                ),

                const SizedBox(height: 16),

                _buildOptionCard(
                  'I have some experience',
                  'assets/icon/writing.png',
                  FreelanceExperience.someExperience,
                ),
                const SizedBox(height: 16),

                _buildOptionCard(
                  'I am an expert',
                  'assets/icon/programmer.png',
                  FreelanceExperience.expert,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(String text, String imagePath, FreelanceExperience experience) {
    return Obx(() {
      final isSelected =
          controller.userProfile.value.experience == experience;

      return GestureDetector(
        onTap: () => controller.setFreelanceStatus(experience),
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
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Radio<FreelanceExperience>(
                  value: experience,
                  groupValue: controller.userProfile.value.experience,
                  onChanged: (value) => controller.setFreelanceStatus(value!),
                  activeColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

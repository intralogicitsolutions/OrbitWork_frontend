import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_profile_controller.dart';


class ProfileCreationPage extends StatelessWidget {
  final ProfilesController controller = Get.put(ProfilesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           // _buildHeader(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildTitle(),
                    const SizedBox(height: 12),
                    _buildDescription(),
                    const SizedBox(height: 12),
                    _buildHelpLink(),
                    const SizedBox(height: 40),
                    _buildOptions(),
                  ],
                ),
              ),
            ),
           // _buildBackButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'How would you like to tell us about yourself?',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      'We need to get a sense of your education, experience and skills. It\'s quickest to import your information — you can edit it before your profile goes live.',
    style: TextStyle(
      fontSize: 16,
      color: Colors.grey[800],
      height: 1.5,
    ),
    );
  }

  Widget _buildHelpLink() {
    return InkWell(
      onTap: () {},
      child: const Text(
        'How can a profile help me stand out?',
        style: TextStyle(
          fontSize: 18,
          color: Colors.green,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _buildOptions() {
    return Column(
      children: [
        _buildOptionButton(
          onPressed: controller.showResumeUploadSheet,
          text: 'Upload your resume',
          icon: '↑',
          showSubtitle: false,
        ),
        const SizedBox(height: 16),
        _buildOptionButton(
          //onPressed: controller.onManualFill,
          onPressed: () {  // Now it's a valid callback
            controller.currentProfileStep.value = 1;
          },
          text: 'Fill out manually',
          subtitle: '(15 min)',
          showSubtitle: true,
        ),
      ],
    );
  }

  Widget _buildOptionButton({
    required VoidCallback onPressed,
    required String text,
    String? icon,
    String? subtitle,
    required bool showSubtitle,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Text(
                icon,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (showSubtitle && subtitle != null) ...[
              const SizedBox(width: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
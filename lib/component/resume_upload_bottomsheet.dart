import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/user_profile_controller.dart';


class ResumeUploadSheet extends GetView<ProfilesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildDescription(),
          const SizedBox(height: 24),
          _buildChooseFileButton(),
          const SizedBox(height: 16),
          _buildContinueButton(),
          // Add extra padding for bottom safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Add your resume',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      'Use a PDF, Word doc, or rich text file — make sure it\'s 5MB or less.',
    style: TextStyle(
      fontSize: 16,
      color: Colors.grey[700],
      height: 1.5,
    ),
    );
  }

  Widget _buildChooseFileButton() {
    return InkWell(
      onTap: controller.pickFile,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.arrow_upward, color: Colors.green, size: 20),
            SizedBox(width: 8),
            Text(
              'Choose a file',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Obx(() => Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.isFileSelected.value ? () => Get.back() : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          disabledBackgroundColor: Colors.grey[300],
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Continue',
          style: TextStyle(
            color: controller.isFileSelected.value ? Colors.white : Colors.grey[600],
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ));
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/verification_preferences_controller.dart';


class SetupVerificationBottomsheet extends StatelessWidget {
  SetupVerificationBottomsheet({Key? key}) : super(key: key);

  final controller = Get.put(VerificationPreferencesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            _buildAppBar(),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      _buildVerificationMethodsSection(),
                      const SizedBox(height: 40),
                      _buildVerificationFrequencySection(),
                    ],
                  ),
                ),
              ),
            ),

            // Divider
            const Divider(height: 1),

            // Bottom buttons
            _buildBottomButtons(),

            // Bottom indicator
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Get.back(),
          ),
          const Expanded(
            child: Text(
              'Set your verification preferences',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationMethodsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "If we need to verify it's you, which should we try first?",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        _buildRadioOption(
          0,
          'Authenticator app code',
          controller.selectedVerificationMethod,
          controller.setVerificationMethod,
        ),
        _buildRadioOption(
          1,
          'Mobile app notifications',
          controller.selectedVerificationMethod,
          controller.setVerificationMethod,
        ),
        _buildRadioOption(
          2,
          'SMS text messages',
          controller.selectedVerificationMethod,
          controller.setVerificationMethod,
        ),
      ],
    );
  }

  Widget _buildVerificationFrequencySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "When should we verify?",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        _buildRadioOption(
          0,
          'When my login or activity seems risky',
          controller.selectedVerificationFrequency,
          controller.setVerificationFrequency,
        ),
        _buildRadioOption(
          1,
          'At every login and when my login or activity seems risky',
          controller.selectedVerificationFrequency,
          controller.setVerificationFrequency,
          textStyle: const TextStyle(height: 1.3),
        ),
      ],
    );
  }

  Widget _buildRadioOption(
      int value,
      String label,
      RxInt groupValue,
      Function(int) onChanged,
      {TextStyle? textStyle}
      ) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Radio<int>(
            value: value,
            groupValue: groupValue.value,
            onChanged: (int? newValue) {
              if (newValue != null) onChanged(newValue);
            },
            activeColor: Colors.green,
          )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                label,
                style: textStyle ?? const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                side: const BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Obx(() => ElevatedButton(
              onPressed: controller.canSave ? () => Get.back() : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                backgroundColor: Colors.green,
                disabledBackgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}

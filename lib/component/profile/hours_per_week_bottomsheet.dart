import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile/hours_per_week_controller.dart';

class HoursPerWeekBottomsheet extends StatelessWidget {
  final controller = Get.put(HoursPerWeekController());

  HoursPerWeekBottomsheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Availability',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Get.back(),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Hours per week',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Knowing how much you can work helps\nUpwork find the right jobs for you.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'I can currently work',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildRadioOption('More than 30 hrs/week'),
                  _buildRadioOption('Less than 30 hrs/week'),
                  _buildRadioOption('As needed - open to offers'),
                  _buildRadioOption('None'),
                  const SizedBox(height: 24),
                  const Text(
                    'Contract-to-hire',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(() => CheckboxListTile(
                    value: controller.isContractToHire.value,
                    onChanged: controller.toggleContractToHire,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.green,
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'I\'m open to contract-to-hire\nopportunities',
                      style: TextStyle(fontSize: 16),
                    ),
                  )),
                  const Text(
                    'This means you\'ll start with a contract and\nmay later explore a full-time option',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Get.back(),
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
                child: ElevatedButton(
                  onPressed: () {
                    // Implement save logic
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String text) {
    return Obx(() => RadioListTile<String>(
      title: Text(text),
      value: text,
      groupValue: controller.selectedHours.value,
      onChanged: (value) => controller.setHours(value ?? ''),
      contentPadding: EdgeInsets.zero,
      activeColor: Colors.green,
    ));
  }
}
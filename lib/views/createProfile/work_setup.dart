import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/user_profile_controller.dart';


class WorkProfile extends StatelessWidget {
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
                // Main Content
                Text(
                  'And how would you like to work?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Everybody works in different ways, so we have different ways of helping you win work. You can select multiple preferences now and can always change it later!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),

                const SizedBox(height: 24),

                // Work Preferences List
                _buildPreferencesList()

              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildPreferencesList() {
    return Obx(() => Column(
      children: controller.workPreferences.asMap().entries.map((entry) {
        final index = entry.key;
        final preference = entry.value;

        if (preference.isCardStyle) {
          // Card style layout for first two options
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () => controller.togglePreference(index),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (preference.iconPath != null)
                            Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(right: 16),
                              child: Image.asset(
                                preference.iconPath!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          Text(
                            preference.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            preference.description,
                            style: TextStyle(
                              //fontSize: 16,
                              color: Colors.grey[600],
                              height: 1.4,
                            ),
                          ),
                          // Checkbox(
                          //   value: preference.isSelected,
                          //   onChanged: (_) => controller.togglePreference(index),
                          //   activeColor: Colors.green,
                          // ),
                        ],
                      ),
                    ),
                    Checkbox(
                      value: preference.isSelected,
                      onChanged: (_) => controller.togglePreference(index),
                      activeColor: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          // Prefix checkbox layout for contract-to-hire option
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Prefix Checkbox
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: preference.isSelected,
                    onChanged: (_) => controller.togglePreference(index),
                    activeColor: Colors.green,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                const SizedBox(width: 12),
                // Text Content
                Expanded(
                  child: InkWell(
                    onTap: () => controller.togglePreference(index),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          preference.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          preference.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }).toList(),
    ));
  }
}
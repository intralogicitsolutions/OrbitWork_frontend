import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/badges_controller.dart';

class BadgesBottomsheet extends StatelessWidget {
  final controller = Get.put(BadgesController());
   BadgesBottomsheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize controller
   // final controller = Get.put(BadgesController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Badges',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Explanation text
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Badges are attached to your profile after you have completed jobs. Select a badge to learn more about the requirements for each. ',
                      ),
                      TextSpan(
                        text: 'Learn more',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        // Add onTap handler if needed
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Badge Items
                Obx(() => _buildBadgeItem(
                  icon: Icons.arrow_upward,
                  iconColor: Colors.green,
                  title: 'Rising Talent',
                  backgroundColor: Colors.white,
                  borderColor: controller.selectedBadge.value == 'Rising Talent'
                      ? Colors.green
                      : Colors.grey[300]!,
                )),
                const SizedBox(height: 16),

                Obx(() => _buildBadgeItem(
                  icon: Icons.star,
                  iconColor: Colors.blue,
                  title: 'Top Rated',
                  backgroundColor: Colors.white,
                  borderColor: controller.selectedBadge.value == 'Top Rated'
                      ? Colors.green
                      : Colors.grey[300]!,
                )),
                const SizedBox(height: 16),

                _buildBadgeItem(
                  icon: Icons.star,
                  iconColor: Colors.pinkAccent,
                  title: 'Top Rated Plus',
                  backgroundColor: Colors.grey[200]!,
                  borderColor: Colors.grey[200]!,
                  textColor: Colors.grey[500]!,
                ),
                const SizedBox(height: 16),

                Obx(() => _buildBadgeItem(
                  icon: Icons.workspace_premium,
                  iconColor: Colors.amber,
                  title: 'Expert-Vetted',
                  backgroundColor: Colors.white,
                  borderColor: controller.selectedBadge.value == 'Expert-Vetted'
                      ? Colors.green
                      : Colors.grey[300]!,
                )),
                const SizedBox(height: 32),

                // Requirements section
                const Text(
                  'Requirements',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                //_showRisingTalent(),
                Obx(() {
                  switch (controller.selectedBadge.value) {
                    case 'Rising Talent':
                      return _showRisingTalent();
                    case 'Top Rated':
                      return _showTopRated();
                    case 'Expert-Vetted':
                      return _showExpertVetted();
                    default:
                      return _showRisingTalent();
                  }
                }),
              ],
            ),
          ),

          // Bottom fixed button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Close',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Bottom indicator
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              width: 60,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showRisingTalent(){
    return Column(
      children: [
        Obx(() => _buildRequirementItem(
          isComplete: controller.isProfileComplete.value,
          text: '100% complete profile',
        )),
        const SizedBox(height: 16),

        Obx(() => _buildRequirementItem(
          isComplete: controller.noAccountHolds.value,
          text: 'No account holds in the last 90 days',
        )),
      ],
    );
  }

  Widget _showTopRated(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => _buildRequirementItem(
          isComplete: controller.jobSuccessScore.value,
          text: 'At least 90% Job Success Score',
        )),
        const SizedBox(height: 16),

        Obx(() => _buildRequirementItem(
          isComplete: controller.isProfileComplete.value,
          text: '100% complete profile',
        )),
        const SizedBox(height: 16),

        Obx(() => _buildRequirementItem(
          isComplete: controller.noAccountHolds.value,
          text: 'No account holds in the last 90 days',
        )),
        const SizedBox(height: 16,),

        const Text(
          'Eligible weeks',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        Text('0 of 16')
      ],
    );
  }

  Widget _showExpertVetted(){
    return Column(
      children: [
        Obx(() => _buildRequirementItem(
          isComplete: controller.expertPrescreening.value,
          text: 'Expert Prescreening',
        )),
      ],
    );
  }

  // Helper widget for badge items
  Widget _buildBadgeItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Color backgroundColor,
    required Color borderColor,
    Color textColor = Colors.black,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 16,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        onTap: () {
          controller.selectedBadge.value = title;
        },
      ),
    );
  }

  // Helper widget for requirement items
  Widget _buildRequirementItem({
    required bool isComplete,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isComplete ? Icons.check : Icons.close,
          color: isComplete ? Colors.green : Colors.black,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}


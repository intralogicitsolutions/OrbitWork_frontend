import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/privacy_preferences_controller.dart';

class PrivacyPreferences extends StatelessWidget {
  final PrivacyPreferencesController controller = Get.put(PrivacyPreferencesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Strictly Necessary Cookies'),
            SizedBox(height: 8),
            Text('Always active'),
            Text('These cookies are essential for users to browse or use our website and its features, such as accessing secure areas of the site.'),
            SizedBox(height: 16),
            Text('Performance Cookies'),
            SizedBox(height: 8),
            Obx(
                  () => Switch(
                value: controller.performanceCookiesEnabled,
                onChanged: controller.togglePerformanceCookies,
              ),
            ),
            Text('These cookies allow us to count visits in traffic sources so we can measure and improve the performance of our website.'),
            SizedBox(height: 16),
            Text('Functional Cookies'),
            SizedBox(height: 8),
            Obx(
                  () => Switch(
                value: controller.functionalCookiesEnabled,
                onChanged: controller.toggleFunctionalCookies,
              ),
            ),
            Text('These cookies enable the website to provide enhanced functionality and personalisation.'),
            SizedBox(height: 16),
            Text('Targeting Cookies'),
            SizedBox(height: 8),
            Obx(
                  () => Switch(
                value: controller.targetingCookiesEnabled,
                onChanged: controller.toggleTargetingCookies,
              ),
            ),
            Text('These cookies track users\' online activity to help advertisers deliver more relevant advertising or to measure the effectiveness of their campaigns.'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: controller.rejectAll,
                  child: Text('Reject All'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: controller.confirmChoices,
                  child: Text('Confirm my choices'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
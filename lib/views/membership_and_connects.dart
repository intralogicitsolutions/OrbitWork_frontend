import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../comms/url_launcher_helper.dart';
import '../controllers/membership_and_connects_controller.dart';

class MembershipAndConnects extends StatelessWidget {
  final MembershipController controller = Get.put(MembershipController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Membership & Connects',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Membership & Connects',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 24),
              _buildCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'Current plan',
            Obx(() => Text(
                  controller.membership.value.planName,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )),
            _buildChangePlanButton(),
          ),
          Divider(height: 1),
          _buildSection(
            'Current billing cycle',
            Obx(() => Text(
                  controller.formatDateRange(),
                  style: TextStyle(fontSize: 14),
                )),
          ),
          Divider(height: 1),
          _buildSection(
            'Connects balance',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                      controller.membership.value.connectsBalance.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )),
                SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(text: 'Learn more about how to earn and use '),
                      TextSpan(
                        text: 'Connects',
                        style: TextStyle(
                          color: Colors.green,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.green,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => UrlLauncherHelper.openUrl('https://www.google.com'),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildViewHistoryButton()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content, [Widget? extraWidget]) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          content,
          if (extraWidget != null) SizedBox(height: 16),
          if (extraWidget != null) extraWidget,
        ],
      ),
    );
  }

  Widget _buildChangePlanButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: controller.changePlan,
        child: Text(
          'Change Plan',
          style: TextStyle(
            color: Colors.green,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 8),
          side: BorderSide(color: Colors.green),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildViewHistoryButton() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: controller.viewConnectsHistory,
        child: Text(
          'View Connects History',
          style: TextStyle(
            color: Colors.green,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }
}

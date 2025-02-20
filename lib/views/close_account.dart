import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/close_account_controller.dart';

class CloseAccount extends StatelessWidget {
  final CloseAccountController controller = Get.put(CloseAccountController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Close account',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () => Get.back(), icon: Icon(Icons.more_vert_rounded)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade400)),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Close account',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Thank you for using Orbitwork.',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text('Why are you closing your account?'),
                  SizedBox(height: 10,),
                  _buildRadioOption('I finished my work and don\'t need Orbitwork anymore'),
                  _buildRadioOption('I couldn\'t find the jobs I wanted'),
                  _buildRadioOption('I found a good client on Orbitwork, but we\'re working directly together'),
                  _buildRadioOption('I want to change my username'),
                  _buildRadioOption('Orbitwork is not easy to use'),
                  _buildRadioOption('I signed up for the wrong type of account'),
                  _buildRadioOption('Closing duplicate account'),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                              )
                            ),
                            child: Text('Close account', style: TextStyle(color: Colors.white),)),
                      ),
                      SizedBox(width: 20,),
                      OutlinedButton(onPressed: () {Get.back();},
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                            side: BorderSide.none,
                          ),
                          child: Text('Cancel', style: TextStyle(color: theme.primaryColor),))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String text) {
    return Obx(() => RadioListTile<String>(
          title: Text(text),
          value: text,
          groupValue: controller.selectReason.value,
          onChanged: (value) => controller.setReason(value ?? ''),
          contentPadding: EdgeInsets.zero,
          activeColor: Colors.green,
        ));
  }
}

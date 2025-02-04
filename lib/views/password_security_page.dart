import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/password_and_security_controller.dart';

class PasswordAndSecurity extends StatelessWidget {
  final PasswordAndSecurityController controller =
      Get.put(PasswordAndSecurityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password & security'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                'Upwork password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('You\'ve set an Upwork password.'),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding:
                            EdgeInsets.zero, // Removes the horizontal space
                      ),
                      onPressed: controller.changePassword,
                      child: Text(
                        'Change password',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Biometric authentication',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Obx(
                    () => Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        activeColor: Colors.green,
                        // thumbColor: MaterialStateProperty.all(Colors.white),
                        value: controller.biometricAuthenticationEnabled,
                        onChanged: controller.toggleBiometricAuthentication,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                  'Use Face or Fingerprint ID instead of a password to authenticate in the mobile app.'),
              Divider(
                height: 48,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Two-step verification',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                        color: Colors.green,
                      ))
                  // Obx(
                  //       () => Switch(
                  //     value: controller.twoStepVerificationEnabled,
                  //     onChanged: controller.toggleTwoStepVerification,
                  //   ),
                  // ),
                ],
              ),

              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SMS text messages',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Obx(
                    () => Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        activeColor: Colors.green,
                        value: controller.smsTextMessagesEnabled,
                        onChanged: controller.toggleSmsTextMessages,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              Text('Verify one-time codes sent to your mobile number.'),

              Divider(
                height: 48,
              ),
              // SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Authenticator app codes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Obx(
                    () => Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        activeColor: Colors.green,
                        value: controller.authenticatorAppCodesEnabled,
                        onChanged: controller.toggleAuthenticatorAppCodes,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              Text(
                  'Verify one-time codes generated in your preferred third party authenticator app.'),
              Divider(
                height: 48,
              ),
              //SizedBox(height: 16),
              Text(
                'Security question and answer',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              Text(
                  'You\'ve set up a question to answer when you can\'t use your mobile device for two-step verification.'),
              TextButton(
                onPressed: controller.updateSecurityQuestionAndAnswer,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // Removes the horizontal space
                ),
                child: Text(
                  'Update question and answer',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.green,
                      color: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

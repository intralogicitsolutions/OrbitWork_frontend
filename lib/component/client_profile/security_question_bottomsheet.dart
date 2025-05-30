import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../client_profile_controller/security_question_controller.dart';

class SecurityQuestionBottomsheet extends StatelessWidget {
  final SecurityQuestionController controller = Get.put(SecurityQuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: controller.cancel,
        ),
        title: Text(
          'Security question',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description Text
            Text(
              'You\'ll be prompted to answer your security question when we need to verify your identity, so be sure to choose a question only you know the answer to.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
            ),

            SizedBox(height: 32),

            // Question Label
            Text(
              'Question',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 8),

            // Question Dropdown
            Obx(() => GestureDetector(
              onTap: controller.showQuestionDropdown,
              child: Container(
                height: 40,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Get.theme.secondaryHeaderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        controller.selectedQuestion.value,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),
            )),

            SizedBox(height: 24),

            // Answer Label
            Text(
              'Answer',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 8),

            // Answer TextField
            SizedBox(
              height: 40,
              child: TextField(
                controller: controller.answerController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Get.theme.secondaryHeaderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF4CAF50), width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),

            SizedBox(height: 32),

            // Account Lock Understanding Checkbox
            Obx(() => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: controller.toggleAccountLockUnderstanding,
                  child: Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      color: controller.isAccountLockUnderstood.value
                          ? Color(0xFF4CAF50)
                          : Colors.white,
                      border: Border.all(
                        color: controller.isAccountLockUnderstood.value
                            ? Color(0xFF4CAF50)
                            : Colors.grey[400]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: controller.isAccountLockUnderstood.value
                        ? Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                        : null,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: controller.toggleAccountLockUnderstanding,
                    child: Text(
                      'I understand my account will be locked if I am unable to answer this question',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ],
            )),

            SizedBox(height: 20),

            // Keep Logged In Checkbox
            Obx(() => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: controller.toggleKeepLoggedIn,
                  child: Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      color: controller.keepLoggedIn.value
                          ? Color(0xFF4CAF50)
                          : Colors.white,
                      border: Border.all(
                        color: controller.keepLoggedIn.value
                            ? Color(0xFF4CAF50)
                            : Colors.grey[400]!,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: controller.keepLoggedIn.value
                        ? Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                        : null,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: controller.toggleKeepLoggedIn,
                    child: Text(
                      'Keep me logged in on this device',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ],
            )),

            SizedBox(height: 60),
          ],
        ),
      ),

      // Bottom Buttons
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: controller.cancel,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4CAF50),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: controller.save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 2,),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
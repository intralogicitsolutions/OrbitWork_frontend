import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/security_question_controller.dart';

class setQuestionAnswerBottomsheet extends StatelessWidget {
  setQuestionAnswerBottomsheet({Key? key}) : super(key: key);

  final controller = Get.put(SecurityQuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            _buildAppBar(),

            // Banner image
            _buildBannerImage(),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      _buildHeaderSection(),
                      const SizedBox(height: 24),
                      _buildQuestionSection(context),
                      const SizedBox(height: 16),
                      _buildAnswerSection(),
                      const SizedBox(height: 16),
                      _buildCheckboxesSection(),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom buttons
            _buildBottomButtons(),

            // Bottom indicator
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 8, bottom: 8),
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
              'Add a security question',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
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

  Widget _buildBannerImage() {
    return Container(
      height: 150,
      width: double.infinity,
      color: const Color(0xFF006651), // Dark green color
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [

            Image.asset(
              'assets/icon/private.png',
              height: 60,
              width: 60,
            ),
            // Stylized device/document background
            // Container(
            //   width: 120,
            //   height: 80,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            // ),
            //
            // // Lock icon
            // Positioned(
            //   bottom: 20,
            //   child: Container(
            //     padding: const EdgeInsets.all(8),
            //     decoration: const BoxDecoration(
            //       color: Color(0xFFFFA500), // Orange color for lock
            //       shape: BoxShape.circle,
            //     ),
            //     child: const Icon(
            //       Icons.lock,
            //       color: Colors.white,
            //       size: 24,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Add a security question',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "This method helps us verify it's really you.",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Set your question',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        // Container(
        //   decoration: BoxDecoration(
        //     border: Border.all(color: Colors.grey.shade400),
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        //   child: Obx(() => DropdownButtonHideUnderline(
        //     child: DropdownButton<String>(
        //       value: controller.selectedQuestion.value.isEmpty ? null : controller.selectedQuestion.value,
        //       hint: const Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 16),
        //         child: Text("Your favorite sports team"),
        //       ),
        //       icon: const Padding(
        //         padding: EdgeInsets.only(right: 16),
        //         child: Icon(Icons.arrow_drop_down),
        //       ),
        //       isExpanded: true,
        //       style: const TextStyle(
        //         color: Colors.black,
        //         fontSize: 16,
        //       ),
        //       items: controller.securityQuestions.map((String question) {
        //         return DropdownMenuItem<String>(
        //           value: question,
        //           child: Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 16),
        //             child: Text(question),
        //           ),
        //         );
        //       }).toList(),
        //       onChanged: (String? newValue) {
        //         if (newValue != null) {
        //           controller.selectedQuestion.value = newValue;
        //         }
        //       },
        //     ),
        //   )),
        // ),
        GestureDetector(
          onTap: () => _showSecurityQuestionBottomSheet(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.selectedQuestion.value.isEmpty
                      ? "Select a security question"
                      : controller.selectedQuestion.value,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            )),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Set your new answer',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          child: TextField(
            onChanged: (value) => controller.answer.value = value,
            decoration: InputDecoration(
              hintText: 'Enter your answer',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxesSection() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Checkbox(
              value: controller.understandLockout.value,
              activeColor: Colors.green,
              onChanged: (bool? value) {
                if (value != null) {
                  controller.understandLockout.value = value;
                }
              },
            )),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  'I understand my account will be locked if I am unable to answer this question',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Checkbox(
              value: controller.keepLoggedIn.value,
              activeColor: Colors.green,
              onChanged: (bool? value) {
                if (value != null) {
                  controller.keepLoggedIn.value = value;
                }
              },
            )),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  'Keep me logged in on this device',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(16),
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

  void _showSecurityQuestionBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.9,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Select a Security Question",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(onPressed: () {
                  Get.back();
                }, icon: Icon(Icons.close))
              ],
            ),

            Expanded(
              child: Obx(() => ListView(
                shrinkWrap: true,
                children: controller.securityQuestions.map((question) {
                  return RadioListTile<String>(
                    activeColor: Get.theme.primaryColor,
                    title: Text(question),
                    value: question,
                    groupValue: controller.selectedQuestion.value,
                    onChanged: (value) {
                      controller.selectedQuestion.value = value!;
                      Get.back(); // Close BottomSheet after selection
                    },
                  );
                }).toList(),
              )),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/client_profile_controller/feedback_controller.dart';

class FeedbackBottomsheet extends StatelessWidget{
  final FeedbackController controller = Get.put(FeedbackController());

  final List<String> feedbackOptions = [
    'Idea',
    'Suggestion',
    'Report an Issue',
    'General Feedback'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                    child: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close))),
                Text('What type of feedback would you like to share?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Obx(() {
                    return Column(
                      children: feedbackOptions.map((option) {
                        return RadioListTile(
                          title: Text(option),
                            value: option,
                            groupValue: controller.selectedFeedbackType.value,
                            activeColor: Get.theme.primaryColor,
                            onChanged: (value) =>
                            controller.selectedFeedbackType.value = value!,);
                      },).toList(),
                    );
                  },
                ),
                SizedBox(height: 16),
                Text('What would you like to share with us?', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 8),
                TextField(
                  maxLines: 4,
                  onChanged: (value) => controller.feedbackText.value = value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Type your message...',
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: Get.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Get.theme.primaryColor
                    ),
                    onPressed: () => controller.submitFeedback(),
                    child: Text('Submit', style: TextStyle(
                      color: Colors.white
                    ),),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/client_profile_controller/feedback_controller.dart';

class RateBottomsheet extends StatelessWidget{
  final FeedbackController controller = Get.put(FeedbackController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(onPressed: () {
              Get.back();
            }, icon: Icon(Icons.close)),
          ),
          Text(
            'How would you rate your experience with Upwork today?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(onPressed: () => controller.openFeedbackSheet(),
                  icon: Icon(Icons.star_border, size: 32,));
            }),
          )
        ],
      ),
    );
  }

}
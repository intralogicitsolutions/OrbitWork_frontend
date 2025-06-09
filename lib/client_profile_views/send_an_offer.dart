import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../client_profile_controller/stay_safe_controller.dart';

class SendOfferPage extends StatefulWidget {
  @override
  State<SendOfferPage> createState() => _SendOfferPageState();
}

class _SendOfferPageState extends State<SendOfferPage> {
  final StaySafeController controller = Get.put(StaySafeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.showStaySafeBottomSheet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Send an Offer',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            // Account blocked messages (as shown in screenshot)
            _buildWarningMessage(
              'We have blocked your account. Find out more or contact customer support.',
            ),
            SizedBox(height: 16),
            _buildWarningMessage(
              'Your account has been suspended. To learn more, please view your support requests on Upwork Help.',
            ),
            SizedBox(height: 16),
            _buildWarningMessage(
              'Your account is currently suspended. Please contact Upwork support.',
            ),

            Spacer(),

            // Button to show bottom sheet
            // Padding(
            //   padding: EdgeInsets.all(20),
            //   child: ElevatedButton(
            //     onPressed: controller.showStaySafeBottomSheet,
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.green,
            //       foregroundColor: Colors.white,
            //       padding: EdgeInsets.symmetric(vertical: 16),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //       minimumSize: Size(double.infinity, 50),
            //     ),
            //     child: Text(
            //       'Show Stay Safe Bottom Sheet',
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningMessage(String message) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber,
            color: Colors.red[700],
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                children: _parseMessageWithLinks(message),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _parseMessageWithLinks(String message) {
    // Simple parsing for underlined text (you can enhance this for real links)
    List<TextSpan> spans = [];
    List<String> parts = message.split(RegExp(r'(Find out more|contact customer support|your support requests|Upwork support)'));

    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(text: parts[i]));
      if (i < parts.length - 1) {
        // Add underlined link text
        String linkText = '';
        if (message.contains('Find out more')) linkText = 'Find out more';
        else if (message.contains('contact customer support')) linkText = 'contact customer support';
        else if (message.contains('your support requests')) linkText = 'your support requests';
        else if (message.contains('Upwork support')) linkText = 'Upwork support';

        spans.add(TextSpan(
          text: linkText,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.black87,
          ),
        ));
      }
    }

    return spans;
  }
}
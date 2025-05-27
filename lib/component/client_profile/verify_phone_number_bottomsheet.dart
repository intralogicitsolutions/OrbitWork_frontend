import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/contact_info_controller.dart';

class VerifyPhoneNumberBottomsheet extends StatelessWidget{
  final ContactInfoController controller = Get.put(ContactInfoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.close))
        ],
      ),
      body: Column(
        children: [
          Text('Please verify your phone number', style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.w500
          ),),
          SizedBox(height: 20,),
          Text('We\'ll text you a code to verify your number.', style: TextStyle(
            fontWeight: FontWeight.w300
          ),),
          SizedBox(height: 12,),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Implement country code picker
                    },
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Row(
                        children: [
                          Image.asset('assets/icon/flag-india.png',
                              width: 24, height: 16),
                          const SizedBox(width: 4),
                          Expanded(child: const Icon(Icons.keyboard_arrow_down_rounded)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    //onChanged: controller.user.value.phone,
                    controller:
                    TextEditingController(text: controller.user.value.phone),
                    decoration: InputDecoration(
                        hintText: 'Enter number',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        // prefixText: '+91 ',
                        suffix: IconButton(
                            onPressed: () {}, icon: Icon(Icons.close))),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12,),
          Text('Messaging rates may apply. We\'ll use this number for verification purposes only - we won\'t share it or use it for marketing.'),
          SizedBox(height: 10,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Button action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Get.theme.primaryColor,
                // backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Send code",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
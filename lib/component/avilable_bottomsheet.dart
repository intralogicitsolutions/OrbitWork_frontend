import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class AvilableBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Container(
      height: Get.height * 0.5,
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Available', style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500
                ),),
                IconButton(onPressed: () {
                  Get.back();
                }, icon: Icon(Icons.close))
              ],
            ),
            SizedBox(height: 24,),
            Text('You earned it! Where should we deliver your balance?'),
            Divider(height: 40,),
            Container(
              width: Get.width,
              child: OutlinedButton(onPressed: () {Get.toNamed(AppRoutes.getPaid);},
                  style: OutlinedButton.styleFrom(
                    padding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                    side: BorderSide(color: Get.theme.primaryColor, width: 2),
                    foregroundColor: Get.theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Set up payments', style: TextStyle(
                color: Get.theme.primaryColor
              ),)),
            ),
            SizedBox(height: 24,),
            Center(
              child: RichText(text: TextSpan(
                style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500,
                  color: Colors.grey
                ),
                children: [
                  TextSpan(
                    text: 'No transactions in the last 30 days. '
                  ),
                  TextSpan(
                    text: 'View all transactions >',
                    style: TextStyle(
                      color: Get.theme.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: Get.theme.primaryColor
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.toNamed(AppRoutes.transactionHistory, arguments: true),
                  )
                ]
              )),
            ),
            Spacer(),
            Text('Note: this report is updated every hour.', style: TextStyle(fontSize: 12),)
          ],
        ),
      ),
    );
  }

}
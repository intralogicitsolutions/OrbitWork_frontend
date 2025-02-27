import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkInProgressBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: Get.height * 0.4,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
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
                Text('Work in progress', style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500
                ),),
                IconButton(onPressed: () {
                  Get.back();
                }, icon: Icon(Icons.close))
              ],
            ),
            SizedBox(height: 24,),
            Text('When will I get paid?', style: TextStyle(
              color: theme.primaryColor,
              decoration: TextDecoration.underline,
              decorationColor: theme.primaryColor,
              fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 24,),
            Center(
              child: Text('You have no work in progress',
                style: TextStyle(
                fontSize: 20,  fontWeight: FontWeight.w500, color: Colors.grey
              ),),
            ),
            Spacer(),
            Text('Note: this report is updated every hour.', style: TextStyle(
              fontSize: 12
            ),)
          ],
        ),
      ),
    );
  }

}
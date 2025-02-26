import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobSuccessScoreBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Job Success Score', style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500
                ),),
                IconButton(onPressed: () {
                  Get.back();
                }, icon: Icon(Icons.close))
              ],
            ),
            SizedBox(height: 24,),
            Text('Your Job Success Score is based on several factors, including clients\' overall satisfaction with your work.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
            SizedBox(height: 12,),
            Text('We calculate your score daily based on 6-, 12-, and 24-month timeframes. Your profile will display the highest score of these timeframes. A high score can help boost your visibility and win more clients.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 24,),
            Container(
              width: Get.width,
              child: ElevatedButton(onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.green,
                    minimumSize: const Size(40, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Close', style: TextStyle(color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }

}
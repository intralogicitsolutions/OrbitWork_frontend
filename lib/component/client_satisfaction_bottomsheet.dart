import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientSatisfactionBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client satisfaction', style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500
        ),),
        actions: [
          IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.close))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('There are 3 components that shape client satisfaction. You must consistently receive positive feedback on these 3 components.'),
            SizedBox(height: 24,),
            Text('How it works', style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 16,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.circle, size: 10,),
                SizedBox(width: 5,),
                Expanded(
                    child: Text('when you receive 3 or more stars from a client, the job is considered successful. However, if private feedback or the contract ending reason is negative, either will override public feedback and the job will be considered unsuccessful.')),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.circle, size: 10,),
                SizedBox(width: 5,),
                Expanded(
                    child: Text('\$0 contracts with negative client satisfaction will be included in your score and considered unsuccessful.'))
              ],
            ),
            SizedBox(height: 24,),
            Text('Tips',style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500
            ),),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.'),
                SizedBox(width: 5,),
                RichText(text: TextSpan(
                  style: TextStyle(
                    color: Get.theme.primaryColor
                  ),
                  children: [
                    TextSpan(
                      text: 'When your work is finished, encourage clients to end contracts so both parties can '
                    ),
                    TextSpan(
                      text: 'Give Feedback.',
                      style: TextStyle(
                        color: Get.theme.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: Get.theme.primaryColor
                      )
                    ),
                    TextSpan(text: ' Clients are required to leave feedback if they end a contract.')
                  ]
                )),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text('2.'),
                SizedBox(width: 5,),
                RichText(text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'If you end a contract, then clients have 14 days to leave public feedback. Jobs without feedback are excluded from your score.'
                    )
                  ]
                ))
              ],
            ),
            SizedBox(height: 16,),
            Row(
              children: [
                Text('3. '),
                RichText(text: TextSpan(
                  style: TextStyle(
                    color: Get.theme.secondaryHeaderColor
                  ),
                  children: [
                    TextSpan(
                      text: 'Explore learning hub resources such as '
                    ),
                    TextSpan(
                      text: 'Intro to Orbitwork',
                      style: TextStyle(
                        color: Get.theme.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: Get.theme.primaryColor
                      )
                    )
                  ]
                ))
              ],
            ),
            SizedBox(height: 24,),
            ElevatedButton(onPressed: () {
              Get.back();
            },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.green,
                  minimumSize: const Size(40, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Close', style: TextStyle(
              color: Colors.white
            ),)),
          ],
        ),
      ),
    );
  }

}
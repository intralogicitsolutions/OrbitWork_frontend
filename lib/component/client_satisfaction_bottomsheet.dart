import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/feedback_card.dart';

class ClientSatisfactionBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('There are 3 components that shape client satisfaction. You must consistently receive positive feedback on these 3 components.',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                      fontSize: 16
                    ),
                    ),
                    SizedBox(height: 24,),
                    FeedbackCard(
                        title: 'Public feedback',
                        subtitle: 'Viewable as star ratings',
                        iconName: 'star',
                        rating: '5.0',
                        hasRating: true),
                    SizedBox(height: 16),
                    FeedbackCard(
                        title: 'Private feedback',
                        subtitle: 'Not publicly viewable',
                        iconName: 'visibility_off',
                        rating: '',
                        hasRating: false),
                    SizedBox(height: 16),
                    FeedbackCard(
                        title: 'Contract ending reason',
                        subtitle: 'Not publicly viewable',
                        iconName: 'visibility_off',
                        rating: '',
                        hasRating: false),
                    SizedBox(height: 16),
                    Text('How it works', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500
                    ),),
                    SizedBox(height: 16,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(Icons.circle, size: 8, color: Colors.grey.shade600,),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                            child: Text('when you receive 3 or more stars from a client, the job is considered successful. However, if private feedback or the contract ending reason is negative, either will override public feedback and the job will be considered unsuccessful.',
                            style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300
                            ),
                            )),
                      ],
                    ),
                    SizedBox(height: 5.0,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(Icons.circle, size: 8, color: Colors.grey.shade600,),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                            child: Text('\$0 contracts with negative client satisfaction will be included in your score and considered unsuccessful.',
                            style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300
                            ),
                            ))
                      ],
                    ),
                    SizedBox(height: 24,),
                    Text('Tips',style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500
                    ),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('1. ', style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16
                        ),),
                        Expanded(
                          child: RichText(text: TextSpan(
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('2. ',style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16
                        ),),
                        Expanded(
                          child: RichText(text: TextSpan(
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                fontSize: 16
                              ),
                            children: [
                              TextSpan(
                                text: 'If you end a contract, then clients have 14 days to leave public feedback. Jobs without feedback are excluded from your score.'
                              )
                            ]
                          )),
                        )
                      ],
                    ),
                    SizedBox(height: 16,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('3. ',style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16
                        ),),
                        Expanded(
                          child: RichText(text: TextSpan(
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16
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
                          )),
                        )
                      ],
                    ),
                    SizedBox(height: 24,),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                  onPressed: () {
                Get.back();
              },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.green,
                    minimumSize: Size(Get.width, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('Close', style: TextStyle(
                      color: Colors.white
                  ),)),
            ),
          ],
        ),
      ),
    );
  }

}
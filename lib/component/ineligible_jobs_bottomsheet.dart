import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Explore_work_bottomsheet.dart';

class IneligibleJobsBottomsheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ineligible jobs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close)),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jobs with no earnings', style: TextStyle(
                              fontSize: 16
                            ),),
                            SizedBox(height: 12,),
                            Text('Jobs with no earnings or those canceled before payment do not count toward Job Success Score unless the client leaves negative feedback.',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16
                            ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.folder_copy_outlined),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jobs with no feedback', style: TextStyle(
                              fontSize: 16
                            ),),
                            SizedBox(height: 12,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.circle, size: 8, color: Colors.grey.shade600,),
                                ),
                                Expanded(
                                  child: RichText(text: TextSpan(
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          height: 1.5,
                                        fontSize: 16
                                      ),
                                      children: [
                                        TextSpan(
                                            text: 'Jobs without client feedback aren\'t eligible for Job Success Score, except jobs that meet the requirements of ',
                                        ),
                                        TextSpan(
                                            text: 'long-term relationships',
                                            style: TextStyle(
                                                color: Get.theme.primaryColor,
                                                decoration: TextDecoration.underline,
                                                decorationColor: Get.theme.primaryColor
                                            ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Get.bottomSheet(ExploreWorkBottomsheet(),
                                                  isScrollControlled: true, isDismissible: true);
                                            },
                                        )
                                      ]
                                  )),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.circle, size: 8,color: Colors.grey.shade600,),
                                ),
                                Expanded(
                                  child: RichText(text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      height: 1.5,
                                      fontSize: 16
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Mid-contract feedback', style: TextStyle(
                                       color: Get.theme.primaryColor,
                                       decoration: TextDecoration.underline,
                                       decorationColor: Get.theme.primaryColor
                                      )
                                      ),
                                      TextSpan(
                                        text: ' is publicly viewable and shows within Work History on your profile, but it does not factor in to your Job Success Score.'
                                      )
                                    ]
                                  )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.delete_outline_sharp),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jobs with feedback removed', style: TextStyle(
                              fontSize: 16,
                            ),),
                            SizedBox(height: 12,),
                            Text('Per Orbit\'s policy, we can remove abusive client feedback upon request or when we delete and confirm a fraudulent client.',
                            style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade600
                            ),),
                            Text('Learn more about feedback removal', style: TextStyle(
                              fontSize: 16, color: Get.theme.primaryColor, decoration: TextDecoration.underline, decorationColor: Get.theme.primaryColor
                            ),)
                          ],
                        ),
                      )
                    ],
                  )
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
    );
  }
}

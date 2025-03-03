import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/timeline_widget.dart';


class ContractLengthBottomSheet extends StatelessWidget {

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
                'Contract length',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //Divider(),
                  SizedBox(height: 16),
                  Text(
                      'A single contract with a payment every 90 days is considered an extra "job" toward your Job Success Score, up to a maximum of 8 "jobs". See the 3 examples below.',
                  style: TextStyle(
                    fontSize: 16, color: Colors.grey.shade700
                  ),
                  ),
                  SizedBox(height: 24,),
                  Row(
                    children: [
                      Container(height: 4,
                        width: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black,),),
                      SizedBox(width: 10,),
                      Expanded(child: Text(
                          'A black bar represents a successful "job" toward your score', style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16
                      ),))
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Container(height: 4,
                        width: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.red,),),
                      SizedBox(width: 10,),
                      Expanded(child: Text(
                          'A red bar represents an unsuccessful "job" included your score', style: TextStyle(
                        fontSize: 16, color: Colors.grey.shade700
                      ),))
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Container(height: 4,
                        width: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey[300],),),
                      SizedBox(width: 10,),
                      Expanded(child: Text(
                          'A grey bar represents a period where no additional "jobs" are included in your score',
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade700),))
                    ],
                  ),
                  SizedBox(height: 24,),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Example 1: The contract below would be considered 3 "jobs".',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 24,),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Timeline(
                                  dollarCount: 3,
                                  stepCount: 4,
                                  labels: [
                                    'Start',
                                    '90 days',
                                    '180 days',
                                    '270 days'
                                  ],
                                  lineColors: [
                                    Colors.black, // Line between dot 1 & 2
                                    Colors.black, // Line between dot 2 & 3
                                    Colors.black // Line between dot 3 & 4
                                  ],
                                  dotColor: Colors.black,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Icon(Icons.thumb_up_alt_outlined, color: Colors.grey),
                                Text(
                                  'Ended\npositively',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                  SizedBox(height: 24,),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Example 2: If at any point of a contract, there is a 90-day period without payment, no additional "job" will count toward your score. The gray bar below reflects a period with no payment. Therefore, this period wouldn\'t count toward your Job Success Score',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 24,),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Timeline(
                                  dollarCount: 3,
                                  stepCount: 4,
                                  labels: [
                                    'Start',
                                    '90 days',
                                    '180 days',
                                    '270 days'
                                  ],
                                  lineColors: [
                                    Colors.black, // Line between dot 1 & 2
                                    Colors.grey.shade300, // Line between dot 2 & 3
                                    Colors.black // Line between dot 3 & 4
                                  ],
                                  dotColor: Colors.black,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Icon(Icons.thumb_down, color: Colors.transparent),
                                Text(
                                  'Ended\nnegatively',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.transparent,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                  SizedBox(height: 24,),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Example 3: If at any point a contract ends, and negative feedback has been left, only the most recent "job" is considered unsuccessful.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 24,),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Timeline(
                                  dollarCount: 3,
                                  stepCount: 4,
                                  labels: [
                                    'Start',
                                    '90 days',
                                    '180 days',
                                    '270 days'
                                  ],
                                  lineColors: [
                                    Colors.black, // Line between dot 1 & 2
                                    Colors.black, // Line between dot 2 & 3
                                    Colors.red // Line between dot 3 & 4
                                  ],
                                  dotColor: Colors.black,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Icon(Icons.thumb_down_alt_outlined, color: Colors.grey),
                                Text(
                                  'Ended\nnegatively',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Tips',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Text(
                  //   '1. Utilize learning path resources such as',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     color: Colors.grey.shade700,
                  //   ),
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text('1. ', style: TextStyle(
                          fontSize: 16
                        ),),
                      ),
                      Expanded(
                        child: RichText(text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                              height: 1.5, wordSpacing: 1.5
                            ),
                          children: [
                            TextSpan(text: 'Utilize learning path resources such as '),
                            TextSpan(text: 'New to Orbitwork: Communicating with Clients', style: TextStyle(
                              color: Get.theme.primaryColor,  decoration: TextDecoration.underline,
                              decorationColor: Get.theme.primaryColor
                            )),
                            TextSpan(text: ' to excel your career and hone communication skills.')
                          ]
                        )),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text('2. ', style: TextStyle(
                            fontSize: 16
                        ),),
                      ),
                      Expanded(
                        child: RichText(text: TextSpan(
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                                height: 1.5, wordSpacing: 1.5
                            ),
                            children: [
                              TextSpan(text: 'Explore Orbitwork\'s '),
                              TextSpan(text: 'Learning Hub', style: TextStyle(
                                  color: Get.theme.primaryColor,  decoration: TextDecoration.underline,
                                  decorationColor: Get.theme.primaryColor
                              )),
                              TextSpan(text: ' for courses that can help you upskill and build better working relationships with clients.')
                            ]
                        )),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreWorkBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: Get.height * 0.7,
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
                  Text('Long-term relationships', style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w500
                  ),),
                  IconButton(onPressed: () {
                    Get.back();
                  }, icon: Icon(Icons.close))
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('A relationship qualifies as long-term if a client\'s last payment is made more than 90 days after their first payment.', style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w300
                      ),),
                      SizedBox(height: 12,),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Column(
                          children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                         // Icon(Icons.location_on_outlined),
                                          Image.asset(
                                            'assets/icon/placeholder.png',
                                            height: 25,
                                            width: 25,
                                          ),
                                          SizedBox(height: 10,),
                                          Icon(Icons.circle, size: 10,)
                                        ],
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              '90+ days',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Container(
                                              height: 2,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                         // Icon(Icons.location_on_outlined),
                                          Image.asset(
                                            'assets/icon/placeholder.png',
                                            height: 25,
                                            width: 25,
                                          ),
                                          SizedBox(height: 10,),
                                          Icon(Icons.circle, size: 10,)
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Jan 1',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Text(
                                        'Apr 1',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                            Text('For example, if a client\'s first payment was Jan 1 and their most recent payment was Apr 1 (90 days later), then all ongoing and completed jobs with that client are considered successful.',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w300
                              ),),
                          ],
                        ),
                      ),
                      SizedBox(height: 12,),
                      Text('How it works',style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500
                      ),),
                      SizedBox(height: 16,),
                      Text('Ongoing long-term relationships are considered successful as long as no negative feedback has been left.',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300
                        ),),
                      SizedBox(height: 12,),
                      Text('If at any point a contract ends, and negative feedback has been left, only the most recent "job" within that contract is considered unsuccessful.',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300
                        ),),
                      SizedBox(height: 12,),
                      Text('Tips', style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500
                      ),),
                      SizedBox(height: 12,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('1.'),
                          Expanded(
                            child: RichText(text: TextSpan(
                              style: TextStyle(
                                height: 1.5,
                                color: Get.theme.secondaryHeaderColor,
                                    fontSize: 16, fontWeight: FontWeight.w300
                              ),
                              children: [
                                TextSpan(
                                  text: 'Utilize learning path resources such as '
                                ),
                                TextSpan(
                                  text: 'Building a Business on Orbitwork', style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Get.theme.primaryColor,
                                  decorationColor: Get.theme.primaryColor,
                                  fontWeight: FontWeight.w400
                                )
                                ),
                                TextSpan(
                                  text: ' to excel your career and hone communication skills.'
                                )
                              ]
                            )),
                          ),
                        ],
                      ),
                      SizedBox(height: 12,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('2.'),
                          Expanded(
                            child: RichText(text: TextSpan(
                              style: TextStyle(color: Get.theme.secondaryHeaderColor, fontSize: 16, fontWeight: FontWeight.w300),
                              children: [
                                TextSpan(
                                  text: 'Explore Orbitwork\'s '
                                ),
                                TextSpan(
                                  text: 'Education Marketplace', style: TextStyle(
                                  color: Get.theme.primaryColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Get.theme.primaryColor,
                                  fontWeight: FontWeight.w400
                                )
                                ),
                                TextSpan(
                                  text: ' for courses that can help you upskill and build better working relationships with clients.'
                                ),
                              ]
                            )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: Get.width,
                child: ElevatedButton(onPressed: () {
                  Get.back();
                },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                      ),
                    child: Text('Close', style: TextStyle(color: Colors.white),)),
              )
            ],
          ),
        ),
    );
  }

}
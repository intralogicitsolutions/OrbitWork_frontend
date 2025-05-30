import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class MembershipSetting extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Membership Settings'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Membership Settings', style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500
              ),),
              SizedBox(height: 32,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12)
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CURRENT PLAN'),
                    Text('Marketplace', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500
                    ),),
                    SizedBox(height: 12,),
                    Text('Plan  start date: 5/26/2025'),
                    SizedBox(height: 12,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Get.theme.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )
                      ),
                        onPressed: () {
                          Get.toNamed(AppRoutes.clientMembershipPlan);
                        },
                        child: Text('Upgrade membership', style: TextStyle(color: Colors.white),))
                  ],
                ),
              ),
              SizedBox(height: 40,),
              Text('Your plan benefits', style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500
              ),),
              SizedBox(
                height: 12,
              ),
              Container(
               // padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Discover quality talent fast', style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500
                          ),),
                          SizedBox(height: 20,),
                          _buildText('Post a job and receive proposals from talent'),
                          _buildText('See verified work history and reviews'),
                          _buildText('Send 30 invitations to talent per job post'),
                          _buildText('Use advanced search filters'),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey.shade300,),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Collaboration tools for project tracking', style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500
                          ),),
                          SizedBox(height: 20,),
                          _buildText('Chat, video call, and share files with talent'),
                          _buildText('Get advanced reporting and tracking'),
                          _buildText('Set coworker teams and member permission settings'),
                          _buildText('Customize your invoice with activity codes')
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey.shade300,),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Account support and guidance', style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500
                          ),),
                          SizedBox(height: 20,),
                          _buildText('24/7 premium customer support')
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey.shade300,),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Safe, easy payments', style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500
                          ),),
                          SizedBox(height: 20,),
                          _buildText('Get an extra level of security with Orbitwork Payment Protection'),
                          _buildText('Pay as you go billing for milestone and hourly contracts'),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                              child: Icon(Icons.circle, size: 8,),
                            ),
                            Expanded(
                              child: RichText(text: TextSpan(
                                style: TextStyle(color: Get.theme.secondaryHeaderColor, height: 1.5),
                                children: [
                                  TextSpan(
                                    text: '3-5% Marketplace fee',
                                    style: TextStyle(
                                      color: Get.theme.primaryColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Get.theme.primaryColor
                                    )
                                  ),
                                  TextSpan(
                                    text: ' depending on payment method'
                                  )
                                ]
                              )),
                            )
                          ],)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(String text){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0, right: 8.0),
            child: Icon(Icons.circle,  size: 8,),
          ),
          Expanded(
              child: Text(text))
        ],
      ),
    );
  }

}
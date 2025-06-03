import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/widgets/custom_appbar.dart';

import '../routes/app_routes.dart';

class ClientAlertsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Alerts'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Most Recent', style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w500
              ),),
              SizedBox(height: 12,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle_outlined),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(text: TextSpan(
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,
                          height: 1.5,
                          color: Get.theme.secondaryHeaderColor),
                          children: [
                            TextSpan(
                              text: 'A '
                            ),
                            TextSpan(
                              text: 'security question',
                              style: TextStyle(
                                color: Get.theme.primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor: Get.theme.primaryColor
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(AppRoutes.passwordAndSecurity);
                                },
                            ),
                            TextSpan(
                              text: ' has been added or changed to your account'
                            )
                          ]
                        )),
                        SizedBox(height: 12,),
                        Text('Jun 2', style: TextStyle(
                          color: Get.theme.hintColor,fontSize: 16, fontWeight: FontWeight.w500
                        ),),
                        Divider(height: 32,thickness: 1,color: Get.theme.secondaryHeaderColor,)
                      ],
                    ),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle_outlined),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Text('There was a failure to verify your Security Answer', style: TextStyle(
                         fontSize: 16, fontWeight: FontWeight.w500
                       ),),
                        SizedBox(height: 12,),
                        Text('Jun 2', style: TextStyle(
                            color: Get.theme.hintColor,fontSize: 16, fontWeight: FontWeight.w500
                        ),),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40,),
              Text('Earlier',style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w500
              ),),
              SizedBox(height: 12,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle_outlined),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('There was a failure to verify your Security Answer', style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500
                        ),),
                        SizedBox(height: 12,),
                        Text('May 30', style: TextStyle(
                            color: Get.theme.hintColor,fontSize: 16, fontWeight: FontWeight.w500
                        ),),
                        Divider(height: 32,thickness: 1,color: Get.theme.secondaryHeaderColor,)
                      ],
                    ),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle_outlined),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('There was a failure to verify your Security Answer', style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500
                        ),),
                        SizedBox(height: 12,),
                        Text('May 30', style: TextStyle(
                            color: Get.theme.hintColor,fontSize: 16, fontWeight: FontWeight.w500
                        ),),
                        Divider(height: 32,thickness: 1,color: Get.theme.secondaryHeaderColor,)
                      ],
                    ),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle_outlined),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(text: TextSpan(
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,
                                height: 1.5,
                                color: Get.theme.secondaryHeaderColor),
                            children: [
                              TextSpan(
                                  text: 'A '
                              ),
                              TextSpan(
                                  text: 'security question',
                                  style: TextStyle(
                                      color: Get.theme.primaryColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Get.theme.primaryColor
                                  ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(AppRoutes.passwordAndSecurity);
                                  },
                              ),
                              TextSpan(
                                  text: ' has been added or changed to your account'
                              )
                            ]
                        )),
                        SizedBox(height: 12,),
                        Text('May 30', style: TextStyle(
                            color: Get.theme.hintColor,fontSize: 16, fontWeight: FontWeight.w500
                        ),),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
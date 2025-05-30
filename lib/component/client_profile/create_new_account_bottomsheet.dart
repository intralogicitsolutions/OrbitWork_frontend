import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class CreateNewAccountBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Account'),
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.close)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(text: TextSpan(
              style: TextStyle(color: Get.theme.secondaryHeaderColor, fontSize: 16, height: 1.5),
              children: [
                TextSpan(
                  text: 'Creating a new account allows you to use Orbitwork in different ways, while still having just one login. '
                ),
                TextSpan(
                  text: 'Learn more',
                  style: TextStyle(
                    color: Get.theme.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: Get.theme.primaryColor
                  ),
                ),
              ]
            )),
            SizedBox(height: 24,),
            GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.createClientAccount);
                },
                child: Text('+ New Client Account', style: TextStyle(color: Get.theme.primaryColor, fontSize: 16),)),
            SizedBox(height: 16,),
            Text('Hire, manage and pay as a different company. Each client company has its own freelancer, payment methods and reports',
            style: TextStyle(
              fontSize: 16
            ),),
            SizedBox(height: 20,),
            Text('+ New Freelancer Account', style: TextStyle(color: Get.theme.hintColor, fontSize: 16),),
            SizedBox(height: 16,),
            RichText(text: TextSpan(
              style: TextStyle(color: Colors.red, fontSize: 16),
              children: [
                TextSpan(
                 text: 'You must '
                ),
                TextSpan(
                  text: 'update your address',
                  style: TextStyle(
                    color: Get.theme.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: Get.theme.primaryColor
                  )
                ),
                TextSpan(
                  text: ' before you can create a new Freelancer account'
                )
              ]
            ))
          ],
        ),
      ),
    );
  }

}
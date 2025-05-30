import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../client_profile_controller/security_question_controller.dart';

class AuthorizeDeviceBottomsheet extends StatelessWidget{
  final SecurityQuestionController controller = Get.put(SecurityQuestionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authorize your device'),
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.close)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/icon/authorize.svg',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.center,
                    child: Text('Confirm that it\'s you', style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500
                    ),),
                  ),
                  SizedBox(height: 20,),
                  Text('Answer your security question'),
                  SizedBox(height: 16,),
                  Text('Enter the answer to the security question you set with Orbitwork.', style: TextStyle(
                    fontWeight: FontWeight.w300
                  ),),
                  SizedBox(height: 20,),
                  Text('The name of the street you grew up on'),
                  SizedBox(height: 12,),
                  Container(
                    height: 40,
                    child: TextField(decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                    ),),
                  ),
                  SizedBox(height: 16,),
                  Text('Forgot your security answer?', style: TextStyle(
                    color: Get.theme.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: Get.theme.primaryColor
                  ),),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Obx(() {
                          return Checkbox(
                            value: controller.keepMeLoggedIn.value,
                            onChanged: controller.toggleKeepMeLoggedIn,
                            activeColor: Get.theme.primaryColor,
                          );
                        }
                      ),
                      const Text('Keep me logged in on this device'),
                    ],
                  )
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(onPressed: () {},
                      child: Text('cancel', style: TextStyle(
                    color: Get.theme.primaryColor, fontSize: 16
                  ),)),
                ),
                Expanded(
                  child: ElevatedButton(onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Get.theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      elevation: 0,
                    ),
                    child: Text('Continue',style: TextStyle(
                    color: Colors.white, fontSize: 16
                  ),),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}
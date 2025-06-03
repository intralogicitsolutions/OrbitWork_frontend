import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/client_profile_controller/change_password_controller.dart';

class ChangePasswordBottomsheet extends StatelessWidget{
  final ChangePasswordController controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change your password'),
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
                  Text("You'll need to log in again on all devices after changing your password.",
                  style: TextStyle(
                    fontSize: 12
                  ),),
                  SizedBox(height: 12,),
                  Text('Current password', style: TextStyle(
                    fontSize: 16
                  ),),
                  SizedBox(height: 8,),
                  Container(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text('New Password', style: TextStyle(
                    fontSize: 16
                  ),),
                  SizedBox(height: 8,),
                  Obx(() {
                      return Container(
                        height: 40,
                        child: TextField(
                          obscureText: controller.isPasswordHidden.value,
                          decoration:InputDecoration(
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(12),
                           ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            suffixIcon: IconButton(onPressed: () {
                              controller.togglePasswordVisibility();
                            }, icon: Icon(
                                controller.isPasswordHidden.value ?
                                Icons.visibility_off_outlined :
                                Icons.remove_red_eye_outlined,
                            ))
                          ),
                        ),
                      );
                    }
                  ),
                  SizedBox(height: 10,),
                  Text('Must be at least 8 characters long, including 1 number or 1 symbol.',
                  style: TextStyle(
                    fontSize: 12
                  ),),
                  SizedBox(height: 24,),
                  Text('Re-enter new password', style: TextStyle(
                    fontSize: 16
                  ),),
                  SizedBox(height: 8,),
                  Obx(() {
                      return Container(
                        height: 40,
                        child: TextField(
                          obscureText: controller.isPasswordHidden.value,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            suffixIcon: IconButton(onPressed: () {
                              controller.toggleNewPasswordVisibility();
                            }, icon: Icon(
                                controller.isNewPasswordHidden.value ?
                                Icons.visibility_off_outlined :
                                    Icons.remove_red_eye_outlined
                            ))
                          ),
                        ),
                      );
                    }
                  )
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey.shade300,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(onPressed: () {
                    Get.back();
                  }, child: Text('Cancel', style: TextStyle(
                    fontSize: 16, color: Get.theme.primaryColor
                  ),)),
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Get.theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24)
                    ),
                    child: Text('Confirm and log out', style: TextStyle(
                      color: Colors.white
                    ),)
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
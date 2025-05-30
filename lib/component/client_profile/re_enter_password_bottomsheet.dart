import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReEnterPasswordBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Re-enter password'),
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
            child: Container(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email', style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400
                  ),),
                  SizedBox(height: 16,),
                  Text('i...1@gmail.com'),
                  SizedBox(height: 16,),
                  Text('Not you?',
                    style: TextStyle(
                      color: Get.theme.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: Get.theme.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                    ),
                  ),
                  SizedBox(height: 24,),
                  Text('Password', style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400
                  ),),
                  SizedBox(height: 12,),
                  Container(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Get.theme.secondaryHeaderColor)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Get.theme.secondaryHeaderColor, width: 2)
                        ),
                        prefixIcon: Icon(Icons.lock_outline, size: 16,),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 14,),
                  Text('Forgot password?', style: TextStyle(
                    color: Get.theme.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: Get.theme.primaryColor,
                    fontWeight: FontWeight.w600
                  ),)
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey.shade300,),
          Padding(
            padding: EdgeInsets.only(
              right: 16,left: 16,
              // bottom: MediaQuery.of(context).viewPadding.bottom + 16,
            ),
            child: Container(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child:
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                      ),
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
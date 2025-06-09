import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import 'add_note_bottomsheet.dart';

class SelectProfileBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select', style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w500
                ),),
                IconButton(onPressed: () {
                  Get.back();
                }, icon: Icon(Icons.close))
              ],
            ),
            SizedBox(height: 24,),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.consultationPage);
              },
              child: Text('Book a consultation',style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),),
            ),
            SizedBox(height: 24,),
            Text('Share', style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 24,),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(
                  AddNoteBottomSheet(),
                  isScrollControlled: true,
                  ignoreSafeArea: false,
                  backgroundColor: Colors.transparent,
                );
              },
              child: Text('Add notes', style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),),
            )
          ],
        ),
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaveSearchBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return  Container(
       padding: EdgeInsets.all(16),
       decoration: BoxDecoration(
         color: Get.theme.scaffoldBackgroundColor,
         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
       ),
       child: Column(
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text('Save search as', style: TextStyle(
                 fontSize: 20, fontWeight: FontWeight.w500
               ),),
               IconButton(onPressed: () {
                 Get.back();
               }, icon: Icon(Icons.close)),
             ],
           ),
           SizedBox(height: 16,),
           SizedBox(
             height: 40,
             child: TextField(
               decoration: InputDecoration(
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(8),
                 ),
                 suffixIcon: Icon(Icons.close, size: 18,),
                 hintText: 'Any',
                 contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)
               ),
             ),
           ),
           SizedBox(height: 5,),
           Row(
             children: [
               Icon(Icons.error_outline, color: Colors.red.shade900,),
               Text(' You cannot save a blank search.', style: TextStyle(
                 color: Colors.red.shade900
               ),),
             ],
           ),
           SizedBox(height: 16,),
           SizedBox(
             width: Get.width,
             child: ElevatedButton(
               onPressed: () {
                 // Apply filters logic here
                 Get.back();
               },
               style: ElevatedButton.styleFrom(
                   elevation: 0,
                   backgroundColor: Colors.grey.shade200,
                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(8))),
               child: Text(
                 'Save',
                 style: TextStyle(color: Colors.grey.shade700),
               ),
             ),
           ),
           SizedBox(height: 16,),
           Text('Saving this search will save the query and all the filters that are currently applied. Results from your saved searches will appear in My Feed',
           style: TextStyle(color: Colors.grey, fontSize: 12),
           )
         ],
       ),
     );

  }

}
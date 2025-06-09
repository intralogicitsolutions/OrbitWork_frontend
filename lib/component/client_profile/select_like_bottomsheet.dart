import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_list_bottomsheet.dart';

class SelectLikeBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.2,
     padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
              IconButton(onPressed: () {
                Get.back();
              }, icon: Icon(Icons.close, size: 24,))
            ],
          ),
          SizedBox(height: 32,),
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                CreateListBottomsheet(),
                isScrollControlled: true,
                ignoreSafeArea: false,
              );
            },
            child: Text('Create list', style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500
            ),),
          )
        ],
      ),
    );
  }

}
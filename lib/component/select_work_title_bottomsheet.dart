import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkTitleBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(onPressed: () {
                Get.back();
              }, icon: Icon(Icons.close))
            ],
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search Title',
              prefixIcon: Icon(Icons.search),
              hintStyle: TextStyle(
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }

}
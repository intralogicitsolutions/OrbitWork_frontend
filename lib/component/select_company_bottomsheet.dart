import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCompanyBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(onPressed: () {
                Get.back();
              }, icon: Icon(Icons.close)),
              Text('Company', style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),)
            ],
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search Company',
              prefixIcon: Icon(Icons.search),

            ),
          )
        ],
      ),
    );
  }

}
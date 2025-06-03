import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdvancedSearchBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Advanced search', style: TextStyle(
                  fontSize: 24,fontWeight: FontWeight.w500
                ),),
                IconButton(onPressed: () {
                  Get.back();
                }, icon: Icon(Icons.close))
              ],
            ),
            SizedBox(height: 24,),
            Expanded(
              child: Column(
                children: [
                  _buildTitleTextField('All of these words'),
                  _buildTitleTextField('Any of these words'),
                  _buildTitleTextField('None of these words'),
                  _buildTitleTextField('The exact phrase'),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {
                  Get.back();
                }, child: Text('Cancel', style: TextStyle(
                  fontSize: 16, color: Get.theme.primaryColor
                ),)),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Get.theme.primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                    ),
                    child: Text('Search', style: TextStyle(
                      fontSize: 16, color: Colors.white
                    ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleTextField(String title){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 16),),
        Container(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6)
            ),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}
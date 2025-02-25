import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkroomTimesheetBottomsheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select',style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w500
                  ),),
                  IconButton(onPressed: () => Get.back(), icon: Icon(Icons.close))
                ],
              ),
              SizedBox(
                height: 24,
              ),
              _buildText('Propose new contract', () {},),
              _buildText('Give a refund', () {}),
              _buildText('Request public feedback', () {},),
              _buildText('End contract', () {},),

            ],
          ),
        ),
      ),
    );
  }
  Widget _buildText(String title, VoidCallback onTap){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
            onTap: onTap,
            child: Text(title, style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500
            ),)),
        Divider(height: 32,)
       // SizedBox(height: 20,),
      ],
    );
  }
}
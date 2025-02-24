import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class EarningsAvailableBottomsheet extends StatelessWidget{
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
            _buildText('Get paid', () => Get.toNamed(AppRoutes.getPaid),),
            _buildText('View pending earnings', () => Get.toNamed(AppRoutes.transactionHistory, arguments: true),),
            _buildText('Go to reports', () => Get.toNamed(AppRoutes.overView, arguments: true),),
            _buildText('Learn about payments', () {},),
          ],
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
        SizedBox(height: 20,),
      ],
    );
  }
}
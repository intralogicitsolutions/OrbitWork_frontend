import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/profile/availability_badge_bottomsheet.dart';

class Myproposalpage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proposals',style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500,
        ),),
        actions: [
          IconButton(onPressed: () {

          }, icon: Icon(Icons.more_vert_rounded))
        ],
      ),
      body: Column(
        children: [
          _buildContainer('Offers', 0,),
          _buildContainer('Invitations to interview', 0, available: true, onPressed: () {
            Get.bottomSheet(
              Container(
                  height: Get.height * 0.9,
                  child: AvailabilityBadgeBottomSheet()),
              isScrollControlled: true,
              ignoreSafeArea: false,
            );
          },),
          _buildContainer('Active proposals', 0),
          _buildContainer('Submitted proposals', 0)
        ],
      ),
    );
  }

  Widget _buildContainer(String text, int item,
      {bool? available = false, VoidCallback? onPressed}
      ){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: Container(
        padding: EdgeInsets.all(20),
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$text ($item)', style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500
            ),),
            available == true ? Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.electric_bolt, size: 12,),
                      SizedBox(width: 5.0,),
                      Text('Available now', style: TextStyle(color: Colors.grey.shade600, fontSize: 12),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('off'),
                ),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Get.theme.dividerColor,
                      // color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        Icons.edit_outlined,
                        color: Colors.green,
                        size: 15,
                      )),
                ),
              ],
            ) : SizedBox(),
          ],
        ),
      ),
    );
  }

}
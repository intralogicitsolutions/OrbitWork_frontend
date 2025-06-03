import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../client_profile_controller/talent_controller.dart';
import 'create_list_bottomsheet.dart';

class TalentListBottomsheet extends StatelessWidget{
  final TalentController controller = Get.put(TalentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            _buildRowText(Icons.star, 'Discover', onTap: () {
              controller.selectedListName.value = 'Discover';
              Get.back();
            },),
            _buildRowText(Icons.home_repair_service_outlined, 'Your hires', onTap: () {
              controller.selectedListName.value = 'Your hires';
              Get.back();
            },),
            _buildRowText(Icons.home_work_outlined, 'Company hires', onTap: () {
              controller.selectedListName.value = 'Company hires';
              Get.back();
            },),
            _buildRowText(Icons.av_timer, 'Recently viewed', onTap: () {
              controller.selectedListName.value = 'Recently viewed';
              Get.back();
            },),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your lists', style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500
                ),),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Get.theme.primaryColor, width: 2),
                  ),
                    child: IconButton(onPressed: () {
                      Get.bottomSheet(
                          CreateListBottomsheet(),
                        isScrollControlled: true,
                       ignoreSafeArea: false,
                      );
                    },
                        icon: Icon(Icons.add,
                      size: 20,
                      color: Get.theme.primaryColor,)))
              ],
            ),
            Divider(),
            SizedBox(height: 20,),
            _buildRowText(Icons.favorite, 'Saved talent', onTap: () {
              controller.selectedListName.value = 'Saved talent';
              Get.back();
            },),
            _buildRowText(Icons.label_important_outline, 'Saved projects', onTap: () {
              controller.selectedListName.value = 'Saved projects';
              Get.back();
            },),
            //SizedBox(height: 16),
            Obx(() => Column(
              children: controller.customLists.map((listName) =>
                  _buildRowText(Icons.check_circle_outline, listName, onTap: () {
                    controller.selectedListName.value = listName;
                    Get.back();
                  },)).toList(),
            )),

          ],
        ),
      ),
    );
  }
  Widget _buildRowText(IconData icon , String text, {VoidCallback? onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon),
              SizedBox(width: 8,),
              Text(text)
            ],
          ),
          SizedBox(height: 24,)
        ],
      ),
    );
  }
}
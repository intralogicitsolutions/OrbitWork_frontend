import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/avilable_bottomsheet.dart';
import '../component/in_review_bottomsheet.dart';
import '../component/pending_bottomsheet.dart';
import '../component/work_in_progress_bottomsheet.dart';

class OverviewTab extends StatelessWidget {
  final bool? showAppbar;
  OverviewTab({Key? key, this.showAppbar = false, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppbar == true ? AppBar(
        title: Text('Reports', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
        ],
      ): null,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: 4,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                _getTitle(index),
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text('\$0.00'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                _showBottomSheet(index);
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider( height: 0,
              thickness: 1,
              color: Colors.grey.withOpacity(0.3),);
          },
        ),
      ),
    );
  }
  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Work in progress';
      case 1:
        return 'In review';
      case 2:
        return 'Pending';
      case 3:
        return 'Available';
      default:
        return '';
    }
  }

  void _showBottomSheet(int index){
    switch (index) {
      case 0:
        Get.bottomSheet(WorkInProgressBottomsheet());
        break;
      case 1:
        Get.bottomSheet(InReviewBottomsheet());
        break;
      case 2:
        Get.bottomSheet(PendingBottomsheet());
        break;
      case 3:
        Get.bottomSheet(AvilableBottomsheet());
        break;
      default:
        break;
    }
  }
}

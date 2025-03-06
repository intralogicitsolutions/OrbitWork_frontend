import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/views/tabs/contract_details_tab.dart';
import 'package:orbitwork/views/tabs/overView_tab.dart';
import 'package:orbitwork/views/tabs/timesheet_tab.dart';

import '../component/workroom_timesheet_bottomsheet.dart';
import '../controllers/workroom_timesheet_controller.dart';
import '../models/timesheet_transaction_model.dart';
import '../routes/app_routes.dart';

class WorkRoomTimeSheet extends StatelessWidget {
  final TimesheetController controller = Get.put(TimesheetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text('Workroom timesheet'),
        //backgroundColor: Color(0xFF0B503C),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildTabBar(),
          Expanded(
            child: Obx(() {
              switch (controller.selectedTab.value) {
                case 0:
                  return OverViewPage();
                case 1:
                  return TimesheetPage(showAppbar: false,);
                case 2:
                  return ContractDetailsPage(showAppbar: false,);
                default:
                  return TimesheetPage();
              }
            }),
          ),
         //  _buildStats(),
         //  _buildWorkDiary(),
         // // _buildDateSelector(),
         //  _buildWeeklyTimesheet(),
         //  _buildTimeSummary(),
         //  _buildRecentTransactions(),
         //  SizedBox(height: 20),
         //  _buildTransactionsSummary(),
         //  SizedBox(height: 20),
         //  _buildTransactionsTable(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Color(0xFF0B503C),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Backend Dev work with ${controller.userName}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.chat_bubble_outline, color: Colors.white),
                    onPressed: () {
                      Get.toNamed(AppRoutes.message);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () {
                      Get.bottomSheet(
                          Container(
                              height: Get.height * 0.4,
                              child: WorkroomTimesheetBottomsheet()),
                          isScrollControlled: true,
                          isDismissible: true
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person_outline),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                    controller.userRole.value,
                    style: TextStyle(color: Colors.white),
                  )),
                  Row(
                    children: [
                      Obx(() => Text(
                        controller.location.value,
                        style: TextStyle(color: Colors.white70),
                      )),
                      Text(
                        ' • Mon 6:29 AM',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Color(0xFF0B503C),
      child: Column(
        children: [
          Row(
            children: [
              _buildTab('Overview', 0),
              _buildTab('Timesheet', 1),
              _buildTab('Contract details', 2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index), // Change tab on click
        child: Obx(() {
          bool isSelected = controller.selectedTab.value == index;
          return Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isSelected ? Colors.white : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/client_profile_controller/client_report_controller.dart';
import 'package:orbitwork/client_profile_views/reports_tab/time_by_activity_tab.dart';
import 'package:orbitwork/client_profile_views/reports_tab/time_by_freelancer_tab.dart';
import 'package:orbitwork/client_profile_views/reports_tab/timesheet_tab.dart';
import 'package:orbitwork/client_profile_views/reports_tab/weekly_summary_tab.dart';

import '../views/transaction_history_tab.dart';

class ClientReports extends StatelessWidget{
  final ClientReportController controller = Get.put(ClientReportController());

  final List<Widget> tabPages = [
    WeeklySummaryTab(),
    TransactionHistoryTab(),
    TimesheetTab(),
    TimeByFreelanserTab(),
    TimeByActivityTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: TabBar(
            controller: controller.tabController,
            isScrollable: true,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.green,
            indicatorWeight: 3,
            tabs: controller.tabTitles
                .map((title) => Tab(text: title))
                .toList(),
          ),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: tabPages,
        // children: controller.tabTitles.map((title) {
        //   return Center(
        //     child: Text(
        //       title,
        //       style: TextStyle(fontSize: 18),
        //     ),
        //   );
        // }).toList(),
      ),
    );
  }
}
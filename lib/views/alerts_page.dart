
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/alert_controller.dart';
import '../widgets/custom_appbar.dart';
import 'activity_view_page.dart';

import 'job_alerts_view_page.dart';

class AlertsPage extends StatelessWidget {
  final AlertsController controller = Get.put(AlertsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Alerts",
      ),
      body: Column(
        children: [
          // Tabs for Activity and Job Alerts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => controller.changeTab(0),
                child: Obx(() => Column(
                  children: [
                    Text(
                      "Activity",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: controller.selectedTab.value == 0
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                    if (controller.selectedTab.value == 0)
                      Container(
                        height: 3,
                        width: 50,
                        color: Colors.green,
                      )
                  ],
                )),
              ),
              GestureDetector(
                onTap: () => controller.changeTab(1),
                child: Obx(() => Column(
                  children: [
                    Text(
                      "Job Alerts",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: controller.selectedTab.value == 1
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                    if (controller.selectedTab.value == 1)
                      Container(
                        height: 3,
                        width: 50,
                        color: Colors.green,
                      )
                  ],
                )),
              ),
            ],
          ),
          //Divider(),
          // Display Page Based on Selected Tab
          Expanded(
            child: Obx(() {
              return controller.selectedTab.value == 0
                  ? ActivityView()
                  : JobAlertsView();
            }),
          ),
        ],
      ),
    );
  }
}
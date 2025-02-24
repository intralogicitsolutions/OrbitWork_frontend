import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reports_controller.dart';
import 'overview_tab.dart';
import 'transaction_history_tab.dart';

class ReportsPage extends StatelessWidget {
  final ReportsController controller = Get.put(ReportsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Obx(() => Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.switchTab(0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: controller.selectedTab.value == 0
                              ? Colors.green
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Overview',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.switchTab(1),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: controller.selectedTab.value == 1
                              ? Colors.green
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Transaction History',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
      body: Obx(() {
        if (controller.selectedTab.value == 0) {
          return OverviewTab(showAppbar: false,);
        } else {
          return TransactionHistoryTab(showAppbar: false,);
        }
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/homescreen_controller.dart';
import 'package:orbitwork/views/proposals_page.dart';

import '../controllers/drawer_controller.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';
import 'alerts_page.dart';
import 'contracts_page.dart';
import 'jobs_page.dart';
import 'messages_page.dart';

class MyHomePage extends StatelessWidget {
  final HomeScreenController controller = Get.put(HomeScreenController());
  final Drawercontroller drawerController = Get.put(Drawercontroller());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Obx(() {
        switch (controller.selectedIndex.value) {
          case 0:
            return JobsPage();
          case 1:
            return ProposalsPage();
          case 2:
            return ContractsPage();
          case 3:
            return MessagesPage();
          case 4:
            return AlertsPage();
          default:
            return JobsPage();
        }
      }),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),
          Obx(
             () {
              return BottomNavigationBar(
                backgroundColor: theme.scaffoldBackgroundColor,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Theme.of(context).iconTheme.color,
                currentIndex: controller.selectedIndex.value,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                iconSize: 20.0,
                selectedFontSize: 10.0,
                unselectedFontSize: 10.0,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.work),
                    label: "Jobs",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.description),
                    label: "Proposals",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.event_note),
                    label: "Contracts",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.message_outlined),
                    label: "Messages",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_none),
                    label: "Alerts",
                  ),
                ],
                onTap: controller.onItemTapped,
              );
            }
          ),
        ],
      ),
    );
  }
}

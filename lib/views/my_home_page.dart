import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/client_profile_views/dashboard.dart';
import 'package:orbitwork/controllers/homescreen_controller.dart';
import 'package:orbitwork/views/proposals_page.dart';

import '../client_profile_views/Talent.dart';
import '../client_profile_views/catalog.dart';
import '../controllers/drawer_controller.dart';
import '../global/global.dart';
import 'alerts_page.dart';
import 'contracts_page.dart';
import 'jobs_page.dart';
import 'messages_page.dart';

class MyHomePage extends StatelessWidget {
  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Obx(() {
        switch (controller.selectedIndex.value) {
          case 0:
            return Global.role == 2 ? DashboardPage() : JobsPage();
          case 1:
            return Global.role == 2 ? TalentPage() : ProposalsPage();
          case 2:
            return Global.role == 2 ? CatalogPage() : ContractsPage();
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
            color: Colors.grey.withOpacity(0.1),
          ),
          Obx(
             () {
              return BottomNavigationBar(
                backgroundColor: theme.scaffoldBackgroundColor,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Theme.of(context).iconTheme.color,
                currentIndex: controller.selectedIndex.value,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                iconSize: 20.0,
                selectedFontSize: 10.0,
                unselectedFontSize: 10.0,
                items:  [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.work),
                    label: Global.role == 2 ? "Dashboard" : "Jobs",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.description),
                    label: Global.role == 2 ? "Talent" : "Proposals",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.event_note),
                    label: Global.role == 2 ? "Catalog" : "Contracts",
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


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/client_profile_views/settings_tab/invitations_tab.dart';
import 'package:orbitwork/client_profile_views/settings_tab/members_tab.dart';
import 'package:orbitwork/client_profile_views/settings_tab/teams_tab.dart';

import '../client_profile_controller/teams_controller.dart';


class TeamsPage extends StatelessWidget {
  final TeamController controller = Get.put(TeamController());

  final List<Widget> pages = [
    TeamsTab(),
    MembersTab(),
    InvitationsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Text(controller.currentTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          _CustomTabBar(controller),
         // const Divider(height: 1),
          Expanded(child: pages[controller.selectedIndex.value]),
        ],
      ),
    ));
  }
}

class _CustomTabBar extends StatelessWidget {
  final TeamController controller;

  _CustomTabBar(this.controller);

  final tabNames = ['Teams', 'Members', 'Invitations'];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      children: List.generate(tabNames.length, (index) {
        final isSelected = controller.selectedIndex.value == index;
        return Expanded(
          child: GestureDetector(
            onTap: () => controller.changeTab(index),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? Colors.transparent : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                tabNames[index],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: isSelected ? Colors.black : Colors.grey,
                ),
              ),
            ),
          ),
        );
      }),
    ));
  }
}

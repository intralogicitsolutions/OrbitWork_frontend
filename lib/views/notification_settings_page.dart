import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/views/tabs/email_updates_tab.dart';
import 'package:orbitwork/views/tabs/messages_tab.dart';
import 'package:orbitwork/views/tabs/tax_set_tab.dart';

import '../controllers/notification_settings_controller.dart';

class NotificationSettings extends StatelessWidget {
  final controller = Get.put(NotificationSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text('Notification settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTabBar(),
            Obx(() {
              switch (controller.selectedTabIndex.value) {
                case 0:
                  return MessagesTab();
                case 1:
                  return EmailUpdatesTabs();
                case 2:
                  return TaxSetTab();
                default:
                  return MessagesTab();
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          _buildTab('Messages', 0),
          _buildTab('Email updates', 1),
          _buildTab('Tax set', 2),
        ],
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Obx(() {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: controller.selectedTabIndex.value == index ? Colors.green : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: controller.selectedTabIndex.value == index ? Colors.green : Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
        ),
      ),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/notification_settings_controller.dart';

class MessagesTab extends StatelessWidget{
  final controller = Get.put(NotificationSettingsController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Desktop'),
          _buildNotificationDropdown(
            'Show notifications for:',
            controller.desktopNotificationLevel,
            controller.updateDesktopNotificationLevel,
          ),
          _buildPlaySoundToggle(),
          _buildNotificationDropdown(
            'Increment message counter for:',
            controller.desktopMessageCounter,
            controller.updateDesktopMessageCounter,
          ),
          SizedBox(height: 20),
          _buildDivider(),
          _buildMobileSection(),
          _buildDivider(),
          _buildEmailSection(),
          _buildDivider(),
        ],
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildNotificationDropdown(
      String label, RxString value, Function(String) onChanged,
      {List<String>? items}) {
    items ??= ['All activity', 'Important activity only', 'Nothing'];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                label,
                style: TextStyle(fontSize: 16),
              ),
            ),
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                _buildBottomSheet(value, onChanged, items!),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                //color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value.value,
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(
      RxString value, Function(String) onChanged, List<String> items) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items
            .map(
              (option) => Obx(() => RadioListTile<String>(
            activeColor: Colors.green,
            title: Text(
              option,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            value: option,
            groupValue: value.value,
            onChanged: (String? newValue) {
              if (newValue != null) {
                onChanged(newValue);
                Get.back(); // Close BottomSheet after selection
              }
            },
          )),
        )
            .toList(),
      ),
    );
  }

  Widget _buildPlaySoundToggle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Obx(() => Checkbox(
            activeColor: Colors.green,
            value: controller.playSound.value,
            onChanged: (bool? value) {
              if (value != null) controller.togglePlaySound(value);
            },
          )),
          Text('Also play a sound'),
        ],
      ),
    );
  }

  Widget _buildSupportLink() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Push notifications not working?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          //SizedBox(height: 4),
          Row(
            children: [
              Text('Have a look at '),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // Removes all padding
                  minimumSize: Size(0, 0), // Ensures no extra space is taken
                  tapTargetSize: MaterialTapTargetSize
                      .shrinkWrap, // Reduces touch target size
                ),
                child: Text(
                  'this support article',
                  style: TextStyle(
                      color: Colors.green,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.green),
                ),
              ),
              Text('.'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMobileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Mobile'),
        _buildNotificationDropdown(
          'Show notifications for:',
          controller.mobileNotificationLevel,
          controller.updateMobileNotificationLevel,
        ),
        _buildNotificationDropdown(
          'Increment message counter for:',
          controller.mobileMessageCounter,
          controller.updateMobileMessageCounter,
        ),
        _buildSupportLink(),
      ],
    );
  }

  Widget _buildEmailSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Email'),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '(Sending to ${controller.userEmail})',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildNotificationDropdown(
          'Send an email with unread activity for:',
          controller.emailActivityLevel,
          controller.updateEmailActivityLevel,
        ),
        _buildNotificationDropdown(
          '',
          controller.emailFrequency,
          controller.updateEmailFrequency,
          items: [
            'Immediate',
            'Every 15 minutes',
            'Once an hour',
            'Once a day'
          ],
        ),
        _buildOfflineToggle(),
      ],
    );
  }

  Widget _buildOfflineToggle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Obx(() => Checkbox(
            activeColor: Colors.green,
            value: controller.onlyWhenOffline.value,
            onChanged: (bool? value) {
              if (value != null) controller.toggleOfflineOnly(value);
            },
          )),
          Expanded(
            child: Text(
              'Only send when offline or idle',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey[300],
    );
  }

}
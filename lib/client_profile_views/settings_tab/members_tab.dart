import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../client_profile_controller/member_controller.dart';
import '../../component/client_profile/authorize_device_bottomsheet.dart';

class MembersTab extends StatelessWidget{
  final MembersController controller = Get.put(MembersController());
  @override
  Widget build(BuildContext context) {
    // Show the bottom sheet when the page first builds
    Future.delayed(Duration.zero, () {
      if (!controller.isAuthorized.value) {
        // showModalBottomSheet(
        //   context: context,
        //   isDismissible: false,
        //   enableDrag: false,
        //   builder: (_) {
        //     return AuthorizationSheet();
        //   },
        // );
        Get.bottomSheet(
          AuthorizeDeviceBottomsheet(),
          isScrollControlled: true,
          ignoreSafeArea: false,
        );
      }
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Members', style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500
                    ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          // decoration: BoxDecoration(
                          //   color: const Color(0xFFF0F0F0),
                          //   borderRadius: BorderRadius.circular(24),
                          // ),
                          child: TextField(
                            onChanged: controller.updateSearchText,
                            decoration: InputDecoration(
                              hintText: 'Search by name or email',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.tune,
                        color: Get.theme.primaryColor,
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Obx(() => Container(
                    width: double.infinity,
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: controller.selectedTeam.value,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: controller.teams.map((String team) {
                          return DropdownMenuItem<String>(
                            value: team,
                            child: Text(
                              team,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.updateSelectedTeam(newValue);
                          }
                        },
                      ),
                    ),
                  )),
                  const SizedBox(height: 32),
                  Image.asset(
                    'assets/icon/add-member.png',
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'You have no team members\nyet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Get started by inviting someone to\njoin you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              width: Get.width,
              child: ElevatedButton(onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Get.theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                    )
                  ),
                  child: Text('Invite Members',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
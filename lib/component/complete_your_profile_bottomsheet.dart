import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/component/profile/add_education_bottomsheet.dart';
import 'package:orbitwork/component/profile/add_employment_bottomsheet.dart';
import 'package:orbitwork/component/profile/add_portfolio_bottomsheet.dart';
import 'package:orbitwork/component/profile/other_experience_bottomsheet.dart';
import 'package:orbitwork/component/profile/profile_overview_bottomsheet.dart';
import 'package:orbitwork/component/profile/video_introduction_bottomsheet.dart';

import '../comms/url_launcher_helper.dart';
import '../controllers/stats_controller.dart';
import '../routes/app_routes.dart';

class CompleteProfileBottomSheet extends StatelessWidget {
  final controller = Get.put(StatsController());

  @override
  Widget build(BuildContext context) {
    return Container(
    //  padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade200
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                  Obx(() => _buildProgressIndicator()),
                  SizedBox(height: 10),
                  Obx(() => Text(
                    "${controller.completionPercentage.value.toInt()}% complete",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  SizedBox(height: 8),
                  Text(
                    "You're almost done!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      UrlLauncherHelper.openUrl('https://www.google.com');
                    },
                    child: Text(
                      "Learn more",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Complete your profile",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                        TextSpan(
                            text: "Freelancers with complete, quality profiles are "),
                        TextSpan(
                          text: "4.5 times more likely",
                          style: TextStyle(color: Colors.green),
                        ),
                        TextSpan(text: " to get hired by clients."),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildProfileCompletionItem("Employment history", "Past job experiences and positions (+20%)",
                        () {
                          Get.bottomSheet(
                            Container(
                                height: Get.height,
                                child: AddEmploymentBottomsheet()),
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                          );
                  },
                  ),
                  _buildProfileCompletionItem('Portfolio', 'Work samples, case studies, etc. (+20%)', () {
                    Get.bottomSheet(
                      Container(
                          height: Get.height * 0.9,
                          child: AddPortfolioBottomsheet()),
                      isScrollControlled: true,
                      ignoreSafeArea: false,
                    );
                  },
                  ),
                  _buildProfileCompletionItem('Education', 'Include degrees and diplomas (+10%)', () {
                    Get.bottomSheet(
                      Container(
                          height: Get.height,
                          child: AddEducationBottomsheet()),
                      isScrollControlled: true,
                      ignoreSafeArea: false,
                    );
                  },
                  ),
                  _buildProfileCompletionItem('Video introduction', 'A short 30-60 second intro (+10%)', () {
                    Get.bottomSheet(
                      Container(
                          height: Get.height,
                          child: AddVideoIntroductionSheet()),
                      isScrollControlled: true,
                      ignoreSafeArea: false,
                    );
                  },
                  ),
                  _buildProfileCompletionItem('Certifications', 'Recognised skills and knowledge (+10%)', () {},
                  ),
                  _buildProfileCompletionItem('Linked accounts', 'Connect a social media profile (+10%)', () {
                    Get.toNamed(AppRoutes.profileSetting);
                  },
                  ),
                  _buildProfileCompletionItem('Other experience', 'Bootcamps, conferences, awards, etc. (+5%)', () {
                    Get.bottomSheet(
                      Container(
                          height: Get.height * 0.7,
                          child: OtherExperienceBottomsheet()),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    );
                  },
                  ),
                  _showProfileCompletionItem(),
                  Obx(() {
                    if (controller.showCompletedItems.value) {
                      return Column(
                        children: [
                          _buildProfileCompletionItem(
                            'Profile photo',
                            'A clear and professional photo (+10%)',
                                () {},
                            icon: Icons.check
                          ),
                          _buildProfileCompletionItem(
                            'Overview',
                            'A compelling summary of your experience (+10%)',
                                () {
                                  Get.bottomSheet(
                                    Container(
                                        height: Get.height,
                                        child: PofileOverviewBottomsheet()),
                                    isScrollControlled: true,
                                    ignoreSafeArea: false,
                                  );
                                },
                            icon: Icons.check
                          ),
                          _buildProfileCompletionItem(
                            'Skills',
                            'Highlight your key abilities (+10%)',
                                () {},
                            icon: Icons.check
                          ),
                        ],
                      );
                    } else {
                      return SizedBox.shrink(); // Hide items when not shown
                    }
                  }),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return
    SizedBox(
      height: 100,
      width: 100,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 70,
              width: 70,
              child: CircularProgressIndicator(
                value: controller.completionPercentage.value / 100,
                strokeWidth: 8,
                backgroundColor: Colors.grey[200],
                valueColor:
                const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          ),
          Center(
            child: Icon(Icons.person, size: 30,)
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCompletionItem(
      String title, String subtitle, VoidCallback onTap, {IconData? icon}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Stack(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: icon != null ? Get.theme.primaryColor : Colors.grey),
                      ),
                    ),
                    icon != null ? Center(
                        child: Icon(icon, size: 15, color: Get.theme.primaryColor,)
                    ): SizedBox(),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right),
            ],
          ),
          Divider(
            height: 24,
          ),
        ],
      ),
    );
  }

  Widget _showProfileCompletionItem() {
    return InkWell(
      onTap: () {
        controller.showCompletedItems.toggle();
      },
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Obx(() {
                            return Text( controller.showCompletedItems.value
                                ?'Hide completed (3)':
                                 'Show completed (3)',
                              style: TextStyle(
                                fontSize: 18,
                                color: Get.theme.primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor: Get.theme.primaryColor
                              ),
                            );
                          }
                        ),
                        Obx(() {
                            return Icon(controller.showCompletedItems.value
                                ? Icons.keyboard_arrow_up :
                              Icons.keyboard_arrow_down, color: Get.theme.primaryColor,);
                          }
                        ),
                      ],
                    ),
                    Text(
                      'Good work! These items are ticked off the list.',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 24,
          ),
        ],
      ),
    );
  }
}

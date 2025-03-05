import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/profile/flagging_bottomsheet.dart';
import '../controllers/profile_skill_controller.dart';

class FreelancerProfileController extends GetxController {
  final name = 'Ishita P.'.obs;
  final location = 'Rajkot, India'.obs;
  final hourlyRate = '\$40.00/hr'.obs;
  final expertise = 'Expertise in building cross-platform mobile applications using flutter. Proficient in flutter widgets, state management (provider, riverpod, block), and using firebase'.obs;
  final skills = ['Android App Development'].obs;
}

class FreelancerProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // final controller = Get.put(FreelancerProfileController());
    final ProfileSkillController profileSkillController = Get.put(ProfileSkillController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text('Freelancer profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // More options menu
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Header
                    Center(
                      child: Row(
                        children: [
                          // Profile Avatar
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[300],
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(width: 10,),
                          // Name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                profileSkillController.name.value,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                              Obx(() => Text(
                                profileSkillController.location.value,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              )),
                              SizedBox(height: 8),
                              // Online Status Indicator
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '1:45 pm local time',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // View Profile Button
                    ElevatedButton(
                      onPressed: () {
                        // View profile action
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        minimumSize: Size(double.infinity, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        side: BorderSide(width: 1),
                        backgroundColor: Get.theme.scaffoldBackgroundColor
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('All work', style: TextStyle(
                            color: Get.theme.secondaryHeaderColor
                          ),),
                          Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // Job Title
                    Text(
                      'Mobile app developer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),

                    // Hourly Rate
                    Obx(() => Text(
                      profileSkillController.hourlyRate.value,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    SizedBox(height: 10),

                    // Expertise Description
                    Obx(() => Text(
                      profileSkillController.expertise.value,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    )),
                    SizedBox(height: 20),

                    // Skills
                    Text(
                      'Skills',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Obx(() => Wrap(
                    //   spacing: 8,
                    //   children: controller.skills
                    //       .map((skill) => Chip(
                    //     label: Text(skill),
                    //     backgroundColor: Colors.grey[200],
                    //   ))
                    //       .toList(),
                    // )),

                    Obx(() => Wrap(
                      spacing: 4,
                      runSpacing: 2,
                      children: profileSkillController.selectedSkills
                          .map((skill) => Chip(
                        padding: const EdgeInsets.all(2),
                        backgroundColor: Colors.white,
                        label: Text(skill.name),
                        deleteIcon: const Icon(Icons.close),
                        onDeleted: () =>
                            profileSkillController.removeSkill(skill),
                      ))
                          .toList(),
                    )),

                    SizedBox(height: 20),
                    Text(
                      'Hours per week',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 16),
                    Text('More than 30 hrs/week'),

                    SizedBox(height: 20,),
                    Text(
                      'Languages',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text('English:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Conversational',
                          style: TextStyle(color: Get.theme.dividerColor),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text('Gujarati:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Fluent',
                          style: TextStyle(color: Get.theme.dividerColor),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text('Hindi:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Fluent',
                          style: TextStyle(color: Get.theme.dividerColor),
                        )
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {
                  _showFlagBottomsheet(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFlagBottomsheet(BuildContext context){
    final theme = Theme.of(context);
    Get.bottomSheet(
        Container(
          height: Get.height * 0.2,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold
                  ),),
                  IconButton(onPressed: () {Get.back();},
                      icon: Icon(Icons.close))
                ],
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                        height: Get.height * 0.9,
                        child: FlaggingBottomsheet()),
                    isScrollControlled: true,
                    ignoreSafeArea: false,
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.flag_outlined),
                    SizedBox(width: 15,),
                    Text('Flag as inappropriate', style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500
                    ),),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/profile/specialized_profile_controller.dart';

class SpecializedProfileStep2 extends StatelessWidget {
  final controller = Get.find<SpecializedProfileController>();

  Widget _buildSkillCategory(String title, {List<String>? skills}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12),

        if (skills != null) ...[
          Row(
            children: [
              Obx(() => controller.showLeftChevron.value
                  ? IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: controller.scrollLeft,
              )
                  : SizedBox()), // Space for alignment when hidden

              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: controller.scrollController,
                  child: Row(
                    children: skills.map((skill) => _buildSkillChip(skill)).toList(),
                  ),
                ),
              ),

              Obx(() => controller.showRightChevron.value
                  ? IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: controller.scrollRight,
              )
                  : SizedBox()), // Space for alignment when hidden
            ],
          ),
        ],

        if (title == 'Mobile App Dev Databases' || title == 'Mobile App Dev Tools' || title == 'Other skills') ...[
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: title == 'Mobile App Dev Databases'
                  ? 'Search Mobile App Dev Databases'
                  : title == 'Other skills'
                  ? 'Search other skills'
                  : 'Search Mobile App Dev Tools',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ],
        SizedBox(height: 24),
      ],
    );
  }



  // Widget _buildSkillCategory(String title, {List<String>? skills}) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         title,
  //         style: TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //       SizedBox(height: 12),
  //       if(skills != null)...[
  //         Wrap(
  //           spacing: 8,
  //           runSpacing: 8,
  //           children: [
  //             ...skills.map((skill) => _buildSkillChip(skill)),
  //             IconButton(
  //               icon: Icon(Icons.chevron_right),
  //               onPressed: () {},
  //               style: IconButton.styleFrom(
  //                 backgroundColor: Colors.grey[200],
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //
  //       if (title == 'Mobile App Dev Databases' || title == 'Mobile App Dev Tools' || title == 'Other skills') ...[
  //         SizedBox(height: 8),
  //         TextField(
  //           decoration: InputDecoration(
  //             hintText: title == 'Mobile App Dev Databases'? 'Search Mobile App Dev Databases' : title == 'Other skills' ? 'Search other skills':'Search Mobile App Dev Tools',
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             contentPadding: EdgeInsets.symmetric(horizontal: 16),
  //           ),
  //         ),
  //       ],
  //       SizedBox(height: 24),
  //     ],
  //   );
  // }

  Widget _buildSkillChip(String skill) {
    return Obx(() {
      final isSelected = controller.selectedSkills.contains(skill);
      return FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? Icons.remove : Icons.add,
              size: 18,
              color: Colors.black,
            ),
            SizedBox(width: 4),
            Text(skill),
          ],
        ),
        selected: isSelected,
        onSelected: (_) => controller.toggleSkill(skill),
        backgroundColor: Colors.grey[200],
        selectedColor: Colors.grey[200],
        checkmarkColor: Colors.transparent,
        showCheckmark: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                'Step ${controller.currentStep.value + 1 } of ${controller.totalSteps}',
                style: TextStyle(color: Colors.grey[600]),
              )),
              SizedBox(height: 24),

              Text(
                'Select your skills and expertise relevant to Mobile App Development',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 24),

              _buildSkillCategory('Devices',skills: controller.devices),
              _buildSkillCategory('Mobile App Dev Databases',skills: controller.databases),
              _buildSkillCategory('Mobile App Dev Deliverables',skills: controller.deliverables),
              _buildSkillCategory('Mobile Platforms',skills: controller.platforms),
              _buildSkillCategory('App Features',skills: controller.appFeatures),
              _buildSkillCategory('Mobile Programming Languages',skills: controller.programmingLanguages),
              _buildSkillCategory('Mobile App Dev Tools',skills: controller.appDevTools),
              _buildSkillCategory('Other skills'),
            ],
          ),
        ),
      ),
    );
  }
}
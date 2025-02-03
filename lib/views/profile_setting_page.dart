import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_setting_controller.dart';

class ProfileSetting extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile settings'),
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text(
                    'View as others see it',
                    style: TextStyle(color: Colors.green),
                  ),
                  onPressed: () {},
                ),
              ),
              const Text(
                'Visibility',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5,
              ),
              Obx(() => TextButton(
                    onPressed: () => _showVisibilityBottomSheet(context),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      // Removes padding to match dropdown size
                      alignment: Alignment.centerLeft, // Align text left
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4), // Styling like Dropdown
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        // Mimic dropdown border
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.profile.value.visibility,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Custom profile URL',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.primaryColor,
                        // color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_outlined,
                        color: Colors.green,
                        size: 14,
                      ),
                      padding: EdgeInsets.zero, // Removes extra padding
                      constraints: BoxConstraints(),
                    ),
                  ),
                ],
              ),
              Obx(() => TextFormField(
                    enabled: false,
                    initialValue: controller.profile.value.customUrl,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      //border: OutlineInputBorder()
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                    ),
                    onChanged: controller.updateCustomUrl,
                  )),

              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Project preference',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.help_outline,
                    size: 16,
                  )
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Obx(() => TextButton(
                    onPressed: () => _showProjectPreferenceBottomSheet(context),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4), 
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.profile.value.projectPreference,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Earnings privacy',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.help_outline,
                    size: 16,
                  )
                ],
              ),
              // Obx(() => CheckboxListTile(
              //   contentPadding: EdgeInsets.symmetric(horizontal: 0),
              //   title:  Text('Hide my Orbitwork earnings'),
              //   value: controller.profile.value.hideEarnings,
              //   onChanged: (bool? value) => controller.toggleHideEarnings(value!),
              //   controlAffinity: ListTileControlAffinity.leading,
              //   activeColor: Colors.green,
              // )),
              Obx(
                () => Row(
                  mainAxisSize: MainAxisSize.min,
                  // To keep the row tight around its children
                  children: [
                    Checkbox(
                      side: BorderSide(color: Colors.grey, width: 1.5),
                      value: controller.profile.value.hideEarnings,
                      onChanged: (bool? value) =>
                          controller.toggleHideEarnings(value!),
                      activeColor:
                          Colors.green, // Changes selected checkbox color
                    ),
                    const Text('Hide my Orbitwork earnings', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                  ],
                ),
              ),

              // const Text(
              //   'This setting hides historical earnings on your profile. Your earnings will still be visible when you submit proposals or accept invitations to interview.',
              //   style: TextStyle(color: Colors.grey),
              // ),
              // TextButton(
              //   child: const Text('Learn more',
              //       style: TextStyle(color: Colors.green)),
              //   onPressed: () {},
              // ),

              Obx(() => Text(
                'This setting hides historical earnings on your profile. Your earnings will still be visible when you submit proposals or accept invitations to interview.' +
                    (controller.isExpanded.value
                        ? ''
                        : '...'),
                style: TextStyle(color: Colors.grey),
                maxLines: controller.isExpanded.value ? null : 3,
                overflow: controller.isExpanded.value
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
              )),
              Obx(() {
                  return TextButton(
                    child: Text(
                      controller.isExpanded.value ? 'Show less' : 'Learn more',
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () {
                      // Toggle the expanded state
                      controller.isExpanded.value = !controller.isExpanded.value;
                    },
                  );
                }
              ),


              const SizedBox(height: 20),
              _buildExperienceLevel(),
              const SizedBox(height: 20),
              _buildCategories(context),
              const SizedBox(height: 20),
              _buildSpecializedProfiles(),
              const SizedBox(height: 20),
              _buildAIPreference(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceLevel() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Experience level',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          ...controller.experienceLevels.map(
            (level) => Obx(() => _buildExperienceLevelTile(
                  title: level['title']!,
                  description: level['description']!,
                  isSelected: controller.profile.value.experienceLevel ==
                      level['title'],
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceLevelTile({
    required String title,
    required String description,
    required bool isSelected,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.black : Colors.grey.shade300,
          width: isSelected ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.green : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: isSelected
              ? const Icon(Icons.circle, color: Colors.green, size: 12)
              : null,
        ),
        onTap: () => controller.updateExperienceLevel(title),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.dividerColor,
                    // color: Colors.black,
                    width: 1.5,
                  ),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Colors.green,
                    size: 14,
                  ),
                  padding: EdgeInsets.zero, // Removes extra padding
                  constraints: BoxConstraints(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            controller.profile.value.mainCategory,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            direction: Axis.horizontal,
            spacing: 8,
            runSpacing: 0,
            children: controller.defaultCategories
                .map(
                  (category) => Obx(() => _buildCategoryChip(category)),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    return FilterChip(
      label: Text(category),
      selected: controller.profile.value.categories.contains(category),
      onSelected: (_) => controller.toggleCategory(category),
      backgroundColor: Colors.grey[300],
      selectedColor: Colors.grey[200],
      labelStyle: TextStyle(
        color: Colors.grey[800],
        fontSize: 12,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      showCheckmark: false,
      padding: EdgeInsets.zero,
    );
  }

  Widget _buildSpecializedProfiles() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Specialized profiles',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          Obx(() => Text(
                '${controller.profile.value.publishedProfiles} out of ${controller.profile.value.maxProfiles} published',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              )),
          const SizedBox(height: 16),
          // RichText(
          //   text: TextSpan(
          //      children: [
          //        TextSpan(text: 'Create up to two different versions of your profile to more effectively highlight your individual specialties.',
          //          style: TextStyle(fontSize: 14, color: Colors.black),),
          //        TextSpan(text: ' Learn more',style: TextStyle(
          //          color: Colors.green,
          //          fontSize: 14,
          //        ),)
          //      ]
          //
          //   ),
          //   // child: const Text(
          //   //   'Create up to two different versions of your profile to more effectively highlight your individual specialties.',
          //   //   style: TextStyle(fontSize: 14),
          //   // ),
          // ),
          Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: controller.isExpanded.value
                            ? 'Create up to two different versions of your profile to more effectively highlight your individual specialties. This text will be expanded and show more details about how profiles can be specialized.'
                            : 'Create up to two different versions of your profile to more effectively highlight your individual specialties.',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      TextSpan(
                        text: ' Learn more',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => controller.toggleTextVisibility(),
                      ),
                    ],
                  ),
                  maxLines: controller.isExpanded.value ? null : 3,
                  overflow: controller.isExpanded.value
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                ),
              ],
            );
          }),
          // TextButton(
          //   onPressed: () {},
          //   style: TextButton.styleFrom(
          //     padding: EdgeInsets.zero,
          //     alignment: Alignment.centerLeft,
          //   ),
          //   child: const Text(
          //     'Learn more',
          //     style: TextStyle(
          //       color: Colors.green,
          //       fontSize: 16,
          //     ),
          //   ),
          // ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => controller.addSpecializedProfile(),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.green,
              side: const BorderSide(color: Colors.green),
              minimumSize: const Size(double.infinity, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Add Specialized Profile',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIPreference() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AI preference',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Obx(() {
            // Conditionally show the full or truncated text based on isTextExpanded
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.isExpanded.value
                      ? 'Choose how your Orrbitwork data is used for AI training and improvement. The data you provide helps improve AI models.'
                      : 'Choose how your Orrbitwork data is used for AI training and improvement.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  maxLines: controller.isExpanded.value ? null : 2,  // Allow unlimited lines when expanded
                  overflow: controller.isExpanded.value ? TextOverflow.visible : TextOverflow.ellipsis, // Add ellipsis when not expanded
                ),
                TextButton(
                  onPressed: controller.toggleTextVisibility,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                  ),
                  child: Text(
                    controller.isExpanded.value ? 'Show less' : 'Learn more',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            );
          }),

          const SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 24,
            ),
            title: const Text(
              'Your data is helping train our AI',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => controller.toggleAIPreference(),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.green,
              side: const BorderSide(color: Colors.green),
              minimumSize: const Size(double.infinity, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Change preference',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  void _showVisibilityBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Visibility',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(),
              ListTile(
                title: Text('Public'),
                onTap: () {
                  controller.updateVisibility('Public');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Private'),
                onTap: () {
                  controller.updateVisibility('Private');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showProjectPreferenceBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Fit content
          children: [
            Text('Select Project Preference',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Divider(),
            ...[
              'Both short-term and long-term projects',
              'Only short-term projects',
              'Only long-term projects',
            ].map((option) => ListTile(
                  title: Text(option),
                  onTap: () {
                    controller.updateProjectPreference(option);
                    Get.back(); // Close BottomSheet
                  },
                )),
          ],
        ),
      ),
    );
  }
}

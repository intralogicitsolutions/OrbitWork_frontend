import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/component/profile/proficiency_level_bottomsheet.dart';

import '../../controllers/profile/language_controller.dart';
import 'language_search_bottomsheet.dart';

class AddLanguageBottomSheet extends StatelessWidget {
  final controller = Get.put(AddLanguageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
              const Text(
                'Add language',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Language',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Obx(() {
              return InkWell(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                        height: Get.height * 0.9,
                        child: LanguageSearchSheet(onLanguageSelected: (language) { controller.setLanguage(language); },)),
                    isScrollControlled: true,
                    ignoreSafeArea: false,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                        //'Search for language',
                        controller.selectedLanguage.isEmpty
                            ? 'Search for language'
                            : controller.selectedLanguage.value,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              );
            }
          ),
          const SizedBox(height: 20),
          const Text(
            'Proficiency level',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Obx(() {
              return InkWell(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                        // height: Get.height * 0.9,
                        child: ProficiencySelectionSheet(onProficiencySelected: (proficiency) {  controller.setProficiency(proficiency); },)),
                    isScrollControlled: true,
                    ignoreSafeArea: false,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        //'Search for proficiency level',
                        controller.selectedProficiency.value?.title ?? 'Search for proficiency level',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              );
            }
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom + 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Obx(() {
                    // final bool isEnabled = controller.selectedLanguage.isNotEmpty &&
                    //     controller.selectedProficiency.isNotEmpty;
                    return ElevatedButton(
                      onPressed: controller.isFormValid.value
                          ? controller.saveLanguage
                          : null,
                      // onPressed: isEnabled ? () {
                      //   // Handle save action
                      //   Get.back();
                      // } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                      ),
                      child: const Text('Save'),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
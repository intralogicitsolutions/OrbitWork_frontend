import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/component/select_company_bottomsheet.dart';
import 'package:orbitwork/component/select_country_bottomsheet.dart';
import 'package:orbitwork/component/select_jobTitle_bottomsheet.dart';
import 'package:orbitwork/component/select_month_bottomsheet.dart';
import 'package:orbitwork/component/select_year_bottomsheet.dart';
import '../controllers/work_experience_controller.dart';
import '../models/company_model.dart';
import '../models/job_title_model.dart';

class WorkExperienceSheet extends GetView<WorkExperienceController> {
  final WorkExperienceController controller = Get.put(WorkExperienceController());
  //const WorkExperienceSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Work Experience',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),

          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Field
                  _buildLabel('Title', true),
                  // Obx(
                  //    () {
                  //     return TextField(
                  //       readOnly: true,
                  //       controller: TextEditingController(text: controller.company.value),
                  //       //onChanged: (value) => controller.title.value = value,
                  //       decoration: const InputDecoration(
                  //         hintText: 'Ex: Software Engineer',
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(8)),
                  //         ),
                  //         contentPadding: EdgeInsets.symmetric(
                  //           horizontal: 16,
                  //           vertical: 12,
                  //         ),
                  //       ),
                  //     );
                  //   }
                  // ),
                  InkWell(
                    onTap: () async {
                      final selectedTitle = await Get.bottomSheet<JobTitle>(
                        TitleBottomSheet(),
                        isScrollControlled: true,
                      );

                      if (selectedTitle != null) {
                        controller.title.value = selectedTitle.name;
                      }
                    },
                    child: Container(
                      width: Get.width,
                      height: 48,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Obx(() => Text(
                        controller.title.value.isEmpty
                            ? 'Ex: Software Engineer'
                            : controller.title.value,
                        style: TextStyle(
                          fontSize: 16,
                          color: controller.title.value.isEmpty ? Colors.grey : Colors.black,
                        ),
                      )),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Company Field
                  _buildLabel('Company', true),
                  // TextField(
                  //   onChanged: (value) => controller.company.value = value,
                  //   decoration: const InputDecoration(
                  //     hintText: 'Ex: Microsoft',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(8)),
                  //     ),
                  //     contentPadding: EdgeInsets.symmetric(
                  //       horizontal: 16,
                  //       vertical: 12,
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    onTap: () async {
                      final selectedCompany = await Get.bottomSheet<Company>(
                        Container(
                          height: Get.height * 0.7,
                          child: CompanyBottomSheet(),
                        ),
                        isScrollControlled: true,
                      );

                      if (selectedCompany != null) {
                        controller.company.value = selectedCompany.name;
                      }
                    },
                    child: Container(
                      width: Get.width,
                      height: 48,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Obx(() => Text(
                        controller.company.value.isEmpty
                            ? 'Ex: Microsoft'
                            : controller.company.value,
                        style: TextStyle(
                          fontSize: 16,
                          color: controller.company.value.isEmpty ? Colors.grey : Colors.black,
                        ),
                      )),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Location Field
                  _buildLabel('Location'),
                  TextField(
                    controller: controller.locationController,
                    onChanged: (value) => controller.location.value = value,
                    decoration: const InputDecoration(
                      hintText: 'Ex: London',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Country Dropdown
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // child: ListTile(
                    //   title: const Text('Country'),
                    //   trailing: const Icon(Icons.keyboard_arrow_down),
                    //   onTap: () {
                    //     // Implement country selection
                    //   },
                    // ),
                    child: InkWell(
                      onTap: () {
                       Get.bottomSheet(
                         Container(
                             height: Get.height * 0.9,
                             child: CountryBottomsheet()),
                         isScrollControlled: true,
                       );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Center items
                          children: [
                            Obx(
                               () {
                                return Text(
                                  // 'Country',
                                  controller.selectedCountry.value.isEmpty
                                      ? 'Country'
                                      : controller.selectedCountry.value,
                                //  style: TextStyle(fontSize: 14),
                                );
                              }
                            ),
                            const SizedBox(width: 5), // Spacing between text and icon
                            const Icon(Icons.keyboard_arrow_down, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Current Role Checkbox
                  Row(
                    children: [
                      Obx(() => Checkbox(
                        value: controller.isCurrentRole.value,
                        onChanged: controller.toggleCurrentRole,
                      )),
                      const Text(
                        'I am currently working in this role',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Start Date
                  _buildLabel('Start Date', true),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () {
                              // Implement month selection
                              Get.bottomSheet(
                                 Container(
                                   height: Get.height * 0.9,
                                     child: MonthBottomSheet()),
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(
                                    () {
                                      return Text(
                                       // 'Month',
                                        controller.selectedMonth.value?.name ?? 'Month',
                                        style: TextStyle(fontSize: 14),
                                      );
                                    }
                                  ),
                                  const SizedBox(width: 5), // Spacing between text and icon
                                  const Icon(Icons.keyboard_arrow_down, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () {
                              controller.showStartYearPicker();
                              // Get.bottomSheet(
                              //   Container(
                              //     height: Get.height * 0.9,
                              //       child: SelectYearBottomsheet()
                              //   ),
                              //   isScrollControlled: true,
                              // );
                              // Implement month selection
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Center items
                                children: [
                                  Obx(
                                    () {
                                      return Text(
                                       // 'Year',
                                       // controller.selectedYear.value.toString() ,
                                        controller.startYear.value.toString(),
                                        style: TextStyle(fontSize: 14),
                                      );
                                    }
                                  ),
                                  const SizedBox(width: 5), // Spacing between text and icon
                                  const Icon(Icons.keyboard_arrow_down, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // End Date
                  _buildLabel('End Date', true),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.bottomSheet(
                                Container(
                                    height: Get.height * 0.9,
                                    child: MonthBottomSheet()),
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Center items
                                children: [
                                  Obx(
                                     () {
                                      return Text(
                                        //'Month',
                                        controller.selectedMonth.value?.name ?? 'Month',
                                        style: TextStyle(fontSize: 14),
                                      );
                                    }
                                  ),
                                  const SizedBox(width: 5), // Spacing between text and icon
                                  const Icon(Icons.keyboard_arrow_down, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            onTap: () {
                              controller.showEndYearPicker();
                              // Get.bottomSheet(
                              //   Container(
                              //       height: Get.height * 0.9,
                              //       child: SelectYearBottomsheet()),
                              //   isScrollControlled: true,
                              // );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Center items
                                children: [
                                  Obx(
                                     () {
                                      return Text(
                                        //'Year',
                                       // controller.selectedYear.value.toString(),
                                        controller.endYear.value.toString(),
                                        style: TextStyle(fontSize: 14),
                                      );
                                    }
                                  ),
                                  const SizedBox(width: 5), // Spacing between text and icon
                                  const Icon(Icons.keyboard_arrow_down, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Location Field
                  _buildLabel('Description'),
                  TextField(
                    controller: controller.descriptionController,
                    onChanged: (value) => controller.description.value = value,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          ),

          // Bottom Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Obx(() => ElevatedButton(
                  onPressed: controller.canSave()
                      ? controller.saveExperience
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, [bool isRequired = false]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          children: isRequired
              ? const [
            TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
          ]
              : null,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/education_history_controller.dart';

class EducationHistoryBottomsheet extends GetView<EducationHistoryController>{
  final EducationHistoryController controller = Get.put(EducationHistoryController());
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
         Padding(
           padding: const EdgeInsets.all(16.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text('Add Education History',  style: TextStyle(
                 fontSize: 24,
                 fontWeight: FontWeight.w400,
               ),),
               IconButton(
                 icon: const Icon(Icons.close),
                 onPressed: () => Get.back(),
               ),
             ],
           ),
         ),
         Expanded(
           child: SingleChildScrollView(
             padding: const EdgeInsets.all(16),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 _buildLabel('School', true),
                 // TextField(
                 //   onChanged: (value) => controller.school.value = value,
                 //   decoration: const InputDecoration(
                 //     hintText: 'Ex: Northwestern University',
                 //     border: OutlineInputBorder(
                 //       borderRadius: BorderRadius.all(Radius.circular(8)),
                 //     ),
                 //     contentPadding: EdgeInsets.symmetric(
                 //       horizontal: 16,
                 //       vertical: 12,
                 //     ),
                 //   ),
                 // ),
                 Obx(() => buildTappableSelector(
                   label: 'School',
                   value: controller.school.value,
                   onTap: controller.showSchoolPicker,
                 )),
                 const SizedBox(height: 20),

                 _buildLabel('Degree'),
                 // TextField(
                 //   onChanged: (value) => controller.degree.value = value,
                 //   decoration: const InputDecoration(
                 //     hintText: 'Ex: Bachelors',
                 //     border: OutlineInputBorder(
                 //       borderRadius: BorderRadius.all(Radius.circular(8)),
                 //     ),
                 //     contentPadding: EdgeInsets.symmetric(
                 //       horizontal: 16,
                 //       vertical: 12,
                 //     ),
                 //   ),
                 // ),
                 Obx(() => buildTappableSelector(
                   label: 'Degree',
                   value: controller.degree.value,
                   onTap: controller.showDegreePicker,
                 )),

                 const SizedBox(height: 20),
                 _buildLabel('Field of Study'),
                 // TextField(
                 //   onChanged: (value) => controller.fieldOfStudy.value = value,
                 //   decoration: const InputDecoration(
                 //     hintText: 'Ex: Computer Science',
                 //     border: OutlineInputBorder(
                 //       borderRadius: BorderRadius.all(Radius.circular(8)),
                 //     ),
                 //     contentPadding: EdgeInsets.symmetric(
                 //       horizontal: 16,
                 //       vertical: 12,
                 //     ),
                 //   ),
                 // ),
                 Obx(() => buildTappableSelector(
                   label: 'Field of Study',
                   value: controller.fieldOfStudy.value,
                   onTap: controller.showFieldOfStudyPicker,
                 )),

                 const SizedBox(height: 20),

                 _buildLabel('Dates Attended'),
                 Container(
                   height: 48,
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.black54),
                     borderRadius: BorderRadius.circular(8),
                   ),
                   child: InkWell(
                     onTap: () {
                      controller.showStartYearPicker();
                     },
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           // Text(
                           //   'From',
                           // ),
                           Obx(() => Text(
                             controller.startYear.value == 0
                                 ? 'From'
                                 : controller.startYear.value.toString(),
                             style: const TextStyle(fontSize: 16),
                           )),
                           const SizedBox(width: 5),
                           const Icon(Icons.keyboard_arrow_down, size: 20),
                         ],
                       ),
                     ),
                   ),
                 ),

                 const SizedBox(height: 30),
                 Container(
                   height: 48,
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.black54),
                     borderRadius: BorderRadius.circular(8),
                   ),
                   child: InkWell(
                     onTap: () {
                      controller.showEndYearPicker();
                     },
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           // Text(
                           //   'To (or expected graduation year)',
                           // ),
                           Obx(() => Text(
                             controller.endYear.value == 0
                                 ? 'To (or expected graduation year)'
                                 : controller.endYear.value.toString(),
                             style: const TextStyle(fontSize: 16),
                           )),
                           const SizedBox(width: 5),
                           const Icon(Icons.keyboard_arrow_down, size: 20),
                         ],
                       ),
                     ),
                   ),
                 ),

                 const SizedBox(height: 20),
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
                     ? controller.saveEducation
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

  Widget buildTappableSelector({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value.isEmpty ? 'Select $label' : value),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }


}
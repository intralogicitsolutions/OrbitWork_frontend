import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/work_experience_controller.dart';

// class SelectYearBottomsheet extends StatelessWidget{
//   final WorkExperienceController controller = Get.put(WorkExperienceController());
//   final TextEditingController searchController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       color: Colors.white,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(
//                   color: Colors.grey.shade300,
//                   width: 1,
//                 ),
//               ),
//             ),
//             child: Row(
//               children: [
//                 InkWell(
//                   onTap: () => Get.back(),
//                   child: const Icon(Icons.close),
//                 ),
//                 const SizedBox(width: 16),
//                 const Text(
//                   'Year',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.all(16),
//             child: TextField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.search),
//                 hintText: 'Search',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey.shade200,
//               ),
//               onChanged: (value) {
//                 controller.filterYears(value);
//               },
//             ),
//           ),
//           Expanded(
//             child: Obx(
//                () {
//                 return ListView.builder(
//                   itemCount: controller.filteredYears.length,
//                   itemBuilder: (context, index) {
//                     final year = DateTime.now().year - index;
//                     return Obx(() => RadioListTile<int>(
//                       value: year,
//                       groupValue: controller.selectedYear.value,
//                       onChanged: (value) => controller.updateYear(value!),
//                       title: Text(
//                         year.toString(),
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                     ));
//                   },
//                 );
//               }
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


class SelectYearBottomsheet extends StatelessWidget {
  final String title;
  final RxInt selectedYear;
  final void Function(int) onYearSelected;

  SelectYearBottomsheet({
    required this.title,
    required this.selectedYear,
    required this.onYearSelected,
    super.key,
  });

  final TextEditingController searchController = TextEditingController();
  final RxList<int> filteredYears = List.generate(100, (i) => DateTime.now().year - i).obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
       // mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Search Field
          Container(
            margin: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
              onChanged: (value) {
                final allYears = List.generate(100, (i) => DateTime.now().year - i);
                filteredYears.value = allYears
                    .where((y) => y.toString().contains(value))
                    .toList();
              },
            ),
          ),

          // List of Years
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: filteredYears.length,
                itemBuilder: (context, index) {
                  final year = filteredYears[index];
                  return Obx(() => RadioListTile<int>(
                    value: year,
                    groupValue: selectedYear.value,
                    onChanged: (value) {
                      onYearSelected(value!);
                      Get.back(); // dismiss after selection
                    },
                    title: Text(
                      year.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ));
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

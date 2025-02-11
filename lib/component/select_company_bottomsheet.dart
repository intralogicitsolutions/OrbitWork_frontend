import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/work_experience_controller.dart';

// class SelectCompanyBottomsheet extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Row(
//             children: [
//               IconButton(onPressed: () {
//                 Get.back();
//               }, icon: Icon(Icons.close)),
//               Text('Company', style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500
//               ),)
//             ],
//           ),
//           TextField(
//             decoration: InputDecoration(
//               hintText: 'Search Company',
//               prefixIcon: Icon(Icons.search),
//
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
// }


class CompanyBottomSheet extends StatelessWidget {
//final WorkExperienceController controller = Get.put(WorkExperienceController());
  final WorkExperienceController controller = Get.find<WorkExperienceController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery
      //     .of(context)
      //     .size
      //     .height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
                Text(
                  'Company',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 40), // For symmetry
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: controller.searchCompanies,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),

          // Company List
          Expanded(
            child: Obx(
                  () =>
                  ListView.builder(
                    itemCount: controller.filteredCompanies.length,
                    itemBuilder: (context, index) {
                      final company = controller
                          .filteredCompanies[index];
                      return ListTile(
                        title: Text(
                          company.name,
                          style: TextStyle(fontSize: 16),
                        ),
                        onTap: () {
                          controller.company.value = company.name;
                          // Handle company selection
                          Get.back(result: company);
                        },
                      );
                    },
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:orbitwork/controllers/language_controller.dart';
//
// // void showProficiencyBottomSheet() {
// //
// //   // Get.bottomSheet(
// //   //   // Container(
// //   //   //   height: 400,
// //   //   //   decoration: BoxDecoration(
// //   //   //     color: Colors.white,
// //   //   //     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// //   //   //   ),
// //   //   //   child: Column(
// //   //   //     crossAxisAlignment: CrossAxisAlignment.start,
// //   //   //     children: [
// //   //   //       Container(
// //   //   //         padding: EdgeInsets.all(16),
// //   //   //         decoration: BoxDecoration(
// //   //   //           border: Border(
// //   //   //             bottom: BorderSide(color: Colors.grey[300]!),
// //   //   //           ),
// //   //   //         ),
// //   //   //         child: Row(
// //   //   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //   //   //           children: [
// //   //   //             Text(
// //   //   //               'My level is',
// //   //   //               style: TextStyle(
// //   //   //                 fontSize: 20,
// //   //   //                 fontWeight: FontWeight.bold,
// //   //   //               ),
// //   //   //             ),
// //   //   //             IconButton(
// //   //   //               icon: Icon(Icons.close),
// //   //   //               onPressed: () => Get.back(),
// //   //   //             ),
// //   //   //           ],
// //   //   //         ),
// //   //   //       ),
// //   //   //       Expanded(
// //   //   //         child: ListView.builder(
// //   //   //           itemCount: proficiencyLevels.length,
// //   //   //           itemBuilder: (context, index) {
// //   //   //             return RadioListTile<String>(
// //   //   //               title: Text(
// //   //   //                 proficiencyLevels[index].name,
// //   //   //                 style: TextStyle(
// //   //   //                   fontSize: 16,
// //   //   //                   fontWeight: FontWeight.w500,
// //   //   //                 ),
// //   //   //               ),
// //   //   //               subtitle: Text(
// //   //   //                 proficiencyLevels[index].description,
// //   //   //                 style: TextStyle(
// //   //   //                   color: Colors.grey[600],
// //   //   //                   fontSize: 14,
// //   //   //                 ),
// //   //   //               ),
// //   //   //               value: proficiencyLevels[index].name,
// //   //   //               groupValue: selectedProficiency.value,
// //   //   //               onChanged: (value) {
// //   //   //                 selectedProficiency.value = value!;
// //   //   //                 Get.back();
// //   //   //               },
// //   //   //             );
// //   //   //           },
// //   //   //         ),
// //   //   //       ),
// //   //   //     ],
// //   //   //   ),
// //   //   // ),
// //   //   // isScrollControlled: true,
// //   //   // backgroundColor: Colors.transparent,
// //   // );
// // }
//
// class ProficiencyBottomsheet extends StatelessWidget{
//   final LanguageController controller = Get.put(LanguageController());
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 400,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               border: Border(
//                 bottom: BorderSide(color: Colors.grey[300]!),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'My level is',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.close),
//                   onPressed: () => Get.back(),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: controller.proficiencyLevels.length,
//               itemBuilder: (context, index) {
//                 return RadioListTile<String>(
//                   title: Text(
//                     controller.proficiencyLevels[index].name,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   subtitle: Text(
//                     controller.proficiencyLevels[index].description!,
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 14,
//                     ),
//                   ),
//                   value: controller.proficiencyLevels[index].name,
//                   groupValue: controller.selectedProficiency.value,
//                   onChanged: (value) {
//                     controller.selectedProficiency.value = value!;
//                     Get.back();
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }

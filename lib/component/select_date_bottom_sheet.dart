import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/dateselector_controller.dart';


class SelectDateBottomSheet extends StatelessWidget {
  final DateSelectorController controller = Get.put(DateSelectorController());

  @override

  Widget _buildCustomDatePicker(BuildContext context) {
    final controller = Get.find<DateSelectorController>();
    return Column(
      children: [
        Text(
          "Select Custom Date Range",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () async {
            // Directly show the DateRangePicker when the TextButton is pressed
            final DateTimeRange? picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );

            if (picked != null) {
              controller.selectDateLabel('Custom date range');
              controller.dateRanges.last['range'] =
              '${DateFormat('MMM dd, yyyy').format(picked.start)} - ${DateFormat('MMM dd, yyyy').format(picked.end)}';
            }
            controller.toggleCustomDatePicker(false); // Close picker after selection
          },
          child: const Text("Select Date Range"),
        ),
        TextButton(
          onPressed: () => controller.toggleCustomDatePicker(false),
          child: const Text("Back to Date List"),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16), // Add rounded corners to the top
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.6, // 60% of screen
          minChildSize: 0.6,
          maxChildSize: 0.8, // 80% of screen
          builder: (context, scrollController) {
            return Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Select date",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text("Cancel"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Obx(() {
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: controller.dateRanges.length,
                        itemBuilder: (context, index) {
                          final dateRange = controller.dateRanges[index];
                          if (dateRange['label'] == 'Custom date range' &&
                              controller.isCustomDatePickerOpen.value) {
                            // Directly show the DateRangePicker inline for "Custom date range"
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(dateRange['label']!),
                                  subtitle: dateRange['range']!.isNotEmpty
                                      ? Text(dateRange['range']!)
                                      : null,
                                  trailing: const Icon(Icons.check, color: Colors.green),
                                  onTap: () async {
                                    // Trigger the showDateRangePicker directly on tap
                                    final DateTimeRange? picked = await showDateRangePicker(
                                      context: context,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now(),
                                    );

                                    if (picked != null) {
                                      controller.selectDateLabel('Custom date range');
                                      controller.dateRanges.last['range'] =
                                      '${DateFormat('MMM dd, yyyy').format(picked.start)} - ${DateFormat('MMM dd, yyyy').format(picked.end)}';
                                    }
                                    controller.toggleCustomDatePicker(false); // Close picker after selection
                                  },
                                ),
                                _buildCustomDatePicker(context),

                              ],
                            );
                          } else {
                            return ListTile(
                              title: Text(dateRange['label']!),
                              subtitle: dateRange['range']!.isNotEmpty
                                  ? Text(dateRange['range']!)
                                  : null,
                              trailing: controller.selectedDateLabel.value == dateRange['label']
                                  ? const Icon(Icons.check, color: Colors.green)
                                  : null,
                              onTap: () {
                                if (dateRange['label'] == 'Custom date range') {
                                  controller.toggleCustomDatePicker(true);
                                } else {
                                  controller.selectDateLabel(dateRange['label']!);
                                  Get.back(); // Close the bottom sheet
                                }
                              },
                            );
                          }
                        },
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }





  // Widget build(BuildContext context) {
  //   return Obx(() {
  //     if (controller.isCustomDatePickerOpen.value) { // Observable variable
  //       return _buildCustomDatePicker(context);
  //     } else {
  //       return ListView.builder(
  //         controller: scrollController,
  //         itemCount: controller.dateRanges.length, // Observable variable
  //         itemBuilder: (context, index) {
  //           final dateRange = controller.dateRanges[index];
  //           return ListTile(
  //             title: Text(dateRange['label']!),
  //             subtitle: dateRange['range']!.isNotEmpty ? Text(dateRange['range']!) : null,
  //             trailing: controller.selectedDateLabel.value == dateRange['label'] // Observable variable
  //                 ? const Icon(Icons.check, color: Colors.green)
  //                 : null,
  //             onTap: () {
  //               if (dateRange['label'] == 'Custom date range') {
  //                 controller.toggleCustomDatePicker(true);
  //               } else {
  //                 controller.selectDateLabel(dateRange['label']!);
  //                 Get.back(); // Close the bottom sheet
  //               }
  //             },
  //           );
  //         },
  //       );
  //     }
  //   });
  //
  //   //   Obx(() {
  //   //   return DraggableScrollableSheet(
  //   //     initialChildSize: 0.6, // 60% of screen
  //   //     minChildSize: 0.6,
  //   //     maxChildSize: 0.8, // 80% of screen
  //   //     builder: (context, scrollController) {
  //   //       return Container(
  //   //         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
  //   //         child: Column(
  //   //           crossAxisAlignment: CrossAxisAlignment.start,
  //   //           children: [
  //   //             Row(
  //   //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //               children: [
  //   //                 const Text(
  //   //                   "Select date",
  //   //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //   //                 ),
  //   //                 TextButton(
  //   //                   onPressed: () => Get.back(),
  //   //                   child: const Text("Cancel"),
  //   //                 ),
  //   //               ],
  //   //             ),
  //   //             const SizedBox(height: 10),
  //   //             Expanded(
  //   //               child: Obx(() {
  //   //                 // Toggle between ListView and DateRangePicker
  //   //                 if (controller.isCustomDatePickerOpen.value) {
  //   //                   return _buildCustomDatePicker(context);
  //   //                 } else {
  //   //                   return ListView.builder(
  //   //                     controller: scrollController,
  //   //                     itemCount: controller.dateRanges.length,
  //   //                     itemBuilder: (context, index) {
  //   //                       final dateRange = controller.dateRanges[index];
  //   //                       return ListTile(
  //   //                         title: Text(dateRange['label']!),
  //   //                         subtitle: dateRange['range']!.isNotEmpty ? Text(dateRange['range']!) : null,
  //   //                         trailing: controller.selectedDateLabel.value == dateRange['label']
  //   //                             ? const Icon(Icons.check, color: Colors.green)
  //   //                             : null,
  //   //                         onTap: () {
  //   //                           if (dateRange['label'] == 'Custom date range') {
  //   //                             controller.toggleCustomDatePicker(true);
  //   //                           } else {
  //   //                             controller.selectDateLabel(dateRange['label']!);
  //   //                             Get.back(); // Close the bottom sheet
  //   //                           }
  //   //                         },
  //   //                       );
  //   //                     },
  //   //                   );
  //   //                 }
  //   //               }),
  //   //             ),
  //   //           ],
  //   //         ),
  //   //       );
  //   //     },
  //   //   );
  //   // });
  // }

  Widget _buildCustomDatePicker1(BuildContext context) {
    final controller = Get.find<DateSelectorController>();

    return Column(
      children: [
        Text(
          "Select Custom Date Range",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () async {
            final DateTimeRange? picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );

            if (picked != null) {
              controller.selectDateLabel('Custom date range');
              controller.dateRanges.last['range'] =
              '${DateFormat('MMM dd, yyyy').format(picked.start)} - ${DateFormat('MMM dd, yyyy').format(picked.end)}';
            }
            controller.toggleCustomDatePicker(false);
          },
          child: const Text("Pick Date Range"),
        ),
        TextButton(
          onPressed: () => controller.toggleCustomDatePicker(false),
          child: const Text("Back to Date List"),
        ),
      ],
    );
  }
}


// class SelectDateBottomSheet extends StatelessWidget {
//   final DateSelectorController controller = Get.put(DateSelectorController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Container(
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Select date",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   TextButton(
//                     onPressed: () => Get.back(),
//                     child: const Text("Cancel"),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: controller.dateRanges.length,
//                 itemBuilder: (context, index) {
//                   final dateRange = controller.dateRanges[index];
//                   return ListTile(
//                     title: Text(dateRange['label']!),
//                     subtitle: dateRange['range']!.isNotEmpty ? Text(dateRange['range']!) : null,
//                     trailing: controller.selectedDateLabel.value == dateRange['label']
//                         ? const Icon(Icons.check, color: Colors.green)
//                         : null,
//                     onTap: () {
//                       if (dateRange['label'] == 'Custom date range') {
//                         _showDateRangePicker(context, controller);
//                       } else {
//                         controller.selectDateLabel(dateRange['label']!);
//                         Get.back(); // Close the bottom sheet
//                       }
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   Future<void> _showDateRangePicker(BuildContext context, DateSelectorController controller) async {
//     final DateTimeRange? picked = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             primaryColor: Colors.blue,
//             hintColor: Colors.blue,
//             buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (picked != null) {
//       controller.selectDateLabel('Custom date range');
//       controller.dateRanges.last['range'] =
//       '${DateFormat('MMM dd, yyyy').format(picked.start)} - ${DateFormat('MMM dd, yyyy').format(picked.end)}';
//       Get.back(); // Close the bottom sheet
//     }
//   }
// }

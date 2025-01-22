import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../controllers/dateselector_controller.dart';

class SelectDateBottomSheet extends StatelessWidget {
  final DateSelectorController controller = Get.put(DateSelectorController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.6,
          maxChildSize: 0.8,
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.green),
                        ),
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
                          if (dateRange['label'] == 'Custom date range') {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(dateRange['label']!),
                                  subtitle: dateRange['range']!.isNotEmpty
                                      ? Text(dateRange['range']!)
                                      : null,
                                  trailing: controller.selectedDateLabel.value == 'Custom date range'
                                      ? const Icon(Icons.check, color: Colors.green)
                                      : null,
                                  onTap: () {
                                    controller
                                        .selectDateLabel(dateRange['label']!);
                                    // Get.back();
                                    // Directly show the custom date picker without closing the bottom sheet
                                   controller.toggleCustomDatePicker(true);
                                  },
                                ),
                                if (controller.selectedDateLabel.value == 'Custom date range')
                                  _buildCustomDatePicker(context),
                                // if (controller.isCustomDatePickerOpen.value)
                                //   _buildCustomDatePicker(context),
                              ],
                            );
                          }
                          else {
                            return ListTile(
                              title: dateRange['label'] != null && dateRange['label']!.isNotEmpty
                                  ? Text(dateRange['label']!)
                                  : null,
                              subtitle: dateRange['range']!.isNotEmpty
                                  ? Text(dateRange['range']!)
                                  : null,
                              trailing: controller.selectedDateLabel.value ==
                                      dateRange['label']
                                  ? const Icon(Icons.check, color: Colors.green)
                                  : null,
                              onTap: () {
                                controller.selectDateLabel(dateRange['label']!);
                                Get.back();
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

  // Widget _buildCustomDatePicker(BuildContext context) {
  //   final controller = Get.find<DateSelectorController>();
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       CalendarDatePicker(
  //         initialDate: DateTime.now(),
  //         firstDate: DateTime(2000),
  //         lastDate: DateTime.now(),
  //         onDateChanged: (selectedDate) {
  //           if (controller.customStartDate.value == null) {
  //             controller.customStartDate.value = selectedDate;
  //           } else {
  //             controller.customEndDate.value = selectedDate;
  //           }
  //         },
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Expanded(
  //             child: TextField(
  //               readOnly: true,
  //               controller: TextEditingController(
  //                 text: controller.customStartDate.value != null
  //                     ? DateFormat('MMM dd, yyyy').format(controller.customStartDate.value!)
  //                     : '',
  //               ),
  //               decoration: const InputDecoration(
  //                 prefixIcon: Icon(Icons.calendar_today),
  //                 labelText: 'Start Date',
  //                 border: OutlineInputBorder(),
  //               ),
  //               onTap: () async {
  //                 final selectedDate = await showDatePicker(
  //                   context: context,
  //                   initialDate: controller.customStartDate.value ?? DateTime.now(),
  //                   firstDate: DateTime(2000),
  //                   lastDate: DateTime.now(),
  //                 );
  //                 if (selectedDate != null) {
  //                   controller.customStartDate.value = selectedDate;
  //                 }
  //               },
  //             ),
  //           ),
  //           const SizedBox(width: 10),
  //           Expanded(
  //             child: TextField(
  //               readOnly: true,
  //               controller: TextEditingController(
  //                 text: controller.customEndDate.value != null
  //                     ? DateFormat('MMM dd, yyyy').format(controller.customEndDate.value!)
  //                     : '',
  //               ),
  //               decoration: const InputDecoration(
  //                 prefixIcon: Icon(Icons.calendar_today),
  //                 labelText: 'End Date',
  //                 border: OutlineInputBorder(),
  //               ),
  //               onTap: () async {
  //                 final selectedDate = await showDatePicker(
  //                   context: context,
  //                   initialDate: controller.customEndDate.value ?? DateTime.now(),
  //                   firstDate: DateTime(2000),
  //                   lastDate: DateTime.now(),
  //                 );
  //                 if (selectedDate != null) {
  //                   controller.customEndDate.value = selectedDate;
  //                 }
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 16),
  //       Center(
  //         child: ElevatedButton(
  //           onPressed: () {
  //             if (controller.customStartDate.value != null &&
  //                 controller.customEndDate.value != null) {
  //               controller.dateRanges.last['range'] =
  //               '${DateFormat('MMM dd, yyyy').format(controller.customStartDate.value!)} - ${DateFormat('MMM dd, yyyy').format(controller.customEndDate.value!)}';
  //               Get.back(); // Close the bottom sheet
  //             }
  //           },
  //           style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
  //           child: const Text("Done", style: TextStyle(color: Colors.white),),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildCustomDatePicker(BuildContext context) {
    final controller = Get.find<DateSelectorController>();
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SfDateRangePicker(
          backgroundColor: theme.scaffoldBackgroundColor,
          todayHighlightColor: theme.primaryColor,
          selectionColor: Colors.green,
          rangeSelectionColor: Colors.black.withOpacity(0.2),
          startRangeSelectionColor: Colors.black, // Start date color in range
          endRangeSelectionColor: Colors.black,
          headerStyle: DateRangePickerHeaderStyle(
            textStyle: TextStyle(
             // color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: theme.scaffoldBackgroundColor, // Header background color
          ),
          selectionMode: DateRangePickerSelectionMode.range,
          initialSelectedRange: PickerDateRange(
            controller.customStartDate.value ?? DateTime.now(),
            controller.customEndDate.value ?? DateTime.now(),
          ),
          minDate: DateTime(2000),
          maxDate: DateTime.now(),

          monthCellStyle: DateRangePickerMonthCellStyle(
            todayTextStyle: TextStyle(color: Colors.black), // Style for today's text

            blackoutDateTextStyle: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          // onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
          //   if (args.value is PickerDateRange) {
          //     final PickerDateRange range = args.value;
          //     controller.customStartDate.value = range.startDate;
          //     controller.customEndDate.value = range.endDate;
          //   }
          // },
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              if (args.value is PickerDateRange) {
                final PickerDateRange range = args.value;
                controller.customStartDate.value = range.startDate;
                controller.customEndDate.value = range.endDate;

                // Update the range in the "Custom date range" item
                if (range.startDate != null && range.endDate != null) {
                  final formattedStart = DateFormat('MMM dd, yyyy').format(range.startDate!);
                  final formattedEnd = DateFormat('MMM dd, yyyy').format(range.endDate!);
                  controller.dateRanges.firstWhere((element) =>
                  element['label'] == 'Custom date range')['range'] =
                  '$formattedStart - $formattedEnd';
                }
              }
            }

        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                readOnly: true,
                controller: TextEditingController(
                  text: controller.customStartDate.value != null
                      ? DateFormat('MMM dd, yyyy')
                          .format(controller.customStartDate.value!)
                      : '',
                ),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today),
                  labelText: 'Start Date',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                readOnly: true,
                controller: TextEditingController(
                  text: controller.customEndDate.value != null
                      ? DateFormat('MMM dd, yyyy')
                          .format(controller.customEndDate.value!)
                      : '',
                ),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today),
                  labelText: 'End Date',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton(
            onPressed: () {
              if (controller.customStartDate.value != null &&
                  controller.customEndDate.value != null) {
                // controller.dateRanges.add({
                //   'range':
                //       '${DateFormat('MMM dd, yyyy').format(controller.customStartDate.value!)} - ${DateFormat('MMM dd, yyyy').format(controller.customEndDate.value!)}',
                // });
                Get.back(); // Close the bottom sheet
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text(
              "Done",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

// Widget _buildCustomDatePicker(BuildContext context) {
//   final controller = Get.find<DateSelectorController>();
//
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       SfDateRangePicker(
//         initialDisplayDate: controller.customStartDate.value != null && controller.customEndDate.value != null
//             ? DateTimeRange(
//           start: controller.customStartDate.value!,
//           end: controller.customEndDate.value!,
//         )
//             : DateTimeRange(start: DateTime.now(), end: DateTime.now()),
//         view: DateRangePickerView.month,  // Set the view as month
//         firstDate: DateTime(2000),
//         lastDate: DateTime.now(),
//         onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
//           if (args.value != null) {
//             controller.customStartDate.value = args.value.startDate;
//             controller.customEndDate.value = args.value.endDate;
//           }
//         },
//       ),
//       const SizedBox(height: 16),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: TextField(
//               readOnly: true,
//               controller: TextEditingController(
//                 text: controller.customStartDate.value != null
//                     ? DateFormat('MMM dd, yyyy').format(controller.customStartDate.value!)
//                     : '',
//               ),
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.calendar_today),
//                 labelText: 'Start Date',
//                 border: OutlineInputBorder(),
//               ),
//               onTap: () async {
//                 final selectedDate = await showDatePicker(
//                   context: context,
//                   initialDate: controller.customStartDate.value ?? DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime.now(),
//                 );
//                 if (selectedDate != null) {
//                   controller.customStartDate.value = selectedDate;
//                 }
//               },
//             ),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: TextField(
//               readOnly: true,
//               controller: TextEditingController(
//                 text: controller.customEndDate.value != null
//                     ? DateFormat('MMM dd, yyyy').format(controller.customEndDate.value!)
//                     : '',
//               ),
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.calendar_today),
//                 labelText: 'End Date',
//                 border: OutlineInputBorder(),
//               ),
//               onTap: () async {
//                 final selectedDate = await showDatePicker(
//                   context: context,
//                   initialDate: controller.customEndDate.value ?? DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime.now(),
//                 );
//                 if (selectedDate != null) {
//                   controller.customEndDate.value = selectedDate;
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(height: 16),
//       Center(
//         child: ElevatedButton(
//           onPressed: () {
//             if (controller.customStartDate.value != null && controller.customEndDate.value != null) {
//               controller.dateRanges.last['range'] =
//               '${DateFormat('MMM dd, yyyy').format(controller.customStartDate.value!)} - ${DateFormat('MMM dd, yyyy').format(controller.customEndDate.value!)}';
//               Get.back(); // Close the bottom sheet
//             }
//           },
//           style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//           child: const Text("Done", style: TextStyle(color: Colors.white)),
//         ),
//       ),
//     ],
//   );
// }

// Widget _buildCustomDatePicker(BuildContext context) {
//   final controller = Get.find<DateSelectorController>();
//
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         "Select Custom Date Range",
//         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//       const SizedBox(height: 16),
//       Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             // Show the date range picker directly
//             final DateTimeRange? picked = await showDateRangePicker(
//               context: context,
//               initialDateRange: controller.customStartDate.value != null &&
//                   controller.customEndDate.value != null
//                   ? DateTimeRange(
//                 start: controller.customStartDate.value!,
//                 end: controller.customEndDate.value!,
//               )
//                   : null,
//               firstDate: DateTime(2000),
//               lastDate: DateTime.now(),
//             );
//
//             if (picked != null) {
//               // Update selected date range
//               controller.customStartDate.value = picked.start;
//               controller.customEndDate.value = picked.end;
//               controller.dateRanges.last['range'] =
//               '${DateFormat('MMM dd, yyyy').format(picked.start)} - ${DateFormat('MMM dd, yyyy').format(picked.end)}';
//               controller.selectDateLabel('Custom date range');
//             }
//           },
//           style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//           child: const Text("Pick Date Range", style: TextStyle(color: Colors.white)),
//         ),
//       ),
//       const SizedBox(height: 16),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: TextField(
//               readOnly: true,
//               controller: TextEditingController(
//                 text: controller.customStartDate.value != null
//                     ? DateFormat('MMM dd, yyyy').format(controller.customStartDate.value!)
//                     : '',
//               ),
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.calendar_today),
//                 labelText: 'Start Date',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: TextField(
//               readOnly: true,
//               controller: TextEditingController(
//                 text: controller.customEndDate.value != null
//                     ? DateFormat('MMM dd, yyyy').format(controller.customEndDate.value!)
//                     : '',
//               ),
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.calendar_today),
//                 labelText: 'End Date',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(height: 16),
//       Center(
//         child: ElevatedButton(
//           onPressed: () {
//             if (controller.customStartDate.value != null &&
//                 controller.customEndDate.value != null) {
//               Get.back(); // Close the bottom sheet
//             }
//           },
//           style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//           child: const Text("Done", style: TextStyle(color: Colors.white)),
//         ),
//       ),
//     ],
//   );
// }

// Widget _buildCustomDatePicker(BuildContext context) {
//   final controller = Get.find<DateSelectorController>();
//   return Column(
//     children: [
//       Text(
//         "Select Custom Date Range",
//         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//       const SizedBox(height: 16),
//       TextButton(
//         onPressed: () async {
//           // Directly show the DateRangePicker when the TextButton is pressed
//           final DateTimeRange? picked = await showDateRangePicker(
//             context: context,
//             firstDate: DateTime(2000),
//             lastDate: DateTime.now(),
//           );
//
//           if (picked != null) {
//             controller.selectDateLabel('Custom date range');
//             controller.dateRanges.last['range'] =
//             '${DateFormat('MMM dd, yyyy').format(picked.start)} - ${DateFormat('MMM dd, yyyy').format(picked.end)}';
//           }
//           controller.toggleCustomDatePicker(false); // Close picker after selection
//         },
//         child: const Text("Select Date Range"),
//       ),
//       TextButton(
//         onPressed: () => controller.toggleCustomDatePicker(false),
//         child: const Text("Back to Date List"),
//       ),
//     ],
//   );
// }
//
// Widget build(BuildContext context) {
//   final theme = Theme.of(context);
//   return Container(
//     height: MediaQuery.of(context).size.height,
//     child: ClipRRect(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(16), // Add rounded corners to the top
//       ),
//       child: DraggableScrollableSheet(
//         initialChildSize: 0.6, // 60% of screen
//         minChildSize: 0.6,
//         maxChildSize: 0.8, // 80% of screen
//         builder: (context, scrollController) {
//           return Container(
//             color: theme.scaffoldBackgroundColor,
//             padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Select date",
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     TextButton(
//                       onPressed: () => Get.back(),
//                       child: const Text("Cancel"),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Expanded(
//                   child: Obx(() {
//                     return ListView.builder(
//                       controller: scrollController,
//                       itemCount: controller.dateRanges.length,
//                       itemBuilder: (context, index) {
//                         final dateRange = controller.dateRanges[index];
//                         if (dateRange['label'] == 'Custom date range' &&
//                             controller.isCustomDatePickerOpen.value) {
//                           // Directly show the DateRangePicker inline for "Custom date range"
//                           return Column(
//                             children: [
//                               ListTile(
//                                 title: Text(dateRange['label']!),
//                                 subtitle: dateRange['range']!.isNotEmpty
//                                     ? Text(dateRange['range']!)
//                                     : null,
//                                 trailing: const Icon(Icons.check, color: Colors.green),
//                                 onTap: () async {
//                                   // Trigger the showDateRangePicker directly on tap
//                                   final DateTimeRange? picked = await showDateRangePicker(
//                                     context: context,
//                                     firstDate: DateTime(2000),
//                                     lastDate: DateTime.now(),
//                                   );
//
//                                   if (picked != null) {
//                                     controller.selectDateLabel('Custom date range');
//                                     controller.dateRanges.last['range'] =
//                                     '${DateFormat('MMM dd, yyyy').format(picked.start)} - ${DateFormat('MMM dd, yyyy').format(picked.end)}';
//                                   }
//                                   controller.toggleCustomDatePicker(false); // Close picker after selection
//                                 },
//                               ),
//                               _buildCustomDatePicker(context),
//
//                             ],
//                           );
//                         } else {
//                           return ListTile(
//                             title: Text(dateRange['label']!),
//                             subtitle: dateRange['range']!.isNotEmpty
//                                 ? Text(dateRange['range']!)
//                                 : null,
//                             trailing: controller.selectedDateLabel.value == dateRange['label']
//                                 ? const Icon(Icons.check, color: Colors.green)
//                                 : null,
//                             onTap: () {
//                               if (dateRange['label'] == 'Custom date range') {
//                                 controller.toggleCustomDatePicker(true);
//                               } else {
//                                 controller.selectDateLabel(dateRange['label']!);
//                                 Get.back(); // Close the bottom sheet
//                               }
//                             },
//                           );
//                         }
//                       },
//                     );
//                   }),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     ),
//   );
// }

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

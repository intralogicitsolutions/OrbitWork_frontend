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
                                Obx(() {
                                  return ListTile(
                                    title: Text(dateRange['label']!),
                                    subtitle:  Text(dateRange['range']!),
                                        //  Obx(
                                        //    () {
                                        //     return Text(controller.selectedDateRange,);
                                        //   }
                                        // ),

                                       // ? Text(dateRange['range']!)
                                    trailing:
                                        controller.selectedDateLabel.value ==
                                                'Custom date range'
                                            ? const Icon(Icons.check,
                                                color: Colors.green)
                                            : null,
                                    onTap: () {
                                      controller.selectDateLabel(dateRange['label']!);
                                      // Get.back();
                                      // Directly show the custom date picker without closing the bottom sheet
                                      //controller.toggleCustomDatePicker(true);
                                      if (dateRange['label'] == 'Custom date range') {
                                        controller.toggleCustomDatePicker(true);
                                      } else {
                                        Get.back();
                                      }
                                      //Get.back();
                                    },
                                  );
                                }),
                                Obx(() {
                                  print('controller.isCustomDatePickerOpen.value == ${controller.isCustomDatePickerOpen.value}');
                                  return controller.isCustomDatePickerOpen.value
                                      ? _buildCustomDatePicker(context)
                                      : const SizedBox();
                                }),
                                // if (controller.selectedDateLabel.value ==
                                //     'Custom date range')
                                //   _buildCustomDatePicker(context)

                                // if (controller.isCustomDatePickerOpen.value)
                                //   _buildCustomDatePicker(context),
                              ],
                            );
                          } else {
                            return Obx(() {
                              return ListTile(
                                title: dateRange['label'] != null &&
                                        dateRange['label']!.isNotEmpty
                                    ? Text(dateRange['label']!)
                                    : null,
                                subtitle: dateRange['range']!.isNotEmpty
                                    ? Text(dateRange['range']!)
                                    : null,
                                trailing: controller.selectedDateLabel.value ==
                                        dateRange['label']
                                    ? const Icon(Icons.check,
                                        color: Colors.green)
                                    : null,
                                onTap: () {
                                  controller.toggleCustomDatePicker(false);
                                  controller
                                      .selectDateLabel(dateRange['label']!);
                                  Get.back();
                                },
                              );
                            });
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
  //   final dateRangePickerController = DateRangePickerController();
  //   final theme = Theme.of(context);
  //
  //   return Obx(() {
  //     final startDateText = controller.customStartDate.value != null
  //         ? DateFormat('MMM dd, yyyy').format(controller.customStartDate.value!)
  //         : '';
  //     final endDateText = controller.customEndDate.value != null
  //         ? DateFormat('MMM dd, yyyy').format(controller.customEndDate.value!)
  //         : '';
  //
  //     // Update the display date of the picker based on the custom start date
  //     if (controller.customStartDate.value != null) {
  //       dateRangePickerController.displayDate = controller.customStartDate.value;
  //       dateRangePickerController.displayDate = controller.customEndDate.value;
  //     }
  //
  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SfDateRangePicker(
  //           controller: dateRangePickerController,
  //           backgroundColor: theme.scaffoldBackgroundColor,
  //           todayHighlightColor: theme.primaryColor,
  //           selectionColor: Colors.green,
  //           rangeSelectionColor: Colors.black.withOpacity(0.2),
  //           startRangeSelectionColor: Colors.black,
  //           endRangeSelectionColor: Colors.black,
  //           headerStyle: DateRangePickerHeaderStyle(
  //             textStyle: TextStyle(
  //               fontWeight: FontWeight.bold,
  //             ),
  //             backgroundColor: theme.scaffoldBackgroundColor,
  //           ),
  //           selectionMode: DateRangePickerSelectionMode.range,
  //           initialSelectedRange: PickerDateRange(
  //             controller.customStartDate.value ?? DateTime.now(),
  //             controller.customEndDate.value ?? DateTime.now(),
  //           ),
  //           minDate: DateTime(2000),
  //           maxDate: DateTime.now(),
  //           monthCellStyle: DateRangePickerMonthCellStyle(
  //             todayTextStyle: TextStyle(color: Colors.black),
  //             blackoutDateTextStyle: TextStyle(
  //               color: Colors.black,
  //               decoration: TextDecoration.lineThrough,
  //             ),
  //           ),
  //           onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
  //             if (args.value is PickerDateRange) {
  //               final PickerDateRange range = args.value;
  //               controller.customStartDate.value = range.startDate;
  //               controller.customEndDate.value = range.endDate;
  //
  //               // Update the display date to the start date of the selected range
  //               if (range.startDate != null && range.endDate !=null) {
  //                 dateRangePickerController.displayDate = range.startDate;
  //                 dateRangePickerController.displayDate = range.endDate;
  //               }
  //
  //               controller.updateCustomDateRange();
  //             }
  //           },
  //         ),
  //         const SizedBox(height: 10),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Expanded(
  //               child: TextField(
  //                 readOnly: true,
  //                 controller: TextEditingController(
  //                   text: startDateText,
  //                 ),
  //                 decoration: const InputDecoration(
  //                   prefixIcon: Icon(Icons.calendar_today),
  //                   labelText: 'Start Date',
  //                   border: OutlineInputBorder(),
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(width: 10),
  //             Expanded(
  //               child: TextField(
  //                 readOnly: true,
  //                 controller: TextEditingController(
  //                   text: endDateText,
  //                 ),
  //                 decoration: const InputDecoration(
  //                   prefixIcon: Icon(Icons.calendar_today),
  //                   labelText: 'End Date',
  //                   border: OutlineInputBorder(),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 16),
  //         Center(
  //           child: Builder(
  //             builder: (context) {
  //               return ElevatedButton(
  //                 onPressed: () {
  //                   if (controller.customStartDate.value != null &&
  //                       controller.customEndDate.value != null) {
  //                     Get.back(); // Close the bottom sheet
  //                   }
  //                 },
  //                 style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
  //                 child: const Text(
  //                   "Done",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     );
  //   });
  // }



Widget _buildCustomDatePicker(BuildContext context) {
    final controller = Get.find<DateSelectorController>();
    final theme = Theme.of(context);
    return Obx(() {
      final startDateText = controller.customStartDate.value != null
          ? DateFormat('MMM dd, yyyy').format(controller.customStartDate.value!)
          : '';
      final endDateText = controller.customEndDate.value != null
          ? DateFormat('MMM dd, yyyy').format(controller.customEndDate.value!)
          : '';

      DateTime displayDate = controller.customStartDate.value ??
          DateTime.now();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SfDateRangePicker(
            initialDisplayDate: displayDate,
              backgroundColor: theme.scaffoldBackgroundColor,
              todayHighlightColor: theme.primaryColor,
              selectionColor: Colors.green,
              rangeSelectionColor: Colors.black.withOpacity(0.2),
              startRangeSelectionColor: Colors.black,
              // Start date color in range
              endRangeSelectionColor: Colors.black,
              headerStyle: DateRangePickerHeaderStyle(
                textStyle: TextStyle(
                  // color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor:
                    theme.scaffoldBackgroundColor, // Header background color
              ),
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: PickerDateRange(
                controller.customStartDate.value ?? DateTime.now(),
                controller.customEndDate.value ?? DateTime.now(),
              ),
              minDate: DateTime(2000),
              maxDate: DateTime.now(),
              monthCellStyle: DateRangePickerMonthCellStyle(
                todayTextStyle: TextStyle(color: Colors.black),
                // Style for today's text

                blackoutDateTextStyle: TextStyle(
                  color: Colors.black,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is PickerDateRange) {
                  final PickerDateRange range = args.value;
                  controller.customStartDate.value = range.startDate;
                  controller.customEndDate.value = range.endDate;

                  if (range.startDate != null) {
                    displayDate = range.startDate!;
                  }

                  //controller.selectedDateLabel.value = 'Custom date range';
                  controller.updateCustomDateRange();

                  // if (range.startDate != null && range.endDate != null) {
                  //   Get.back(); // Automatically close the bottom sheet
                  // }

                  // Update the range in the "Custom date range" item
                  // if (range.startDate != null && range.endDate != null) {
                  //   final formattedStart =
                  //       DateFormat('MMM dd, yyyy').format(range.startDate!);
                  //   final formattedEnd =
                  //       DateFormat('MMM dd, yyyy').format(range.endDate!);
                  //   controller.dateRanges.firstWhere((element) =>
                  //           element['label'] == 'Custom date range')['range'] =
                  //       '$formattedStart - $formattedEnd';
                  // }
                }
              }),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text:  controller.customStartDate.value != null
                        ? DateFormat('MMM dd, yyyy').format(controller.customStartDate.value!)
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
                        ? DateFormat('MMM dd, yyyy').format(controller.customEndDate.value!)
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
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    if (controller.customStartDate.value != null &&
                        controller.customEndDate.value != null) {
                      //controller.toggleCustomDatePicker(false);
                      Get.back(); // Close the bottom sheet
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text(
                    "Done",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            ),
          ),
        ],
      );
    });
  }
}


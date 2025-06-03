import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../client_profile_controller/week_selector_controller.dart';

class WeekSelectorBottomSheet extends StatelessWidget {
  final WeekSelectorController controller = Get.find<WeekSelectorController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 8),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select week',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(Icons.close, size: 24, color: Colors.black),
                ),
              ],
            ),
          ),

          // Calendar
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Month navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: controller.previousMonth,
                        icon: Icon(Icons.chevron_left, size: 30),
                      ),
                      Obx(() => Text(
                        controller.getMonthYearString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                      IconButton(
                        onPressed: controller.nextMonth,
                        icon: Icon(Icons.chevron_right, size: 30),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Week days header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: controller.weekDays.map((day) =>
                        Container(
                          width: 40,
                          child: Center(
                            child: Text(
                              day,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                    ).toList(),
                  ),

                  SizedBox(height: 16),

                  // Calendar grid
                  Expanded(
                    child: Obx(() {
                      final days = controller.getDaysInMonth();
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: 1,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: days.length,
                        itemBuilder: (context, index) {
                          final date = days[index];
                          if (date == null) return SizedBox();

                          return Obx(() {

                            final isCurrentMonth = date.month == controller.currentMonth.value.month;
                            final isSelected = controller.isDateSelected(date);
                            final isStartDate = controller.isStartDate(date);
                            final isEndDate = controller.isEndDate(date);

                              return GestureDetector(
                                onTap: () => controller.selectDate(date),
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: (isStartDate || isEndDate)
                                        ? Colors.black
                                        : isSelected
                                        ? Colors.grey[200]
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${date.day}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: (isStartDate || isEndDate)
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: (isStartDate || isEndDate)
                                            ? Colors.white
                                            : isCurrentMonth
                                            ? Colors.black
                                            : Colors.grey[400],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          // Close button
          Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orbitwork/controllers/dateselector_controller.dart';

import '../../client_profile_controller/timesheet_controller.dart';

class TimesheetTab extends StatelessWidget{
  final TimesheetController controller = Get.put(TimesheetController());
  final dateSelectController = Get.put(DateSelectorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Timesheet', style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.w500
              ),),
              SizedBox(height: 24),

              // Date Range Selector
              _buildDateRangeSelector(),
              SizedBox(height: 20),

              // Filter and Display Settings
              Row(
                children: [
                  _buildFilterButton(),
                  SizedBox(width: 12),
                  Expanded(child: _buildDisplaySettingsButton()),
                ],
              ),
              SizedBox(height: 24,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icon/no-records.svg',
                      height: 80,
                      width: 80,
                    ),
                    SizedBox(height: 20,),
                    Text('No entries found', style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500
                    ),),
                    SizedBox(height: 10,),
                    Text('Try changing the data range.',
                        textAlign: TextAlign.center)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateRangeSelector() {
    return GestureDetector(
      onTap: () => controller.openDatePicker(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Obx(() => Text(
                //controller.selectedDateRange.value,
                dateSelectController.selectedDateRange,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              )),
            ),
            Icon(Icons.calendar_today_outlined, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton() {
    return GestureDetector(
      onTap: () => controller.openFilters(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.tune,
              color: Colors.green[600],
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Filters',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.green[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisplaySettingsButton() {
    return GestureDetector(
      onTap: () => controller.openDisplaySettings(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.display_settings,
              color: Colors.green[600],
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Display settings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.green[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
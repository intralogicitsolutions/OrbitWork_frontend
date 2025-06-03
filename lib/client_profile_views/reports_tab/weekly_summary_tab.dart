import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orbitwork/client_profile_controller/week_selector_controller.dart';

import '../../client_profile_controller/weekly_summary_controller.dart';
import '../../component/client_profile/week_selector_bottomsheet.dart';

class WeeklySummaryTab extends StatelessWidget{
  final WeeklySummaryController controller = Get.put(WeeklySummaryController());
  final WeekSelectorController weekSelectorController = Get.put(WeekSelectorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Weekly summary', style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.w500
              ),),
              SizedBox(height: 24,),


              _buildWeekSelector(context),
              SizedBox(height: 32),

              // Totals Section
              _buildTotalsSection(),
              SizedBox(height: 24),

              // Top 5 Contracts
              _buildExpandableSection(
                'Top 5 contracts',
                controller.topContractsExpanded,
                controller.toggleTopContracts,
              ),
              SizedBox(height: 16),

              // Top 5 Activities
              _buildExpandableSection(
                'Top 5 activities',
                controller.topActivitiesExpanded,
                controller.toggleTopActivities,
              ),
              SizedBox(height: 32),

              Text('Hourly', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icon/no-records.svg',
                      height: 60,
                      width: 60,
                    ),
                    SizedBox(height: 20,),
                    Text('No records to show', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500
                    ),),
                    SizedBox(height: 10,),
                    Text('There is no hourly data for the selected week',  textAlign: TextAlign.center,)
                  ],
                ),
              ),
              SizedBox(height: 32,),
              Text('Fixed price and other payments', style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500
              ),
              ),
              SizedBox(height: 12,),
              Container(padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icon/no-records.svg',
                      height: 60,
                      width: 60,
                    ),
                    SizedBox(height: 20,),
                    Text('No records to show', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500
                    ),),
                    SizedBox(height: 10,),
                    Text('There is no fixed price or other payments data for the selected week',
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

  Widget _buildWeekSelector(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
        onTap: () {
          weekSelectorController.previousWeek();
        },
          child: Icon(Icons.chevron_left, color: Colors.grey[600]),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => _showWeekSelector(context),
            child: Obx(() {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 20),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          weekSelectorController.getSelectedWeekString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
                    ],
                  ),
                );
              }
            ),
          ),
        ),
        GestureDetector(
         onTap: () {
           weekSelectorController.nextWeek();
         },
          child: Icon(Icons.chevron_right, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildTotalsSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
      //  color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Totals',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(Icons.keyboard_arrow_up, color: Colors.grey[600]),
            ],
          ),
          SizedBox(height: 20),

          _buildTotalRow('Hourly (0:00 hrs)', '\$0.00', hasIndent: false),
          SizedBox(height: 12),
          _buildTotalRow('Manual time (0:00 hrs)', '\$0.00', hasIndent: true),
         // SizedBox(height: 12),
          Divider(height: 20,),
          _buildTotalRow('Fixed price and other', '\$0.00', hasIndent: false),
          Divider(height: 20,),
         // SizedBox(height: 20),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '\$0.00',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String title, String amount, {required bool hasIndent}) {
    return Row(
      children: [
       // if (hasIndent) SizedBox(width: 10),
        if (hasIndent) Icon(Icons.subdirectory_arrow_right,
            color: Colors.grey[400], size: 16),
        if (hasIndent) SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildExpandableSection(String title, RxBool isExpanded, VoidCallback onTap) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        //color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Obx(() => Icon(
              isExpanded.value
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: Colors.grey[600],
            )),
          ],
        ),
      ),
    );
  }

  void _showWeekSelector(BuildContext context){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => WeekSelectorBottomSheet(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/workroom_timesheet_controller.dart';
import '../../models/timesheet_transaction_model.dart';

class TimesheetPage extends StatelessWidget{
  final bool? showAppbar;
  final TimesheetController controller = Get.put(TimesheetController());

  TimesheetPage({Key? key,  this.showAppbar = false,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: showAppbar == true ? AppBar(
       title: Text('Timesheet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
       actions: [
         IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
       ],
     ): null,
     body: SingleChildScrollView(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           _buildStats(),
           _buildWorkDiary(),
           // _buildDateSelector(),
           _buildWeeklyTimesheet(),
           _buildTimeSummary(),
           _buildRecentTransactions(),
           SizedBox(height: 20),
           _buildTransactionsSummary(),
           SizedBox(height: 20),
           _buildTransactionsTable(),
         ],
       ),
     ),
   );
  }
  Widget _buildStats() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Last 24 hours',
                  '${controller.last24Hours} hrs',
                  'Last worked\n${controller.lastWorked}',
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: _buildStatCard(
                  'This week',
                  '${controller.thisWeek} hrs',
                  'of 40 hrs weekly limit',
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Last week',
                  '0:00 hrs',
                  '',
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: _buildStatCard(
                  'Since start',
                  '${controller.sinceStart} hrs',
                  '',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String hours, String subtitle) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 5),
          Text(
            hours,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (subtitle.isNotEmpty) ...[
            SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWorkDiary() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Work diary',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total amount',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                Obx(() => Text(
                  '\$${controller.totalAmount.value}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                )),
                SizedBox(height: 5),
                Obx(() => Text(
                  '${controller.thisWeek.value} hrs @ \$${controller.hourlyRate.value} per hr',
                  style: TextStyle(color: Colors.grey[600]),
                )),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 20),
                    SizedBox(width: 10),
                    Obx(() => Text(controller.dateRange.value)),
                  ],
                ),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today, size: 20),
              SizedBox(width: 8),
              Text(
                'Feb 24 - Mar 2, 2025',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  Widget _buildWeeklyTimesheet() {
    return Obx(() => Column(
      children: controller.weeklyTimesheet.map((day) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${day.day} ${day.date}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    '${day.hours.toStringAsFixed(2)} hrs',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: day.hours > 0 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 8,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: day.isTracked ? Colors.green : Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Divider(height: 16),
          ],
        );
      }).toList(),
    ));
  }

  Widget _buildTimeSummary() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTimeType('Tracked', controller.trackedHours.value, Colors.green),
          _buildTimeType('Manual', controller.manualHours.value, Colors.lightGreen),
          _buildTimeType('Overtime', controller.overtimeHours.value, Colors.red),
        ],
      ),
    );
  }

  Widget _buildTimeType(String label, double hours, Color color) {
    return Column(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 4),
        Text(
          '${hours.toStringAsFixed(2)} hrs',
          style: TextStyle(
            fontSize: 16,
            fontWeight: hours > 0 ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentTransactions() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent transactions',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          // Add your transactions list here
        ],
      ),
    );
  }
  Widget _buildTransactionsSummary() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildSummaryItem(
                    'Last 7 days', controller.last7DaysAmount.value),
              ),
              Expanded(
                child: _buildSummaryItem(
                    'Last 30 days', controller.last30DaysAmount.value),
              ),
            ],
          ),
          //SizedBox(height: 16),
          Divider(height: 32,color: Colors.grey[300],),
          Row(
            children: [
              _buildSummaryItem(
                  'Since start', controller.sinceStartAmount.value),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, double amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 16,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsTable() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  'Amount',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
        Obx(() =>
            Column(
              children: controller.transactions.map((transaction) =>
                  _buildTransactionRow(transaction)).toList(),
            )),
      ],
    );
  }

  Widget _buildTransactionRow(TimesheetTransaction transaction) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            // flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.date,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                // SizedBox(height: 4),
                //  Text(
                //    transaction.description,
                //    style: TextStyle(
                //      fontSize: 16,
                //    ),
                //  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                transaction.description,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${transaction.isPositive ? '+' : '-'}\$${transaction.amount
                  .toStringAsFixed(2)}',
              style: TextStyle(
                color: transaction.isPositive ? Colors.green : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
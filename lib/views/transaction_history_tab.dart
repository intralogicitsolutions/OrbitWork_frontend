import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orbitwork/comms/transaction_type.dart';
import '../component/select_client_bottomsheet.dart';
import '../component/select_date_bottom_sheet.dart';
import '../component/select_transaction_category_bottomsheet.dart';
import '../controllers/clients_controller.dart';
import '../controllers/dateselector_controller.dart';
import '../controllers/transaction_category_controller.dart';
import '../controllers/transaction_controller.dart';
import '../models/transaction_model.dart';
import '../widgets/custom_shimmer.dart';

class TransactionHistoryTab extends StatelessWidget {
  final bool? showAppbar;
  final clientController = Get.put(SelectClientsController());
  final transactioncontroller = Get.put(TransactionCategoryController());
  final controller = Get.put(TransactionController());
  final dateSelectController = Get.put(DateSelectorController());

  TransactionHistoryTab({Key? key, this.showAppbar = false, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: showAppbar == true ? AppBar(
        title: Text('Transaction history', style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500
        ),),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
        ],
      ): null,
      body: Obx(() {
          return controller.availableBalance != 0.00 ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Balance: ',
                          style: theme.textTheme.bodyLarge,
                          //style: TextStyle(fontSize: 18),
                        ),
                        TextSpan(
                          text: '\$0.00',
                          style: TextStyle(fontSize: 18, color: Colors.green),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Text(
                        'Statement period',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Obx(() {
                        return TextField(
                          readOnly: true,
                          controller: TextEditingController(
                            text: dateSelectController.selectedDateRange,
                          ),
                          decoration: InputDecoration(
                            //labelText: 'Statement period',
                            //filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 1), // Set color and width when not focused
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () {
                                Get.bottomSheet(
                                  SelectDateBottomSheet(),
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16)),
                                  ),
                                );
                              },
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                            // contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                            child: Text(
                              'Transcation category',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: TextField(
                              readOnly: true,
                              controller: TextEditingController(
                                text: 'All Transactions',
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                                // labelText: 'All transaction',
                                labelStyle: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                                // filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  // Set color and width when not focused
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                suffixIcon: IconButton(
                                  icon:
                                      const Icon(Icons.keyboard_arrow_down_outlined),
                                  onPressed: () {
                                    final controller = Get.find<TransactionCategoryController>();
                                    controller.updateSearchQuery('');
                                    // Get.bottomSheet(SelectTransactionCategoryBottomSheet());
                                    Get.bottomSheet(
                                      Container(
                                          height: MediaQuery.of(context).size.height *
                                              0.9,
                                          child:
                                              SelectTransactionCategoryBottomSheet()),
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16)),
                                      ),
                                    );
                                  },
                                ),
                                // contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                              ),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                            child: Text(
                              'Client',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: TextField(
                              readOnly: true,
                              controller: TextEditingController(
                                text: 'All Clients',
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                                // labelText: 'All clients',
                                labelStyle: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                                // filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                  // Set color and width when not focused
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                suffixIcon: IconButton(
                                  icon:
                                      const Icon(Icons.keyboard_arrow_down_outlined),
                                  onPressed: () {
                                    final controller = Get.find<SelectClientsController>();
                                    controller.updateSearchQuery('');
                                    Get.bottomSheet(
                                      Container(
                                          height: MediaQuery.of(context).size.height *
                                              0.9,
                                          child: SelectClientsBottomSheet()),
                                     isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16)),
                                      ),
                                    );
                                  },
                                ),
                                // contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                              ),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    // Show shimmer placeholders while loading
                    return ListView.builder(
                      itemCount: 5, // Number of shimmer items to display
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomShimmer(width: MediaQuery.of(context).size.width*0.5, height: 20),
                                  const SizedBox(height: 10),
                                  CustomShimmer(width: MediaQuery.of(context).size.width*0.3, height: 20),
                                ],
                              ),
                              const Spacer(),
                              CustomShimmer(width: 50, height: 20), // Simulating Amount
                            ],
                          ),
                        );
                      },
                    );
                  }
                  final groupedTransactions =
                      groupTransactionsByDate(controller.transactions);

                  return ListView.builder(
                    itemCount: groupedTransactions.keys.length,
                    itemBuilder: (context, index) {
                      final date = groupedTransactions.keys.toList()[index];
                      final transactions = groupedTransactions[date]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              DateFormat('MMM dd, yyyy').format(date),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          ...transactions.map((transaction) => ListTile(
                                title: Text(
                                  'Ref ID: ${transaction.refId}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green),
                                ),
                                subtitle: Text(
                                  transaction.type.displayName,
                                  style: TextStyle(color: theme.dividerColor, fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                trailing: transaction.type.displayName == 'GST'
                                    ? Text(
                                        '\$${transaction.amount.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      )
                                    : Text(
                                        '- \$${transaction.amount.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                              )),
                        ],
                      );
                    },
                  );
                }),
              ),
            ],
          ) : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // New design toggle
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text('New design',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.info_outline, size: 16),
                    SizedBox(width: 8),
                    Text('On',
                      style: TextStyle(fontSize: 16),
                   ),
                    Obx(() => Transform.scale(
                      scale: 0.7,
                      child: Switch(
                        value: controller.newDesign.value,
                        onChanged: (val) => controller.toggleDesign(),
                        activeColor: Colors.white,
                        activeTrackColor: Colors.black,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey.shade300,
                      ),
                    )),
                  ],
                ),
              ),

              // Balance section
              Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          Text('Available balance: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Obx(() => Text('\$${controller.availableBalance.value.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          )),
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      child: Row(
                        children: [
                          Obx(() => Text('\$${controller.pendingBalance.value.toStringAsFixed(2)} pending',
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                          )),
                          SizedBox(width: 5),
                          Icon(Icons.info_outline, size: 14, color: Colors.grey.shade700),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Divider(height: 1),

              // Filters button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () => controller.showFilters(),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.filter_list, color: Colors.green),
                        SizedBox(width: 8),
                        Text('Filters',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Filtered totals section
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Filtered totals',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Select a filter to get a breakdown of your earnings, fees, and taxes.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),

              // Empty state
              Expanded(
                child:
               // Obx(() => controller.transactions.isEmpty ?
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icon/open-folder.png', // Replace with actual folder image
                        height: 80,
                        width: 80,
                        color: Colors.green,
                      ),
                      SizedBox(height: 16),
                      Text('No transactions yet.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
                //     : ListView.builder(
                //   itemCount: controller.transactions.length,
                //   itemBuilder: (context, index) {
                //     // Build your transaction items here
                //     return ListTile();
                //   },
                // )
                //),
              ),
            ],
          );
        }
      ),
    );
  }

  Map<DateTime, List<Transaction>> groupTransactionsByDate(
      List<Transaction> transactions) {
    final Map<DateTime, List<Transaction>> grouped = {};
    for (var transaction in transactions) {
      final date = DateTime(
          transaction.date.year, transaction.date.month, transaction.date.day);
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(transaction);
    }
    return grouped;
  }
}


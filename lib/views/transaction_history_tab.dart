import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/widgets/custom_textfeild.dart';

import '../component/select_client_bottomsheet.dart';
import '../component/select_date_bottom_sheet.dart';
import '../component/select_transaction_category_bottomsheet.dart';
import '../controllers/clients_controller.dart';
import '../controllers/transaction_category_controller.dart';

class TransactionHistoryTab extends StatelessWidget {
  final clientController = Get.put(SelectClientsController());
  final controller = Get.put(TransactionCategoryController());
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Balance: ',
                    style: TextStyle(fontSize: 18, color: Colors.black), // Black color for "Balance"
                  ),
                  TextSpan(
                    text: '\$0.00',
                    style: TextStyle(fontSize: 18, color: Colors.green), // Green color for "$0.00"
                  ),
                ],
              ),
            )

        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text('Statement period',style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
              ),
              Container(
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Statement period',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400, width: 1), // Set color and width when not focused
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
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                        );
                      },
                    ),
                    // contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  ),
                  ),
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
                      child: Text('Transcation category',style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      height: 40,
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: controller.selectedCategoryLabel.value,
                        ),
                        decoration: InputDecoration(
                         // labelText: 'All transaction',
                          labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1), // Set color and width when not focused
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.keyboard_arrow_down_outlined),
                            onPressed: () {
                              Get.bottomSheet(SelectTransactionCategoryBottomSheet());
                            },
                          ),
                          // contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        ),
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                // child: TextField(
                //   decoration: InputDecoration(
                //     labelText: 'Statement period',
                //     suffixIcon: IconButton(
                //       icon: const Icon(Icons.calendar_today),
                //       onPressed: () {
                //         Get.bottomSheet(
                //             SelectDateBottomSheet(),
                //           isScrollControlled: true, // Allow full height control
                //           backgroundColor: Colors.transparent, // Ensure background doesn't limit the sheet
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                //           ),
                //         );
                //       },
                //     ),
                //     // IconButton(
                //     //   icon: const Icon(Icons.calendar_today),
                //     //   onPressed: () {
                //     //     Get.bottomSheet(
                //     //         backgroundColor:  theme.scaffoldBackgroundColor,
                //     //         // shape: RoundedRectangleBorder(
                //     //         //   borderRadius: BorderRadius.circular(20),
                //     //         // ),
                //     //         isScrollControlled: true,
                //     //         Container(
                //     //           height: MediaQuery.of(context).size.height * 0.7,
                //     //           child: SelectDateBottomSheet(),
                //     //         ),
                //     //         );
                //     //   },
                //     // ),
                //   ),
                // ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Text('Client',style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),),
                    ),
                    Container(
                      height: 40,
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: 'All Clients',
                        ),
                        decoration: InputDecoration(
                         // labelText: 'All clients',
                          labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1), // Set color and width when not focused
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.keyboard_arrow_down_outlined),
                            onPressed: () {
                              Get.bottomSheet(
                                SelectClientsBottomSheet(),
                                //isScrollControlled: true, // Allow full height control
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
                // DropdownButtonFormField(
                //   items: ['All transactions', 'abc', 'def']
                //       .map((item) => DropdownMenuItem(
                //     child: Text(item),
                //     value: item,
                //   ))
                //       .toList(),
                //   onChanged: (value) {},
                //   decoration: InputDecoration(labelText: 'Transaction category'),
                // ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    title: Text('Ref ID: #XXXXX'),
                    subtitle: Text('Service Fee'),
                    trailing: Text('\$0.00'),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

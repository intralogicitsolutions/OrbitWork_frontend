import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/filter_transaction_controller.dart';

void showSelectionBottomSheet(String type, Function(String) onSelect) {
  List<String> items = [];

  switch (type) {
    case 'transactionType':
      items = ["All types", "Purchase", "Sale", "Transfer"];
      break;
    case 'client':
      items = ["All clients", "Client A", "Client B", "Client C"];
      break;
    case 'contract':
      items = ["All contracts", "Contract 1", "Contract 2", "Contract 3"];
      break;
  }

  Get.bottomSheet(
    Scaffold(
      body: Container(
        height: Get.height,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Select $type", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(onPressed: () {
                    Get.back();
                  }, icon: Icon(Icons.close))
                ],
              ),
            ),
            SizedBox(height: 10),
            ...items.map((item) => ListTile(
              title: Text(item),
              onTap: () {
                onSelect(item);
                Get.back(); // Close the bottom sheet
              },
            )),
          ],
        ),
      ),
    ),
    isScrollControlled: true,
    isDismissible: true,
    ignoreSafeArea: false
  );

}




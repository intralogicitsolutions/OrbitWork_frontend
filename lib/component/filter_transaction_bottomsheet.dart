import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbitwork/component/show_filter_selection_bottomsheet.dart';

import '../controllers/filter_transaction_controller.dart';

class FilterTranscationBottomsheet extends StatelessWidget{
  final FilterController controller = Get.put(FilterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filters',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Date Range
              Text('Date range', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              _buildDateRangePicker(controller),
              SizedBox(height: 20),

              // Transaction Type
              Text('Transaction type', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              _buildDropdown('transactionType', controller),
              SizedBox(height: 20),

              // Client
              Text('Client', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              _buildDropdown('client', controller),
              SizedBox(height: 20),

              // Contract
              Text('Contract', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              _buildDropdown('contract', controller),
              SizedBox(height: 30),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        controller.clearFilters();
                      },
                      child: Text('Clear filters',
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {

                      Get.back();
                    },
                    child: Text('Apply filters',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateRangePicker(FilterController controller) {
    return Obx(() => InkWell(
      onTap: () {
        // Show date picker here
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(controller.dateRange.value),
            Icon(Icons.calendar_today),
          ],
        ),
      ),
    ));
  }

  Widget _buildDropdown(String type, FilterController controller) {
    return Obx(() {
      String value;
      Function(String?) onChanged;

      switch(type) {
        case 'transactionType':
          value = controller.transactionType.value;
          onChanged = (val) => controller.transactionType.value = val ?? "All types";
          break;
        case 'client':
          value = controller.client.value;
          onChanged = (val) => controller.client.value = val ?? "All clients";
          break;
        case 'contract':
          value = controller.contract.value;
          onChanged = (val) => controller.contract.value = val ?? "All contracts";
          break;
        default:
          value = "";
          onChanged = (val) {};
      }

      // return Container(
      //   padding: EdgeInsets.symmetric(horizontal: 16),
      //   decoration: BoxDecoration(
      //     border: Border.all(color: Colors.grey.shade300),
      //     borderRadius: BorderRadius.circular(8),
      //   ),
      //   child: DropdownButtonHideUnderline(
      //     child: DropdownButton<String>(
      //       value: value,
      //       isExpanded: true,
      //       icon: Icon(Icons.keyboard_arrow_down),
      //       items: _getDropdownItems(type),
      //       onChanged: onChanged,
      //     ),
      //   ),
      // );
      return InkWell(
        onTap: () {
          showSelectionBottomSheet(type, onChanged);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      );
    });
  }

  List<DropdownMenuItem<String>> _getDropdownItems(String type) {
    List<String> items = [];

    switch(type) {
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

    return items.map((item) => DropdownMenuItem(
      value: item,
      child: Text(item),
    )).toList();
  }

}


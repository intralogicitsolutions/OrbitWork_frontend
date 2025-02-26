import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';

import '../comms/transaction_type.dart';
import '../component/filter_transaction_bottomsheet.dart';
import '../models/transaction_model.dart';

class TransactionController extends GetxController {
  var transactions = <Transaction>[].obs;
  RxBool isLoading = true.obs;
  final RxBool newDesign = true.obs;
  final RxDouble availableBalance = 0.00.obs;
  final RxDouble pendingBalance = 0.00.obs;
  // final RxList transactions = [].obs;


  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  void fetchTransactions() async{
    await Future.delayed(Duration(seconds: 2));
    transactions.value = [
      Transaction(
        date: DateTime(2025, 1, 29),
        refId: '12345',
        type: TransactionType.gst,
        amount: 0.00,
      ),
      Transaction(
        date: DateTime(2025, 1, 29),
        refId: '67890',
        type: TransactionType.serviceFee,
        amount: 0.00,
      ),
      Transaction(
        date: DateTime(2025, 1, 29),
        refId: '54321',
        type: TransactionType.wht,
        amount: 0.00,
      ),
      Transaction(
        date: DateTime(2025, 1, 29),
        refId: '98765',
        type: TransactionType.hourly,
        amount: 0.00,
      ),
      Transaction(
        date: DateTime(2025, 1, 17),
        refId: '13579',
        type: TransactionType.gst,
        amount: 0.00,
      ),
    ];
    isLoading.value = false;
  }

  void toggleDesign() {
    newDesign.value = !newDesign.value;
  }

  void showFilters() {
    Get.bottomSheet(
        Container(
          height: Get.height * 0.7,
            child: FilterTranscationBottomsheet()),
      isScrollControlled: true,
    );
  }

}

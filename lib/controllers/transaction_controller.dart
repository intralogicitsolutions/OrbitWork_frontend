import 'package:get/get.dart';

import '../comms/transaction_type.dart';
import '../models/transaction_model.dart';

class TransactionController extends GetxController {
  var transactions = <Transaction>[].obs;
  RxBool isLoading = true.obs;

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
}

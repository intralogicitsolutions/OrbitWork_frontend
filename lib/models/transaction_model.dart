import '../comms/transaction_type.dart';

class Transaction {
  final DateTime date;
  final String refId;
  final TransactionType type;
  final double amount;

  Transaction({
    required this.date,
    required this.refId,
    required this.type,
    required this.amount,
  });
}

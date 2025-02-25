class TimesheetTransaction {
  final String date;
  final String description;
  final double amount;
  final bool isPositive;

  TimesheetTransaction({
    required this.date,
    required this.description,
    required this.amount,
    required this.isPositive,
  });
}

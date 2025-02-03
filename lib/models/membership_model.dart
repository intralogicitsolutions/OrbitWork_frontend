class Membership {
  final String planName;
  final DateTime cycleStartDate;
  final DateTime cycleEndDate;
  final int connectsBalance;

  Membership({
    required this.planName,
    required this.cycleStartDate,
    required this.cycleEndDate,
    required this.connectsBalance,
  });
}
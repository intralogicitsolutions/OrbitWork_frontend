class Contract{
  final String title;
  final String hireBy;
  final bool isActive;
  final double hourThisWeek;
  final double rate;
  final int weeklyLimit;
  final DateTime startDate;
  final double earnings;

  Contract({
    required this.title,
    required this.hireBy,
    required this.isActive,
    required this.hourThisWeek,
    required this.rate,
    required this.weeklyLimit,
    required this.startDate,
    required this.earnings
  }
      );
}
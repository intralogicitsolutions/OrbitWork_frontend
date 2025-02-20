class WithdrawalMethod {
  final String title;
  final String icon;
  final List<String> details;
  final bool isBank;

  WithdrawalMethod({
    required this.title,
    required this.icon,
    required this.details,
    this.isBank = true,
});
}
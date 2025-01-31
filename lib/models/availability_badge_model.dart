class BadgeModel {
  int currentPrice;
  int maximumConnects;
  int availableConnects;
  bool isEditing;

  BadgeModel({
    required this.currentPrice,
    required this.maximumConnects,
    required this.availableConnects,
    this.isEditing = false,
  });
}
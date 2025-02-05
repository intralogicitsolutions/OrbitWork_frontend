class WorkPreference {
  final String title;
  final String description;
  final String? iconPath;
  final bool isCardStyle;
  bool isSelected;

  WorkPreference({
    required this.title,
    required this.description,
    required this.iconPath,
    this.isCardStyle = true,
    this.isSelected = false,
  });
}
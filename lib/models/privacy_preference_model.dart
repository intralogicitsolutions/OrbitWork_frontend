class PrivacyPreferenceModel {
  String title;
  String description;
  bool? isEnabled;
  bool isExpanded;

  PrivacyPreferenceModel(
      {required this.title, required this.description, this.isEnabled , this.isExpanded = false,});
}

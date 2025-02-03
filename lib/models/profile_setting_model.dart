class ProfileModel {
  String visibility;
  String customUrl;
  String projectPreference;
  bool hideEarnings;
  String experienceLevel;
  List<String> categories;
  String mainCategory;
  int publishedProfiles;
  int maxProfiles;
  bool isAIDataEnabled;

  ProfileModel({
    this.visibility = 'Public',
    this.customUrl = '/freelancers/abcd',
    this.projectPreference = 'Both short-term and long-term projects',
    this.hideEarnings = false,
    this.experienceLevel = 'Entry level',
    this.categories = const [],
    this.mainCategory = 'Web, Mobile & Software Dev',
    this.publishedProfiles = 0,
    this.maxProfiles = 2,
    this.isAIDataEnabled = true,
  });
}
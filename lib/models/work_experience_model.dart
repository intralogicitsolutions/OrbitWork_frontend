class WorkExperience {
  String title;
  String company;
  String location;
  String country;
  bool isCurrentRole;
  String startMonth;
  String startYear;
  String endMonth;
  String endYear;
  String description;

  WorkExperience({
    required this.title,
    required this.company,
    required this.location,
    required this.country,
    this.isCurrentRole = false,
    required this.startMonth,
    required this.startYear,
    required this.endMonth,
    required this.endYear,
    required this.description,
  });

}
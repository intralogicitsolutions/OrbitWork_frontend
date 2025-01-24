class JobDetailsModel {
  final String title;
  final String description;
  final String expertise;
  final String location;
  final int connects;
  final int availableConnects;
  final double price;
  final String experienceLevel;
  final String projectType;
  final int hirers;
  final int activeHirers;
  final double avgHourlyRate;
  final String industry;

  JobDetailsModel({
    required this.title,
    required this.description,
    required this.expertise,
    required this.location,
    required this.connects,
    required this.availableConnects,
    required this.price,
    required this.experienceLevel,
    required this.projectType,
    required this.hirers,
    required this.activeHirers,
    required this.avgHourlyRate,
    required this.industry,
  });
}
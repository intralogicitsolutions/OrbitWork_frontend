class JobDetailsModel {
 // final String expertise;
  //final String location;
  final int connects;
  final int availableConnects;
  final String projectType;
  final int hirers;
  final int activeHirers;
  final double avgHourlyRate;
  final String industry;
  final String country;
  final String city;
  final String time;
  final double hireRate;
  final int openJobs;
  final int jobsPosted;
  final double totalSpent;
  final String hours;
  final String sinceDate;
  final String attachmentFileName;
  final double attachmentFileSize;

  JobDetailsModel({
    //required this.expertise,
    //required this.location,
    required this.connects,
    required this.availableConnects,
    required this.projectType,
    required this.hirers,
    required this.activeHirers,
    required this.avgHourlyRate,
    required this.industry,
    required this.country,
    required this.city,
    required this.time,
    required this.hireRate,
    required this.openJobs,
    required this.jobsPosted,
    required this.totalSpent,
    required this.hours,
    required this.sinceDate,
    required this.attachmentFileName,
    required this.attachmentFileSize
  });
}
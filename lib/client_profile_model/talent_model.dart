class TalentModel {
  final String id;
  final String name;
  final String location;
  final String specialization;
  final String profileImage;
  final double hourlyRate;
  final int jobSuccessRate;
  final bool isTopRated;
  final bool isOnline;

  TalentModel({
    required this.id,
    required this.name,
    required this.location,
    required this.specialization,
    required this.profileImage,
    required this.hourlyRate,
    required this.jobSuccessRate,
    required this.isTopRated,
    required this.isOnline,
  });
}


class ProjectModel {
  final String id;
  final String title;
  final String description;
 // final String projectImage;
  final double startingPrice;
  final String freelancerName;
  //final String freelancerImage;
  final double rating;
  final int reviewCount;
  final bool isTopRated;
  final bool isFavorite;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
   // required this.projectImage,
    required this.startingPrice,
    required this.freelancerName,
   // required this.freelancerImage,
    required this.rating,
    required this.reviewCount,
    required this.isTopRated,
    this.isFavorite = false,
  });
}


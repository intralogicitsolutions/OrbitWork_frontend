class Freelancer {
  final String name;
  final String title;
  final String country;
  final double rate;
  final int earnings;
  final int jobSuccess;
  final bool isAvailable;
  final String profileImage;
  final List<String> skills;
  final bool isBoosted;
  final String agencyName;
  final int agencyEarnings;

  Freelancer({
    required this.name,
    required this.title,
    required this.country,
    required this.rate,
    required this.earnings,
    required this.jobSuccess,
    required this.isAvailable,
    required this.profileImage,
    required this.skills,
    required this.isBoosted,
    required this.agencyName,
    required this.agencyEarnings,
  });
}
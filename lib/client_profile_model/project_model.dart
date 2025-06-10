class Project {
  final String id;
  final String title;
  final String description;
  final String price;
  final String providerName;
  final double rating;
  final int reviewCount;
  final String profileImage;
  final List<String> projectImages;
  final bool isTopRatedPlus;
  final bool isFavorite;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.providerName,
    required this.rating,
    required this.reviewCount,
    required this.profileImage,
    required this.projectImages,
    this.isTopRatedPlus = false,
    this.isFavorite = false,
  });
}
class Job {
  final String title;
  final String description;
  final String postedTimeAgo;
  final String location;
  final double budget;
  final String paymentVerified;
  final double rating;
  final List<String> tags;

  Job({
    required this.title,
    required this.description,
    required this.postedTimeAgo,
    required this.location,
    required this.budget,
    required this.paymentVerified,
    required this.rating,
    required this.tags,
  });
}
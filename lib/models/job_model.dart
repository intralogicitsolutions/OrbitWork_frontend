class Job {
  final String title;
  final String description;
  final String postedTimeAgo;
  final String location;
  final double budget;
  final String paymentVerified;
  final double rating;
  final List<String> tags;
  final String hourlyRateMin;
  final String hourlyRateMax;
  final String jobType;
  final String estimatedTime;
  final String hoursPerWeek;
  final bool isFixedPrice;

  Job({
    required this.title,
    required this.description,
    required this.postedTimeAgo,
    required this.location,
    required this.budget,
    required this.paymentVerified,
    required this.rating,
    required this.tags,
    required this.hourlyRateMin,
    required this.hourlyRateMax,
    required this.jobType,
    required this.estimatedTime,
    required this.hoursPerWeek,
    required this.isFixedPrice,
  });
  @override
  String toString() {
    return 'Job(title: $title, description: $description, budget: \$${budget.toStringAsFixed(2)})';
  }
}
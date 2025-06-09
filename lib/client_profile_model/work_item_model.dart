class WorkItem {
  final String title;
  final double rating;
  final String price;
  final String dateRange;
  final List<String> tags;
  final String description;

  WorkItem({
    required this.title,
    required this.rating,
    required this.price,
    required this.dateRange,
    required this.tags,
    required this.description,
  });
}

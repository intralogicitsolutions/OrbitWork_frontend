class Proposal {
  final String title;
  final String status;
  final DateTime date;
  final bool? viewedByClient;
  final bool? isJobClosed;
  final String profileType;

  Proposal({
    required this.title,
    required this.status,
    required this.date,
     this.viewedByClient,
     this.isJobClosed,
    required this.profileType,
  });
}
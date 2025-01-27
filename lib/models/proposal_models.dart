class ProposalModel {
  final int requiredConnects;
  final int remainingConnects;
  final String jobTitle;
  final String category;
  final String postedDate;
  final String description;
  final double budget;
    double bid;
    double serviceFee;
    double finalAmount;
   String duration;
   String coverLetter;


  ProposalModel({
    required this.requiredConnects,
    required this.remainingConnects,
    required this.jobTitle,
    required this.category,
    required this.postedDate,
    required this.description,
    required this.budget,
    required this.bid,
    required this.serviceFee,
    required this.finalAmount,
    required this.duration,
    required this.coverLetter,
  });
}

class HighlightItemModel {
  final String id;
  final String title;
  final String icon;
  final bool isEnabled;

  HighlightItemModel({
    required this.id,
    required this.title,
    required this.icon,
    this.isEnabled = true,
  });
}
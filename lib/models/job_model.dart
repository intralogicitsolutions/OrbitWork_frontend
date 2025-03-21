// class Job {
//   final String title;
//   final String description;
//   final String postedTimeAgo;
//   final String location;
//   final double budget;
//   final String paymentVerified;
//   final double rating;
//   final List<String> tags;
//   final String hourlyRateMin;
//   final String hourlyRateMax;
//   final String jobType;
//   final String estimatedTime;
//   final String hoursPerWeek;
//   final bool isFixedPrice;
//
//   Job({
//     required this.title,
//     required this.description,
//     required this.postedTimeAgo,
//     required this.location,
//     required this.budget,
//     required this.paymentVerified,
//     required this.rating,
//     required this.tags,
//     required this.hourlyRateMin,
//     required this.hourlyRateMax,
//     required this.jobType,
//     required this.estimatedTime,
//     required this.hoursPerWeek,
//     required this.isFixedPrice,
//   });
//   @override
//   String toString() {
//     return 'Job(title: $title, description: $description, budget: \$${budget.toStringAsFixed(2)})';
//   }
// }

import 'dart:convert';

class Job {
  final String id; // Job ID (if needed)
  final String userId;
  final String title;
  final String? jobDescription;
  final String location;
  final double budget;
  final bool isPaymentVerified;
  final double? rating;
  final List<String> tags;
  final double? spending;
  final double? hourlyRateMin;
  final double? hourlyRateMax;
  final String? projectType;
  final String? estimatedTime;
  final int? hoursPerWeek;
  final bool isFixedPrice;
  final String proposals;
  final String? documentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime deletedAt;
  final bool isDeleted;

  Job({
    required this.id,
    required this.userId,
    required this.title,
    required this.jobDescription,
    required this.location,
    required this.budget,
    required this.isPaymentVerified,
    this.rating,
    required this.tags,
    this.spending,
    this.hourlyRateMin,
    this.hourlyRateMax,
    this.projectType,
    this.estimatedTime,
    this.hoursPerWeek,
    required this.isFixedPrice,
    required this.proposals,
    this.documentId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.isDeleted,
  });

  /// Factory constructor to create a `Job` object from JSON
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['_id'] ?? '',
      userId: json['user_id'] ?? '',
      title: json['title'] ?? '',
      jobDescription: json['jobDescription'] ?? '',
      location: json['location'] ?? '',
      budget: (json['budget'] ?? 0).toDouble(),
      isPaymentVerified: json['isPaymentVerified'] ?? false,
      rating: (json['rating'] ?? 0).toDouble(),
      //tags: (json['tags'] as List<dynamic>?)?.map((tag) => tag.toString()).toList() ?? [],
      tags: _parseTags(json['tags']),
      spending: (json['spending'] ?? 0).toDouble(),
      hourlyRateMin: (json['hourlyRateMin'] ?? 0).toDouble(),
      hourlyRateMax: (json['hourlyRateMax'] ?? 0).toDouble(),
      projectType: json['projectType'] ?? '',
      estimatedTime: json['estimatedTime'] ?? '',
      hoursPerWeek: json['hoursPerWeek'] is int
          ? json['hoursPerWeek'] as int
          : int.tryParse(json['hoursPerWeek'].toString()),
      isFixedPrice: json['isFixedPrice'] ?? false,
      proposals: json['proposals'] ?? '',
      documentId: json['document_id'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      deletedAt: DateTime.parse(json['deleted_at'] ?? DateTime.now().toIso8601String()),
      isDeleted: json['is_deleted'] ?? false,
    );
  }

  /// Convert `Job` object to JSON (for sending data to API)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'title': title,
      'jobDescription': jobDescription,
      'location': location,
      'budget': budget,
      'isPaymentVerified': isPaymentVerified,
      'rating': rating,
      'tags': tags,
      'spending': spending,
      'hourlyRateMin': hourlyRateMin,
      'hourlyRateMax': hourlyRateMax,
      'projectType': projectType,
      'estimatedTime': estimatedTime,
      'hoursPerWeek': hoursPerWeek,
      'isFixedPrice': isFixedPrice,
      'proposals': proposals,
      'document_id': documentId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt.toIso8601String(),
      'is_deleted': isDeleted,
    };
  }

  @override
  String toString() {
    return 'Job(title: $title, budget: \$${budget.toStringAsFixed(2)}, isFixedPrice: $isFixedPrice)';
  }

  static List<String> _parseTags(dynamic tags) {
    if (tags == null) return [];

    if (tags is List) {
      try {
        // If tags contain a stringified JSON array, decode it
        if (tags.isNotEmpty && tags[0] is String && tags[0].startsWith('[')) {
          return List<String>.from(jsonDecode(tags[0]));
        }
        // Otherwise, return the list as is
        return tags.map((tag) => tag.toString()).toList();
      } catch (e) {
        print("Error parsing tags: $e");
        return [];
      }
    }
    return [];
  }
}

class JobProposal {
  String? userId;
  String? jobId;
  double? amount;
  double? serviceFee;  // New field
  double? finalAmount; // New field
  String? duration;
  String? coverLetter;
  List<String>? attachmentIds;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  bool? isDeleted;

  JobProposal({
     this.userId,
     this.jobId,
     this.amount,
    this.serviceFee = 0.0,   // Initialize with default value
    this.finalAmount = 0.0,  // Initialize with default value
    this.duration,
     this.coverLetter,
     this.attachmentIds,
     this.createdAt,
     this.updatedAt,
     this.deletedAt,
     this.isDeleted,
  });

  /// Convert JSON to JobProposal object
  factory JobProposal.fromJson(Map<String, dynamic> json) {
    double amount = (json['amount'] as num?)?.toDouble() ?? 0.0; // Handle null safely
    double serviceFee = amount * 0.10;  // Calculate service fee
    double finalAmount = amount - serviceFee;  // Calculate final amount

    return JobProposal(
      userId: json['user_id']?.toString() ?? '',
      jobId: json['job_id']?.toString() ?? '',
      amount: amount,
      serviceFee: serviceFee,
      finalAmount: finalAmount,
      duration: json['duration']?.toString() ?? '',
      coverLetter: json['cover_letter']?.toString() ?? '',
      attachmentIds: _parseAttachmentIds(json['attechmentDetails']),
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      deletedAt: DateTime.parse(json['deleted_at'] ?? DateTime.now().toIso8601String()),
      isDeleted: json['is_deleted'] as bool? ?? false,
    );
  }

// Helper function to parse attachment IDs
  static List<String> _parseAttachmentIds(dynamic attachments) {
    if (attachments is List) {
      return attachments.map((e) => e['_id'].toString()).toList();
    }
    return [];
  }

  /// Convert JobProposal object to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'job_id': jobId,
      'amount': amount,
      'service_fee': serviceFee,  // Include in JSON
      'final_amount': finalAmount, // Include in JSON
      'duration': duration,
      'cover_letter': coverLetter,
      'attechment_id': attachmentIds,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'is_deleted': isDeleted,
    };
  }
}

import 'package:orbitwork/models/upload_file_model.dart';

class JobProposal {
  String? id;
  String? userId;
  String? jobId;
  double? amount;
  double? serviceFee;  // New field
  double? finalAmount; // New field
  String? duration;
  String? coverLetter;
  List<String>? attachmentIds;
  List<UploadFile>? attachmentDetails;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  bool? isDeleted;

  JobProposal({
    this.id,
     this.userId,
     this.jobId,
     this.amount,
    this.serviceFee = 0.0,   // Initialize with default value
    this.finalAmount = 0.0,  // Initialize with default value
    this.duration,
     this.coverLetter,
     this.attachmentIds,
    this.attachmentDetails,
     this.createdAt,
     this.updatedAt,
     this.deletedAt,
     this.isDeleted,
  });

  /// Convert JSON to JobProposal object
  factory JobProposal.fromJson(Map<String, dynamic> json) {
    // double amount = (json['amount'] as num?)?.toDouble() ?? 0.0; // Handle null safely
    // double serviceFee = amount * 0.10;  // Calculate service fee
    // double finalAmount = amount - serviceFee;  // Calculate final amount

    return JobProposal(
      id: json['_id']?.toString(),
      userId: json['user_id']?.toString() ?? '',
      jobId: json['job_id']?.toString() ?? '',
      // amount: amount,
      // serviceFee: serviceFee,
      // finalAmount: finalAmount,
      amount: (json['amount'] as num?)?.toDouble(),
      serviceFee: (json['service_fee'] as num?)?.toDouble(),
      finalAmount: (json['final_amount'] as num?)?.toDouble(),
      duration: json['duration']?.toString() ?? '',
      coverLetter: json['cover_letter']?.toString() ?? '',
      attachmentIds: json['attechment_id'] != null
          ? List<String>.from(json['attechment_id'].map((x) => x.toString()))
          : null,
      attachmentDetails: json['attechmentDetails'] != null
          ? List<UploadFile>.from(json['attechmentDetails'].map((x) => UploadFile.fromJson(x)))
          : null,
      // attachmentIds: _parseAttachmentIds(json['attechment_id']),
      // attachmentDetails: _parseAttachments(json['attachments']),
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
  static List<UploadFile>? _parseAttachments(dynamic attachments) {
    if (attachments is List) {
      return attachments.map((e) => UploadFile.fromJson(e)).toList();
    }
    return null;
  }
  /// Convert JobProposal object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'job_id': jobId,
      'amount': amount,
      'service_fee': serviceFee,  // Include in JSON
      'final_amount': finalAmount, // Include in JSON
      'duration': duration,
      'cover_letter': coverLetter,
      'attechment_id': attachmentIds,
      'attechmentDetails': attachmentDetails?.map((e) => e.toJson()).toList(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'is_deleted': isDeleted,
    };
  }
}

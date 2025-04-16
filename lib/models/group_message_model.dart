import 'package:orbitwork/models/upload_file_model.dart';

class GroupMessageModel {
  final String? id;
  final String senderId;
  final List<String>? receiverId;
  final String roomId;
  final String message;
  final List<String>? attachmentId;
  final List<UploadFile>? attachmentDetails;
  final String? messageType;
  final double? latitude;
  final double? longitude;
  final List<String>? deletedFor;
  String messageStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final int status;

  GroupMessageModel({
    this.id,
    required this.senderId,
    this.receiverId,
    required this.message,
    required this.roomId,
    this.attachmentId,
    this.attachmentDetails,
    this.messageType,
    this.latitude,
    this.longitude,
    this.deletedFor = const [],
    required this.messageStatus,
    required this.createdAt,
    required this.updatedAt,
    this.isDeleted = false,
    this.status = 1,
  });

  factory GroupMessageModel.fromJson(Map<String, dynamic> json) {
    return GroupMessageModel(
      id: json['_id'] ?? '',
      senderId: json['sender_id'] ?? '',
      message: json['message'] ?? '',
      roomId: json['room_id'] ?? '',
      receiverId: (json['receiver_id'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      attachmentId: json["attechment_id"] is String
          ? [json["attechment_id"]]
          : (json["attechment_id"] as List<dynamic>?)?.map((id) => id.toString()).toList(),
      attachmentDetails: json["attechment_details"] is Map<String, dynamic>
          ? [UploadFile.fromJson(json["attechment_details"])]
          : (json["attechment_details"] as List<dynamic>?)?.map((item) => UploadFile.fromJson(item)).toList(),
      messageType: json["message_type"] ?? '',
      latitude: (json["latitude"] is String)
          ? double.tryParse(json["latitude"])
          : json["latitude"] as double?,
      longitude: (json["longitude"] is String)
          ? double.tryParse(json["longitude"])
          : json["longitude"] as double?,
      //deletedFor: (json['deletedFor'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      deletedFor: (json['deletedFor'] as List?)?.map((e) => e.toString()).toList() ?? [],
      messageStatus: json["message_status"] ?? 'sent',
      createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) ?? DateTime.now() : DateTime.now(),
      updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) ?? DateTime.now() : DateTime.now(),
      isDeleted: json["is_deleted"] ?? false,
      status: json["status"] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "sender_id": senderId,
      "message": message,
      "receiver_id": receiverId,
      "attechment_id": attachmentId,
      // "attechment_details": attachmentDetails?.toJson(),
      "attechment_details": attachmentDetails?.map((e) => e.toJson()).toList(),
      "room_id": roomId,
      "message_type": messageType,
      "latitude": latitude,
      "longitude": longitude,
      "deletedFor": deletedFor,
      "message_status": messageStatus,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "is_deleted": isDeleted,
      "status": status,
    };
  }

  static List<GroupMessageModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => GroupMessageModel.fromJson(json)).toList();
  }

  GroupMessageModel copyWith({
    String? id,
    String? senderId,
    List<String>? receiverId,
    String? roomId,
    String? message,
    List<String>? attachmentId,
    List<UploadFile>? attachmentDetails,
    String? messageType,
    double? latitude,
    double? longitude,
    List<String>? deletedFor,
    String? messageStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
    int? status,
  }) {
    return GroupMessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      roomId: roomId ?? this.roomId,
      message: message ?? this.message,
      attachmentId: attachmentId ?? this.attachmentId,
      attachmentDetails: attachmentDetails ?? this.attachmentDetails,
      messageType: messageType ?? this.messageType,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      deletedFor: deletedFor ?? this.deletedFor,
      messageStatus: messageStatus ?? this.messageStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      status: status ?? this.status,
    );
  }

}

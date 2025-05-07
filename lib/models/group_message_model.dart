import 'package:orbitwork/models/upload_file_model.dart';
import 'package:orbitwork/models/user_details_model.dart';

class GroupMessageModel {
  final String? id;
  final String senderId;
  final List<String>? receiverId;
  final String roomId;
  final String? message;
  final List<String>? attachmentId;
  final List<UploadFile>? attachmentDetails;
   List<UserDetails>? senderDetails;
  final String? messageType;
  final double? latitude;
  final double? longitude;
  final GroupMessageModel? replyTo;
  String messageStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? dateTime;
  final bool isDeleted;
  final int status;
  final GroupMessageModel? replyToDetails;

  GroupMessageModel({
    this.id,
    required this.senderId,
    this.receiverId,
    this.message,
    required this.roomId,
    this.attachmentId,
    this.attachmentDetails,
    this.senderDetails,
    this.messageType,
    this.latitude,
    this.longitude,
    this.replyTo,
    required this.messageStatus,
    required this.createdAt,
    required this.updatedAt,
    this.dateTime,
    this.isDeleted = false,
    this.status = 1,
    this.replyToDetails,
  });

  factory GroupMessageModel.fromJson(Map<String, dynamic> json) {
    return GroupMessageModel(
      id: json['_id'] ?? '',
      senderId: json['sender_id'] ?? '',
      message: json['message'] ?? '',
      roomId: json['room_id'] ?? '',
      //receiverId: (json['receiver_id'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      receiverId: json['receiver_id'] is List
          ? (json['receiver_id'] as List).map((e) => e.toString()).toList()
          : [json['receiver_id'].toString()],
      attachmentId: json["attechment_id"] is String
          ? [json["attechment_id"]]
          : (json["attechment_id"] as List<dynamic>?)?.map((id) => id.toString()).toList(),
      attachmentDetails: json["attechment_details"] is Map<String, dynamic>
          ? [UploadFile.fromJson(json["attechment_details"])]
          : (json["attechment_details"] as List<dynamic>?)?.map((item) => UploadFile.fromJson(item)).toList(),
      senderDetails: (json['sender_details'] as List<dynamic>?)
          ?.map((e) => UserDetails.fromJson(e))
          .toList() ??
          [],
      messageType: json["message_type"] ?? '',
      latitude: (json["latitude"] is String)
          ? double.tryParse(json["latitude"])
          : json["latitude"] as double?,
      longitude: (json["longitude"] is String)
          ? double.tryParse(json["longitude"])
          : json["longitude"] as double?,
      //deletedFor: (json['deletedFor'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      replyTo: json['reply_to'] is Map<String, dynamic>
          ? GroupMessageModel.fromJson(json['reply_to'])
          : null,
      messageStatus: json["message_status"] ?? 'sent',
      createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) ?? DateTime.now() : DateTime.now(),
      updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) ?? DateTime.now() : DateTime.now(),
      isDeleted: json["is_deleted"] ?? false,
      status: json["status"] ?? 1,
      replyToDetails: json['reply_to_details'] != null
          ? GroupMessageModel.fromJson(json['reply_to_details'])
          : null,
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
      "sender_details": senderDetails?.map((e) => e.toJson()).toList(),
      "room_id": roomId,
      "message_type": messageType,
      "latitude": latitude,
      "longitude": longitude,
      "reply_to": replyTo?.toJson(),
      "message_status": messageStatus,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "is_deleted": isDeleted,
      "status": status,
      'reply_to_details': replyToDetails?.toJson(),
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
    List<UserDetails>? senderDetails,
    String? messageType,
    double? latitude,
    double? longitude,
    GroupMessageModel? replyTo,
    String? messageStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
    int? status,
    GroupMessageModel? replyToDetails,
  }) {
    return GroupMessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      roomId: roomId ?? this.roomId,
      message: message ?? this.message,
      attachmentId: attachmentId ?? this.attachmentId,
      attachmentDetails: attachmentDetails ?? this.attachmentDetails,
      senderDetails: senderDetails ?? this.senderDetails,
      messageType: messageType ?? this.messageType,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      replyTo: replyTo ?? this.replyTo,
      messageStatus: messageStatus ?? this.messageStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      status: status ?? this.status,
      replyToDetails: replyToDetails ?? this.replyToDetails,
    );
  }

}

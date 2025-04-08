import 'package:orbitwork/models/upload_file_model.dart';

class MessagesModel {
  final String name;
  final String title;
  final String lastMessage;
  final String date;

  MessagesModel(
      {required this.name,
        required this.title,
        required this.lastMessage,
        required this.date,
      });
}


class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;
  final bool isRead;
  String? imagePath;
  String? filePath;
  double? latitude;
  double? longitude;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    this.isRead = false,
    this.imagePath,
    this.filePath,
    this.latitude,
    this.longitude
  });
}

///for api call message ///




class MessageModel {
  final String? messageId;
  final String senderId;
  final String? receiverId;
  final String? message;
  final List<String>? attachmentId;
  final List<UploadFile>? attachmentDetails;
  final String? roomId;
  final String? messageType;
  final double? latitude;
  final double? longitude;
   String messageStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final int status;

  MessageModel({
    this.messageId,
    required this.senderId,
    this.receiverId,
    this.message,
    this.attachmentId,
    this.attachmentDetails,
    this.roomId,
    this.messageType,
    this.latitude,
    this.longitude,
    required this.messageStatus,
    required dynamic createdAt,
    required this.updatedAt,
    this.isDeleted = false,
    this.status = 1,
  }) : createdAt = createdAt is int
      ? DateTime.fromMillisecondsSinceEpoch(createdAt)
      : createdAt is String
      ? DateTime.tryParse(createdAt) ?? DateTime.now()
      : createdAt;

  ///  Convert JSON to `MessageModel` object
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json["_id"] ?? '',
      senderId: json["sender_id"] ?? '',
      receiverId: json["receiver_id"] ??'',
      message: json["message"] ?? '',
      // attachmentId: json["attechment_id"] ?? '',
      // attachmentDetails: (json["attechment_details"] != null && json["attechment_details"].isNotEmpty)
      //     ? UploadFile.fromJson(json["attechment_details"][0])
      //     : null,

      attachmentId: json["attechment_id"] is String
          ? [json["attechment_id"]]
          : (json["attechment_id"] as List<dynamic>?)?.map((id) => id.toString()).toList(),

      attachmentDetails: json["attechment_details"] is Map<String, dynamic>
          ? [UploadFile.fromJson(json["attechment_details"])]
          : (json["attechment_details"] as List<dynamic>?)?.map((item) => UploadFile.fromJson(item)).toList(),

      // attachmentId: (json["attechment_id"] as List<dynamic>?)
      //     ?.map((id) => id.toString())
      //     .toList(),
      // attachmentDetails: (json["attechment_details"] as List<dynamic>?)
      //     ?.map((item) => UploadFile.fromJson(item))
      //     .toList(),
      roomId: json["room_id"] ?? '',
      messageType: json["message_type"] ?? '',

      latitude: (json["latitude"] is String)
          ? double.tryParse(json["latitude"])
          : json["latitude"] as double?,

      longitude: (json["longitude"] is String)
          ? double.tryParse(json["longitude"])
          : json["longitude"] as double?,

      messageStatus: json["message_status"] ?? 'sent',

      // latitude: json["latitude"] ?? '',
      // longitude: json["longitude"] ?? '',
      createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) ?? DateTime.now() : DateTime.now(),
      updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) ?? DateTime.now() : DateTime.now(),
      isDeleted: json["is_deleted"] ?? false,
      status: json["status"] ?? 1,
    );
  }

  ///  Convert `MessageModel` object to JSON
  Map<String, dynamic> toJson() {
    return {
      "_id": messageId,
      "sender_id": senderId,
      "receiver_id": receiverId,
      "message": message,
      "attechment_id": attachmentId,
     // "attechment_details": attachmentDetails?.toJson(),
      "attechment_details": attachmentDetails?.map((e) => e.toJson()).toList(),
      "room_id": roomId,
      "message_type": messageType,
      "latitude": latitude,
      "longitude": longitude,
      "message_status": messageStatus,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "is_deleted": isDeleted,
      "status": status,
    };
  }

  /// Convert JSON List to List of `MessageModel`
  static List<MessageModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MessageModel.fromJson(json)).toList();
  }
}

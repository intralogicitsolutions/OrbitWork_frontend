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
  final String senderId;
  final String? receiverId;
  final String? message;
  final String? attachmentId;
  final String? roomId;
  final String? messageType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final int status;

  MessageModel({
    required this.senderId,
    this.receiverId,
    this.message,
    this.attachmentId,
    this.roomId,
    this.messageType,
    required this.createdAt,
    required this.updatedAt,
    this.isDeleted = false,
    this.status = 1,
  });

  /// ✅ Convert JSON to `MessageModel` object
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json["sender_id"],
      receiverId: json["receiver_id"],
      message: json["message"],
      attachmentId: json["attechment_id"],
      roomId: json["room_id"],
      messageType: json["message_type"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      isDeleted: json["is_deleted"] ?? false,
      status: json["status"] ?? 1,
    );
  }

  /// ✅ Convert `MessageModel` object to JSON
  Map<String, dynamic> toJson() {
    return {
      "sender_id": senderId,
      "receiver_id": receiverId,
      "message": message,
      "attechment_id": attachmentId,
      "room_id": roomId,
      "message_type": messageType,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "is_deleted": isDeleted,
      "status": status,
    };
  }

  /// ✅ Convert JSON List to List of `MessageModel`
  static List<MessageModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MessageModel.fromJson(json)).toList();
  }
}

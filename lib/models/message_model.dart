class MessageModel {
  final String name;
  final String title;
  final String lastMessage;
  final String date;

  MessageModel(
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

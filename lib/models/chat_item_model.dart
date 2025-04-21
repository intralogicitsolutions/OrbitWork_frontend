// class ChatUser {
//   final String id;
//   final String name;
//   // final String role;
//   // final String? company;
//   // final String avatarInitials;
//
//   ChatUser({
//     required this.id,
//     required this.name,
//     // required this.role,
//     // this.company,
//     // required this.avatarInitials,
//   });
// }



/// for api call ///

class ChatItem {
  final bool isRoom;
  final String name;
  final String? messageWithPrefix;
  final DateTime createdAt;
  final String? email;
  final String? userId;
  final String? roomId;

  DateTime? lastSeen;
  bool isOnline;

  ChatItem({
    required this.isRoom,
    required this.name,
    this.messageWithPrefix,
    required this.createdAt,
    this.email,
    this.userId,
    this.roomId,
    this.lastSeen,
    this.isOnline = false,
  });

  void updateOnlineStatus(bool online) {
    isOnline = online;
    if (online) {
      lastSeen = DateTime.now();
    }
  }

  factory ChatItem.fromJson(Map<String, dynamic> json) {
    return ChatItem(
      isRoom: json['isRoom'] ?? false,
      name: json['name'] ?? '',
      messageWithPrefix: json['messageWithPrefix'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      email: json['email'],
      userId: json['user_id'],
      roomId: json['room_id'],
    );
  }


  ChatItem copyWith({
    bool? isRoom,
    String? name,
    String? messageWithPrefix,
    DateTime? createdAt,
    String? email,
    String? userId,
    String? roomId,
    DateTime? lastSeen,
    bool? isOnline,
  }) {
    return ChatItem(
      isRoom: isRoom ?? this.isRoom,
      name: name ?? this.name,
      messageWithPrefix: messageWithPrefix ?? this.messageWithPrefix,
      createdAt: createdAt ?? this.createdAt,
      email: email ?? this.email,
      userId: userId ?? this.userId,
      roomId: roomId ?? this.roomId,
      lastSeen: lastSeen ?? this.lastSeen,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}

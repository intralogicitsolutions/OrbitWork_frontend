class Rooms {
  final String? name;
  final List<String> people;

  Rooms({this.name, required this.people});
}

class Room {
  final String? id;
  final String userId;
  final String name;
  final List<String>? members;
  final List<String>? admin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isDeleted;
  final int? status;

  Room({
    this.id,
    required this.userId,
    required this.name,
    this.members,
    this.admin,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.status,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['_id'],
      userId: json['user_id'],
      name: json['name'],
      members: List<String>.from(json['members']),
      admin: List<String>.from(json['admin']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isDeleted: json['is_deleted'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'name': name,
      'members': members,
      'admin': admin,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'is_deleted': isDeleted,
      'status': status,
    };
  }
}

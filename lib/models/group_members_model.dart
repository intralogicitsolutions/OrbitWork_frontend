class Member {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final bool isAdmin;

  Member({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.isAdmin,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      isAdmin: json['is_admin'],
    );
  }
}

class RoomWithMembers {
  final String roomName;
  final int totalMembers;
  final List<Member> members;
  final String? currentUserId;

  RoomWithMembers({
    required this.roomName,
    required this.totalMembers,
    required this.members,
    this.currentUserId,
  });

  factory RoomWithMembers.fromJson(Map<String, dynamic> json) {
    return RoomWithMembers(
      roomName: json['room_name'],
      totalMembers: json['total_members'],
      currentUserId: json['current_user_id'],
      members: List<Member>.from(
        json['members'].map((x) => Member.fromJson(x)),
      ),
    );
  }
}

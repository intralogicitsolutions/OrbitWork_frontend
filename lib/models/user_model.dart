class UsersModel {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String timeZone;
  final String city;
  final String state;
  final String pinCode;
  final String country;
  final String phone;
  final String address;
  final String address2;

  UsersModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.timeZone,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.country,
    required this.phone,
    required this.address,
    required this.address2
});
}



/// for user api calling ///

class UserModel {
  final String? id;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? password;
  final int? role;
  final String? token;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;
  final int status;

  UserModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    this.password,
    required this.role,
    this.token,
    required this.createdAt,
    required this.updatedAt,
    this.isDeleted = false,
    this.status = 1,
  });

  /// ✅ Convert JSON to `UserModel` object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      email: json["email"],
      password: json["password"],
      role: json["role"],
      token: json["token"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      isDeleted: json["is_deleted"] ?? false,
      status: json["status"] ?? 1,
    );
  }

  /// ✅ Convert `UserModel` object to JSON
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "password": password,
      "role": role,
      "token": token,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "is_deleted": isDeleted,
      "status": status,
    };
  }
}


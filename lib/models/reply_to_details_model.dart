class ReplyToDetails {
  final String? message;
  final String? messageStatus;

  ReplyToDetails({this.message, this.messageStatus});

  factory ReplyToDetails.fromJson(Map<String, dynamic> json) {
    return ReplyToDetails(
      message: json['message'],
      messageStatus: json['message_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'message_status': messageStatus,
    };
  }
}

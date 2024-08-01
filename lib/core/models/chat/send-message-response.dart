class SendMessageResponse {
  int? msgType;
  String? username;
  String? userId;
  String? message;
  String? naturalTimestamp;

  SendMessageResponse(
      {this.msgType,
      this.username,
      this.userId,
      this.message,
      this.naturalTimestamp});

  SendMessageResponse.fromJson(Map<String, dynamic> json) {
    msgType = json['msg_type'];
    username = json['username'];
    userId = json['user_id'];
    message = json['message'];
    naturalTimestamp = json['natural_timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg_type'] = msgType;
    data['username'] = username;
    data['user_id'] = userId;
    data['message'] = message;
    data['natural_timestamp'] = naturalTimestamp;
    return data;
  }
}

class GetChatMessagesResponse {
  String? messagesPayload;
  List<Messages>? messages;
  int? newPageNumber;

  GetChatMessagesResponse(
      {this.messagesPayload, this.messages, this.newPageNumber});

  GetChatMessagesResponse.fromJson(Map<String, dynamic> json) {
    messagesPayload = json['messages_payload'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
    newPageNumber = json['new_page_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messages_payload'] = messagesPayload;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    data['new_page_number'] = newPageNumber;
    return data;
  }
}

class Messages {
  int? msgType;
  String? msgId;
  String? userId;
  String? username;
  String? message;
  String? profileImage;
  String? naturalTimestamp;

  Messages(
      {this.msgType,
      this.msgId,
      this.userId,
      this.username,
      this.message,
      this.profileImage,
      this.naturalTimestamp});

  Messages.fromJson(Map<String, dynamic> json) {
    msgType = json['msg_type'];
    msgId = json['msg_id'];
    userId = json['user_id'];
    username = json['username'];
    message = json['message'];
    profileImage = json['profile_image'];
    naturalTimestamp = json['natural_timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg_type'] = msgType;
    data['msg_id'] = msgId;
    data['user_id'] = userId;
    data['username'] = username;
    data['message'] = message;
    data['profile_image'] = profileImage;
    data['natural_timestamp'] = naturalTimestamp;
    return data;
  }
}

class GetLastMessagesResponse {
  List<MessageData>? data;

  GetLastMessagesResponse({this.data});

  GetLastMessagesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MessageData>[];
      json['data'].forEach((v) {
        data!.add(MessageData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MessageData {
  String? friendId;
  String? user;
  String? firstName;
  String? lastName;
  String? profileImage;
  LastMessage? lastMessage;

  MessageData(
      {this.friendId,
      this.user,
      this.firstName,
      this.lastName,
      this.profileImage,
      this.lastMessage});

  MessageData.fromJson(Map<String, dynamic> json) {
    friendId = json['friend_id'];
    user = json['user'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileImage = json['profile_image'];
    lastMessage = json['last_message'] != null
        ? LastMessage.fromJson(json['last_message'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['friend_id'] = friendId;
    data['user'] = user;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['profile_image'] = profileImage;
    if (lastMessage != null) {
      data['last_message'] = lastMessage!.toJson();
    }
    return data;
  }
}

class LastMessage {
  String? room;
  String? timestamp;
  String? content;

  LastMessage({this.room, this.timestamp, this.content});

  LastMessage.fromJson(Map<String, dynamic> json) {
    room = json['room'];
    timestamp = json['timestamp'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['room'] = room;
    data['timestamp'] = timestamp;
    data['content'] = content;
    return data;
  }
}

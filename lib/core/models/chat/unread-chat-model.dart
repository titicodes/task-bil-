class UnreadMessageCountResponse {
  int? chatMsgType;
  int? count;

  UnreadMessageCountResponse({this.chatMsgType, this.count});

  UnreadMessageCountResponse.fromJson(Map<String, dynamic> json) {
    chatMsgType = json['chat_msg_type'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chat_msg_type'] = chatMsgType;
    data['count'] = count;
    return data;
  }
}

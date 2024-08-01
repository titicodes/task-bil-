class GetChatDetailResponse {
  String? user2Id;
  String? response;
  int? chatroomId;

  GetChatDetailResponse({this.user2Id, this.response, this.chatroomId});

  GetChatDetailResponse.fromJson(Map<String, dynamic> json) {
    user2Id = json['user2_id'];
    response = json['response'];
    chatroomId = json['chatroom_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user2_id'] = user2Id;
    data['response'] = response;
    data['chatroom_id'] = chatroomId;
    return data;
  }
}

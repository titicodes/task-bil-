import 'dart:convert';

List<BlockListResponse> getBlockedUserListFromJson(String str) =>
    List<BlockListResponse>.from(
        json.decode(str).map((x) => BlockListResponse.fromJson(x)));

String getBlockedUserListToJson(List<BlockListResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlockListResponse {
  String? uid;
  String? username;
  String? profileImage;
  bool? isOnline;

  BlockListResponse(
      {this.uid, this.username, this.profileImage, this.isOnline});

  BlockListResponse.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    profileImage = json['profile_image'];
    isOnline = json['is_online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['username'] = username;
    data['profile_image'] = profileImage;
    data['is_online'] = isOnline;
    return data;
  }
}

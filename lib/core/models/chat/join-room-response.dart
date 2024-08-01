class JoinRoomResponse {
  String? join;

  JoinRoomResponse({this.join});

  JoinRoomResponse.fromJson(Map<String, dynamic> json) {
    join = json['join'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['join'] = join;
    return data;
  }
}

class GetUserInfoModel {
  String? command;
  String? roomID;

  GetUserInfoModel({this.command, this.roomID});

  GetUserInfoModel.fromJson(Map<String, dynamic> json) {
    command = json['command'] ?? 'get_user_info';
    roomID = json['room_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['command'] = command ?? 'get_user_info';
    data['room_id'] = roomID;

    return data;
  }
}

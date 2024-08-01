class GetChatUserDetailResponse {
  Details? details;

  GetChatUserDetailResponse({this.details});

  GetChatUserDetailResponse.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['details'] = details!.toJson();
    }
    return data;
  }
}

class Details {
  UserInfo? userInfo;

  Details({this.userInfo});

  Details.fromJson(Map<String, dynamic> json) {
    userInfo =
        json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userInfo != null) {
      data['user_info'] = userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  Fields? fields;
  String? model;
  String? pk;

  UserInfo({this.fields, this.model, this.pk});

  UserInfo.fromJson(Map<String, dynamic> json) {
    fields = json['fields'] != null ? Fields.fromJson(json['fields']) : null;
    model = json['model'];
    pk = json['pk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fields != null) {
      data['fields'] = fields!.toJson();
    }
    data['model'] = model;
    data['pk'] = pk;
    return data;
  }
}

class Fields {
  String? firstName;
  String? lastName;
  String? profileImage;
  String? username;

  Fields({this.firstName, this.lastName, this.profileImage, this.username});

  Fields.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileImage = json['profile_image'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['profile_image'] = profileImage;
    data['username'] = username;
    return data;
  }
}

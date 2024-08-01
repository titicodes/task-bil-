class LoginResponse {
  String? token;
  String? uid;
  bool? verifyStatus;
  bool? servicepro;

  LoginResponse({this.token, this.uid, this.verifyStatus, this.servicepro});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    uid = json['uid'];
    verifyStatus = json['verify-status'];
    servicepro = json['servicepro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['uid'] = uid;
    data['verify-status'] = verifyStatus;
    data['servicepro'] = servicepro;
    return data;
  }
}

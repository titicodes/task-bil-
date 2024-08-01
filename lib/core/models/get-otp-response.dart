class GetOtpResponse {
  bool? status;
  String? detail;
  String? pinId;

  GetOtpResponse({this.status, this.detail, this.pinId});

  GetOtpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    detail = json['detail'];
    pinId = json['pinId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['detail'] = detail;
    data['pinId'] = pinId;
    return data;
  }
}

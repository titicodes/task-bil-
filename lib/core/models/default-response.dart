class DefaultResponse {
  bool? status;
  String? detail;
  String? message;
  dynamic data;

  DefaultResponse({this.status, this.detail, this.message});

  DefaultResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    detail = json['detail'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['detail'] = detail;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}

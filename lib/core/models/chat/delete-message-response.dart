class DeleteMessageResponse {
  bool? status;
  String? detail;

  DeleteMessageResponse({this.status, this.detail});

  DeleteMessageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['detail'] = detail;
    return data;
  }
}

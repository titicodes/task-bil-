class NameLookUpResponse {
  bool? status;
  String? detail;
  String? name;

  NameLookUpResponse({this.status, this.detail, this.name});

  NameLookUpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    detail = json['detail'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['detail'] = detail;
    data['name'] = name;
    return data;
  }
}

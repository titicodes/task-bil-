class BillersResponse {
  Data? data;

  BillersResponse({this.data});

  BillersResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  bool? error;
  String? status;
  String? message;
  String? responseCode;
  List<ResponseData>? responseData;

  Data(
      {this.error,
      this.status,
      this.message,
      this.responseCode,
      this.responseData});

  Data.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    status = json['status'];
    message = json['message'];
    responseCode = json['responseCode'];
    if (json['responseData'] != null) {
      responseData = <ResponseData>[];
      json['responseData'].forEach((v) {
        responseData!.add(ResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['status'] = status;
    data['message'] = message;
    data['responseCode'] = responseCode;
    if (responseData != null) {
      data['responseData'] = responseData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseData {
  int? id;
  String? name;
  String? slug;
  int? groupId;
  bool? skipValidation;
  bool? handleWithProductCode;
  bool? isRestricted;
  bool? hideInstitution;

  ResponseData(
      {this.id,
      this.name,
      this.slug,
      this.groupId,
      this.skipValidation,
      this.handleWithProductCode,
      this.isRestricted,
      this.hideInstitution});

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    groupId = json['groupId'];
    skipValidation = json['skipValidation'];
    handleWithProductCode = json['handleWithProductCode'];
    isRestricted = json['isRestricted'];
    hideInstitution = json['hideInstitution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['groupId'] = groupId;
    data['skipValidation'] = skipValidation;
    data['handleWithProductCode'] = handleWithProductCode;
    data['isRestricted'] = isRestricted;
    data['hideInstitution'] = hideInstitution;
    return data;
  }
}

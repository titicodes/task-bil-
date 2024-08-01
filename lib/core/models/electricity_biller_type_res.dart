class BillerTypeResponse {
  Data? data;

  BillerTypeResponse({this.data});

  BillerTypeResponse.fromJson(Map<String, dynamic> json) {
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
  List<ResponseTypeData>? responseData;

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
      responseData = <ResponseTypeData>[];
      json['responseData'].forEach((v) {
        responseData!.add(ResponseTypeData.fromJson(v));
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

class ResponseTypeData {
  int? id;
  String? name;
  String? slug;
  double? amount;
  int? billerId;
  int? sequenceNumber;

  ResponseTypeData(
      {this.id,
      this.name,
      this.slug,
      this.amount,
      this.billerId,
      this.sequenceNumber});

  ResponseTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    amount = double.tryParse(json['amount'].toString()) ?? 0.0;
    billerId = json['billerId'];
    sequenceNumber = json['sequenceNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['amount'] = amount;
    data['billerId'] = billerId;
    data['sequenceNumber'] = sequenceNumber;
    return data;
  }
}

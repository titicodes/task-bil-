class DataResponseModel {
  late Map<String, MtnDataBundle>? data;

  DataResponseModel({this.data});

  DataResponseModel.fromJson(Map<String, dynamic> json) {
    data = Map<String, MtnDataBundle>.from(
      (json['data'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(
              key,
              MtnDataBundle.fromJson(value),
            ),
          ) ??
          {},
    );
  }
}

class MtnDataBundle {
  late int? id;
  late String? slug;
  late num? amount;
  late int? billerId;
  late int? sequenceNumber;

  MtnDataBundle({
    this.id,
    this.slug,
    this.amount,
    this.billerId,
    this.sequenceNumber,
  });

  MtnDataBundle.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    slug = json['slug'] ?? "";
    amount = json['amount'] ?? 0;
    billerId = json['billerId'] ?? 0;
    sequenceNumber = json['sequenceNumber'] ?? 0;
  }
}

class ConvertedDataResponse {
  List<UseData>? data;

  ConvertedDataResponse({this.data});

  ConvertedDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UseData>[];
      json['data'].forEach((v) {
        data!.add(UseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UseData {
  String? name;
  Object? object;

  UseData({this.name, this.object});

  UseData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    object = json['object'] != null ? Object.fromJson(json['object']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (object != null) {
      data['object'] = object!.toJson();
    }
    return data;
  }
}

class Object {
  int? id;
  String? slug;
  double? amount;
  int? billerId;
  int? sequenceNumber;
  String? name; // Add the name property here

  Object(
      {this.id,
      this.slug,
      this.amount,
      this.billerId,
      this.sequenceNumber,
      this.name});

  Object.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    amount = double.tryParse(json['amount'].toString()) ?? 0.0;
    billerId = json['billerId'];
    sequenceNumber = json['sequenceNumber'];
    name = UseData().name;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['amount'] = amount;
    data['billerId'] = billerId;
    data['sequenceNumber'] = sequenceNumber;
    return data;
  }
}

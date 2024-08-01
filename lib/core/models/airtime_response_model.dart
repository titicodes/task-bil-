class AirtimeResponseModel {
  Data? data;

  AirtimeResponseModel({this.data});

  AirtimeResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  MTNVTU? mTNVTU;
  MTNVTU? aIRTELVTU;
  MTNVTU? gLOVTU;
  MTNVTU? m9MOBILEVTU;

  Data({this.mTNVTU, this.aIRTELVTU, this.gLOVTU, this.m9MOBILEVTU});

  Data.fromJson(Map<String, dynamic> json) {
    mTNVTU =
        json['MTN VTU'] != null ? new MTNVTU.fromJson(json['MTN VTU']) : null;
    aIRTELVTU = json['AIRTEL VTU'] != null
        ? new MTNVTU.fromJson(json['AIRTEL VTU'])
        : null;
    gLOVTU =
        json['GLO VTU'] != null ? new MTNVTU.fromJson(json['GLO VTU']) : null;
    m9MOBILEVTU = json['9MOBILE VTU'] != null
        ? new MTNVTU.fromJson(json['9MOBILE VTU'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mTNVTU != null) {
      data['MTN VTU'] = this.mTNVTU!.toJson();
    }
    if (this.aIRTELVTU != null) {
      data['AIRTEL VTU'] = this.aIRTELVTU!.toJson();
    }
    if (this.gLOVTU != null) {
      data['GLO VTU'] = this.gLOVTU!.toJson();
    }
    if (this.m9MOBILEVTU != null) {
      data['9MOBILE VTU'] = this.m9MOBILEVTU!.toJson();
    }
    return data;
  }
}

class MTNVTU {
  int? id;
  String? slug;
  Null? amount;
  int? billerId;
  int? sequenceNumber;

  MTNVTU({this.id, this.slug, this.amount, this.billerId, this.sequenceNumber});

  MTNVTU.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    amount = json['amount'];
    billerId = json['billerId'];
    sequenceNumber = json['sequenceNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['amount'] = this.amount;
    data['billerId'] = this.billerId;
    data['sequenceNumber'] = this.sequenceNumber;
    return data;
  }
}

class AirTimeProvider {
  String? type;
  AirTimeServiceProvider? data;

  AirTimeProvider({this.type, this.data});

  AirTimeProvider.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'] != null
        ? new AirTimeServiceProvider.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AirTimeServiceProvider {
  int? id;
  String? slug;
  String? image;
  String? name;
  Null? amount;
  int? billerId;
  int? sequenceNumber;

  AirTimeServiceProvider(
      {this.id,
      this.slug,
      this.name,
      this.image,
      this.amount,
      this.billerId,
      this.sequenceNumber});

  AirTimeServiceProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    slug = json['slug'];
    amount = json['amount'];
    billerId = json['billerId'];
    sequenceNumber = json['sequenceNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['billerId'] = this.billerId;
    data['sequenceNumber'] = this.sequenceNumber;
    return data;
  }
}

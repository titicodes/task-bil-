class InternetResponseModel {
  Data? data;

  InternetResponseModel({this.data});

  InternetResponseModel.fromJson(Map<String, dynamic> json) {
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
  Smile? smile;
  Smile? spectranet;
  Smile? smile2;
  Smile? iPNX;
  Smile? sWIFTNETWORKS;

  Data(
      {this.smile,
      this.spectranet,
      this.smile2,
      this.iPNX,
      this.sWIFTNETWORKS});

  Data.fromJson(Map<String, dynamic> json) {
    smile = json['Smile'] != null ? Smile.fromJson(json['Smile']) : null;
    spectranet =
        json['Spectranet'] != null ? Smile.fromJson(json['Spectranet']) : null;
    smile2 = json['Smile 2'] != null ? Smile.fromJson(json['Smile 2']) : null;
    iPNX = json['IPNX'] != null ? Smile.fromJson(json['IPNX']) : null;
    sWIFTNETWORKS = json['SWIFT NETWORKS'] != null
        ? Smile.fromJson(json['SWIFT NETWORKS'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (smile != null) {
      data['Smile'] = smile!.toJson();
    }
    if (spectranet != null) {
      data['Spectranet'] = spectranet!.toJson();
    }
    if (smile2 != null) {
      data['Smile 2'] = smile2!.toJson();
    }
    if (iPNX != null) {
      data['IPNX'] = iPNX!.toJson();
    }
    if (sWIFTNETWORKS != null) {
      data['SWIFT NETWORKS'] = sWIFTNETWORKS!.toJson();
    }
    return data;
  }
}

class Smile {
  int? id;
  String? slug;
  int? groupId;
  bool? skipValidation;
  bool? handleWithProductCode;
  bool? isRestricted;
  bool? hideInstitution;

  Smile(
      {this.id,
      this.slug,
      this.groupId,
      this.skipValidation,
      this.handleWithProductCode,
      this.isRestricted,
      this.hideInstitution});

  Smile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['slug'] = slug;
    data['groupId'] = groupId;
    data['skipValidation'] = skipValidation;
    data['handleWithProductCode'] = handleWithProductCode;
    data['isRestricted'] = isRestricted;
    data['hideInstitution'] = hideInstitution;
    return data;
  }
}

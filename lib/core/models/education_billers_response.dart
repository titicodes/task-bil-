class EducationBillersResponse {
  EducationData? data;

  EducationBillersResponse({this.data});

  EducationBillersResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? EducationData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class EducationData {
  int? id;
  String? name;
  String? slug;
  int? groupId;
  bool? skipValidation;
  bool? handleWithProductCode;
  bool? isRestricted;
  bool? hideInstitution;

  EducationData(
      {this.id,
      this.name,
      this.slug,
      this.groupId,
      this.skipValidation,
      this.handleWithProductCode,
      this.isRestricted,
      this.hideInstitution});

  EducationData.fromJson(Map<String, dynamic> json) {
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

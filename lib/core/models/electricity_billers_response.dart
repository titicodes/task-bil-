class PowerDistributionResponse {
  Data? data;

  PowerDistributionResponse({this.data});

  PowerDistributionResponse.fromJson(Map<String, dynamic> json) {
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
  EnuguDisco? enuguDisco;
  EnuguDisco? ekoDisco;
  EnuguDisco? abujaDisco;
  EnuguDisco? portHarcourtDisco;
  EnuguDisco? iKEDC;
  EnuguDisco? iBEDC;
  EnuguDisco? kEDCO;
  EnuguDisco? kAEDCO;
  EnuguDisco? jEDC;
  EnuguDisco? pHED2;
  EnuguDisco? aPLE;
  EnuguDisco? bEDC;

  Data(
      {this.enuguDisco,
      this.ekoDisco,
      this.abujaDisco,
      this.portHarcourtDisco,
      this.iKEDC,
      this.iBEDC,
      this.kEDCO,
      this.kAEDCO,
      this.jEDC,
      this.pHED2,
      this.aPLE,
      this.bEDC});

  Data.fromJson(Map<String, dynamic> json) {
    enuguDisco = json['Enugu Disco'] != null
        ? EnuguDisco.fromJson(json['Enugu Disco'])
        : null;
    ekoDisco = json['Eko Disco'] != null
        ? EnuguDisco.fromJson(json['Eko Disco'])
        : null;
    abujaDisco = json['Abuja Disco'] != null
        ? EnuguDisco.fromJson(json['Abuja Disco'])
        : null;
    portHarcourtDisco = json['PortHarcourt Disco'] != null
        ? EnuguDisco.fromJson(json['PortHarcourt Disco'])
        : null;
    iKEDC = json['IKEDC'] != null ? EnuguDisco.fromJson(json['IKEDC']) : null;
    iBEDC = json['IBEDC'] != null ? EnuguDisco.fromJson(json['IBEDC']) : null;
    kEDCO = json['KEDCO'] != null ? EnuguDisco.fromJson(json['KEDCO']) : null;
    kAEDCO =
        json['KAEDCO'] != null ? EnuguDisco.fromJson(json['KAEDCO']) : null;
    jEDC = json['JEDC'] != null ? EnuguDisco.fromJson(json['JEDC']) : null;
    pHED2 = json['PHED 2'] != null ? EnuguDisco.fromJson(json['PHED 2']) : null;
    aPLE = json['APLE'] != null ? EnuguDisco.fromJson(json['APLE']) : null;
    bEDC = json['BEDC'] != null ? EnuguDisco.fromJson(json['BEDC']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (enuguDisco != null) {
      data['Enugu Disco'] = enuguDisco!.toJson();
    }
    if (ekoDisco != null) {
      data['Eko Disco'] = ekoDisco!.toJson();
    }
    if (abujaDisco != null) {
      data['Abuja Disco'] = abujaDisco!.toJson();
    }
    if (portHarcourtDisco != null) {
      data['PortHarcourt Disco'] = portHarcourtDisco!.toJson();
    }
    if (iKEDC != null) {
      data['IKEDC'] = iKEDC!.toJson();
    }
    if (iBEDC != null) {
      data['IBEDC'] = iBEDC!.toJson();
    }
    if (kEDCO != null) {
      data['KEDCO'] = kEDCO!.toJson();
    }
    if (kAEDCO != null) {
      data['KAEDCO'] = kAEDCO!.toJson();
    }
    if (jEDC != null) {
      data['JEDC'] = jEDC!.toJson();
    }
    if (pHED2 != null) {
      data['PHED 2'] = pHED2!.toJson();
    }
    if (aPLE != null) {
      data['APLE'] = aPLE!.toJson();
    }
    if (bEDC != null) {
      data['BEDC'] = bEDC!.toJson();
    }
    return data;
  }
}

class EnuguDisco {
  int? id;
  String? slug;
  int? groupId;
  bool? skipValidation;
  bool? handleWithProductCode;
  bool? isRestricted;
  bool? hideInstitution;

  EnuguDisco(
      {this.id,
      this.slug,
      this.groupId,
      this.skipValidation,
      this.handleWithProductCode,
      this.isRestricted,
      this.hideInstitution});

  EnuguDisco.fromJson(Map<String, dynamic> json) {
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

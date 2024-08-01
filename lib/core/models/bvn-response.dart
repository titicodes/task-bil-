class BVNResponse {
  Detail? detail;

  BVNResponse({this.detail});

  BVNResponse.fromJson(Map<String, dynamic> json) {
    detail =
        json['Detail'] != null ? new Detail.fromJson(json['Detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detail != null) {
      data['Detail'] = this.detail!.toJson();
    }
    return data;
  }
}

class Detail {
  String? responseCode;
  String? description;
  String? verificationType;
  String? verificationStatus;
  String? transactionStatus;
  String? transactionReference;
  String? transactionDate;
  String? searchParameter;
  Null? callBackUrl;
  double? livenessScore;
  Null? paymentRef;
  ResponseDates? response;
  Null? faceMatch;
  Null? licenseSessionId;
  Null? remainingLicenseSessionRound;

  Detail(
      {this.responseCode,
      this.description,
      this.verificationType,
      this.verificationStatus,
      this.transactionStatus,
      this.transactionReference,
      this.transactionDate,
      this.searchParameter,
      this.callBackUrl,
      this.livenessScore,
      this.paymentRef,
      this.response,
      this.faceMatch,
      this.licenseSessionId,
      this.remainingLicenseSessionRound});

  Detail.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    description = json['description'];
    verificationType = json['verificationType'];
    verificationStatus = json['verificationStatus'];
    transactionStatus = json['transactionStatus'];
    transactionReference = json['transactionReference'];
    transactionDate = json['transactionDate'];
    searchParameter = json['searchParameter'];
    callBackUrl = json['callBackUrl'];
    livenessScore = double.tryParse(json['livenessScore'].toString()) ?? 0;
    paymentRef = json['paymentRef'];
    response = json['response'] != null
        ? new ResponseDates.fromJson(json['response'])
        : null;
    faceMatch = json['faceMatch'];
    licenseSessionId = json['licenseSessionId'];
    remainingLicenseSessionRound = json['remainingLicenseSessionRound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['description'] = this.description;
    data['verificationType'] = this.verificationType;
    data['verificationStatus'] = this.verificationStatus;
    data['transactionStatus'] = this.transactionStatus;
    data['transactionReference'] = this.transactionReference;
    data['transactionDate'] = this.transactionDate;
    data['searchParameter'] = this.searchParameter;
    data['callBackUrl'] = this.callBackUrl;
    data['livenessScore'] = this.livenessScore;
    data['paymentRef'] = this.paymentRef;
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    data['faceMatch'] = this.faceMatch;
    data['licenseSessionId'] = this.licenseSessionId;
    data['remainingLicenseSessionRound'] = this.remainingLicenseSessionRound;
    return data;
  }
}

class ResponseDates {
  bool? validFirstName;
  bool? validLastName;
  bool? validDateOfBirth;

  ResponseDates(
      {this.validFirstName, this.validLastName, this.validDateOfBirth});

  ResponseDates.fromJson(Map<String, dynamic> json) {
    validFirstName = json['validFirstName'];
    validLastName = json['validLastName'];
    validDateOfBirth = json['validDateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['validFirstName'] = this.validFirstName;
    data['validLastName'] = this.validLastName;
    data['validDateOfBirth'] = this.validDateOfBirth;
    return data;
  }
}

class GCMResponse {
  int? id;
  String? name;
  String? registrationId;
  String? deviceId;
  bool? active;
  String? dateCreated;
  String? cloudMessageType;
  String? applicationId;

  GCMResponse({
    this.id,
    this.name,
    this.registrationId,
    this.deviceId,
    this.active,
    this.dateCreated,
    this.cloudMessageType,
    this.applicationId,
  });

  GCMResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    registrationId = json['registration_id'];
    deviceId = json['device_id'];
    active = json['active'];
    dateCreated = json['date_created'];
    cloudMessageType = json['cloud_message_type'];
    applicationId = json['application_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['registration_id'] = registrationId;
    data['device_id'] = deviceId;
    data['active'] = active;
    data['date_created'] = dateCreated;
    data['cloud_message_type'] = cloudMessageType;
    data['application_id'] = applicationId;
    return data;
  }
}

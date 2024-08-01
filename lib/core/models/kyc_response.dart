import 'dart:convert';

class KycResponse {
  String? responseCode;
  String? description;
  String? verificationType;
  String? verificationStatus;
  String? transactionStatus;
  String? transactionReference;
  String? transactionDate;
  String? searchParameter;
  dynamic callBackUrl;
  double? livenessScore;
  dynamic paymentRef;
  Responses? response; // Use Responses instead of Responses?
  dynamic faceMatch;

  KycResponse({
    this.responseCode,
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
  });

  factory KycResponse.fromJson(Map<String, dynamic> json) => KycResponse(
        responseCode: json["responseCode"],
        description: json["description"],
        verificationType: json["verificationType"],
        verificationStatus: json["verificationStatus"],
        transactionStatus: json["transactionStatus"],
        transactionReference: json["transactionReference"],
        transactionDate: json["transactionDate"],
        searchParameter: json["searchParameter"],
        callBackUrl: json["callBackUrl"],
        livenessScore: json["livenessScore"]?.toDouble(),
        paymentRef: json["paymentRef"],
        response: json["response"] == null
            ? null
            : Responses.fromJson(json["response"]), // Use Responses.fromJson
        faceMatch: json["faceMatch"],
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "description": description,
        "verificationType": verificationType,
        "verificationStatus": verificationStatus,
        "transactionStatus": transactionStatus,
        "transactionReference": transactionReference,
        "transactionDate": transactionDate,
        "searchParameter": searchParameter,
        "callBackUrl": callBackUrl,
        "livenessScore": livenessScore,
        "paymentRef": paymentRef,
        "response": response?.toJson(),
        "faceMatch": faceMatch,
      };
}

class Responses {
  bool? validFirstName;
  bool? validLastName;
  bool? validDateOfBirth;

  Responses({
    this.validFirstName,
    this.validLastName,
    this.validDateOfBirth,
  });

  factory Responses.fromJson(Map<String, dynamic> json) => Responses(
        validFirstName: json["validFirstName"],
        validLastName: json["validLastName"],
        validDateOfBirth: json["validDateOfBirth"],
      );

  Map<String, dynamic> toJson() => {
        "validFirstName": validFirstName,
        "validLastName": validLastName,
        "validDateOfBirth": validDateOfBirth,
      };
}

NewKycResponse newKycResponseFromJson(String str) =>
    NewKycResponse.fromJson(json.decode(str));

String newKycResponseToJson(NewKycResponse data) => json.encode(data.toJson());

class NewKycResponse {
  String? firstName;
  String? lastName;
  String? searchParameter;
  String? dob;
  String? verificationType;

  NewKycResponse({
    this.firstName,
    this.lastName,
    this.searchParameter,
    this.dob,
    this.verificationType,
  });

  factory NewKycResponse.fromJson(Map<String, dynamic> json) => NewKycResponse(
        firstName: json["firstName"],
        lastName: json["lastName"],
        searchParameter: json["searchParameter"],
        dob: json["dob"],
        verificationType: json["verificationType"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "searchParameter": searchParameter,
        "dob": dob,
        "verificationType": verificationType,
      };
}

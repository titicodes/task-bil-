// To parse this JSON data, do
//
//     final newLoginResponse = newLoginResponseFromJson(jsonString);

import 'dart:convert';

NewLoginResponse newLoginResponseFromJson(String str) =>
    NewLoginResponse.fromJson(json.decode(str));

String newLoginResponseToJson(NewLoginResponse data) =>
    json.encode(data.toJson());

class NewLoginResponse {
  String? token;
  String? uid;
  bool? verifyStatus;
  bool? servicepro;
  bool? hasService;

  NewLoginResponse({
    this.token,
    this.uid,
    this.verifyStatus,
    this.servicepro,
    this.hasService,
  });

  factory NewLoginResponse.fromJson(Map<String, dynamic> json) =>
      NewLoginResponse(
        token: json["token"],
        uid: json["uid"],
        verifyStatus: json["verify-status"],
        servicepro: json["servicepro"],
        hasService: json["has_service"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "uid": uid,
        "verify-status": verifyStatus,
        "servicepro": servicepro,
        "has_service": hasService,
      };
}

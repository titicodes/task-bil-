class VerificationStatus {
  Payload? payload;

  VerificationStatus({this.payload});

  VerificationStatus.fromJson(Map<String, dynamic> json) {
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    return data;
  }
}

class Payload {
  bool? emailVerified;
  bool? bvnVerified;

  Payload({this.emailVerified, this.bvnVerified});

  Payload.fromJson(Map<String, dynamic> json) {
    emailVerified = json['email_verified'];
    bvnVerified = json['bvn_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email_verified'] = emailVerified;
    data['bvn_verified'] = bvnVerified;
    return data;
  }
}

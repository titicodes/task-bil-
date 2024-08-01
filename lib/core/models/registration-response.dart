class RegisterResponse {
  bool? failed;
  String? email;
  String? uid;
  String? username;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? dateOfBirth;
  String? referalCode;
  String? token;

  RegisterResponse(
      {this.email,
      this.failed,
      this.uid,
      this.username,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.dateOfBirth,
      this.referalCode,
      this.token});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    failed = json['failed'];
    email = json['email'];
    uid = json['uid'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    dateOfBirth = json['date_of_birth'];
    referalCode = json['referal_code'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['failed'] = failed;
    data['email'] = email;
    data['uid'] = uid;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['date_of_birth'] = dateOfBirth;
    data['referal_code'] = referalCode;
    data['token'] = token;
    return data;
  }
}

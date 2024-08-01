class User {
  String? uid;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? referalCode;
  bool? isCustomer;
  bool? isServicepro;
  String? profileImage;
  String? dateOfBirth;
  String? phoneNumber;
  double? walletBalance;
  bool? verifyStatus;
  bool? isOnline;

  User(
      {this.uid,
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.referalCode,
      this.isCustomer,
      this.isServicepro,
      this.profileImage,
      this.dateOfBirth,
      this.phoneNumber,
      this.walletBalance,
      this.verifyStatus,
      this.isOnline});

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    referalCode = json['referal_code'];
    isCustomer = json['is_customer'];
    isServicepro = json['is_servicepro'];
    profileImage = json['profile_image'];
    dateOfBirth = json['date_of_birth'];
    phoneNumber = json['phone_number'];
    walletBalance = double.tryParse(json['wallet_balance'].toString()) ?? 0;
    verifyStatus = json['verify_status'];
    isOnline = json['is_online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['username'] = username;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['referal_code'] = referalCode;
    data['is_customer'] = isCustomer;
    data['is_servicepro'] = isServicepro;
    data['profile_image'] = profileImage;
    data['date_of_birth'] = dateOfBirth;
    data['phone_number'] = phoneNumber;
    data['wallet_balance'] = walletBalance;
    data['verify_status'] = verifyStatus;
    data['is_online'] = isOnline;
    return data;
  }
}

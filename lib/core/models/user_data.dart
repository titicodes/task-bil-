import 'dart:io';

import 'registration-response.dart';

class UserData {
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? username;
  String? otp;
  String? password;
  String? oldPassword;
  String? confirmPassword;
  String? dateOfBirth;
  String? referralCode;
  String? country;
  String? additionalInfo;
  File? image;
  String? deliveryAddress;
  String? city;
  String? state;
  String? userType;
  String? token;

  UserData({
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.confirmPassword,
    this.oldPassword,
    this.otp,
    this.password,
    this.image,
    this.username,
    this.country,
    this.dateOfBirth,
    this.city,
    this.state,
    this.referralCode,
    this.additionalInfo,
    this.deliveryAddress,
    this.userType,
    this.token,
  });
}

class RegisterProviderData {
  String? companyName;
  String? categoryID;
  String? amount;
  List<String>? skill;
  List<String>? weekDays;
  String? startTime;
  String? endTime;
  String? description;
  String? country;
  String? state;
  RegisterResponse? registerResponse;

  RegisterProviderData({
    this.companyName,
    this.categoryID,
    this.amount,
    this.skill,
    this.weekDays,
    this.startTime,
    this.endTime,
    this.description,
    this.country,
    this.state,
    this.registerResponse,
  });
}

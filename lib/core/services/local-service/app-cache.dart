import 'dart:io';

import 'package:taskitly/core/models/login-response.dart';
import 'package:taskitly/core/models/new_login_response.dart';

import '../../models/all_selected_categories_list.dart' as ALL;
import '../../models/chat/join_a_room_model.dart';
import '../../models/get-otp-response.dart';
import '../../models/prodiders-service-response.dart';
import '../../models/registration-response.dart';
import '../../models/user_data.dart';

class AppCache {
  clearCheckoutData() {
    totalAmount = 0.0;
    quantityOfItems = 0;
  }

  bool? firstTimeKYC;

  double totalAmount = 0.0;
  String chatID = "";
  ALL.Category category = ALL.Category();
  GetChatDetailResponse chatDetailResponse = GetChatDetailResponse();
  ProviderUserResponse serviceProvider = ProviderUserResponse();
  int quantityOfItems = 0;
  int initialIndex = 0;
  bool isEdit = false;
  bool comingFromChangePin = false;

  String? dateOfBirth;
  File? userImage;

  String? email;
  String? userType;
  String? firstName;
  String? lastName;
  String? referralCode;
  String? password;
  String? phoneNumber;
  String? username;
  DateTime dob = DateTime.now();
  GetOtpResponse forgetPasswordResponse = GetOtpResponse();
  RegisterResponse registerResponse = RegisterResponse();
  NewLoginResponse loginResponse = NewLoginResponse();

  UserData userData = UserData();
}

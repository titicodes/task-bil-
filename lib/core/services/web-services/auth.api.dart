import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:taskitly/core/models/new_login_response.dart';

import '../../../constants/reuseables.dart';
import '../../../locator.dart';
import '../../models/block-list-response.dart';
import '../../models/bvn-response.dart';
import '../../models/change-password-response.dart';
import '../../models/chat/delete-message-response.dart';
import '../../models/create-service-response.dart';
import '../../models/default-response.dart';
import '../../models/get-otp-response.dart';
import '../../models/get-service-detail.dart';
import '../../models/login-response.dart';
import '../../models/prodiders-service-response.dart';
import '../../models/registration-response.dart';
import '../../models/user-response.dart';
import '../../models/user_data.dart';
import '../../models/verification-status.dart';
import '../local-service/storage-service.dart';
import '../local-service/user.service.dart';
import 'base-api.dart';

class AuthenticationApiService {
  StorageService storageService = locator<StorageService>();
  UserService userService = locator<UserService>();

  Future<RegisterResponse?> register({required UserData data}) async {
    try {
      Response response = await connect().post(
          data.userType == "client"
              ? "/account/register/customer/"
              : "/account/register/serviceprovider/",
          data: {
            "email": data.email,
            "username": data.username,
            "first_name": data.firstName,
            "last_name": data.lastName,
            "phone_number": data.phoneNumber,
            // "date_of_birth": data.dateOfBirth,
            "referal_code": data.referralCode,
            "password": data.password,
            "password2": data.confirmPassword
          });
      RegisterResponse? dataResponse =
          RegisterResponse.fromJson(jsonDecode(response.data));
      RegisterResponse? res = RegisterResponse(
        failed: false,
        email: dataResponse.email,
        uid: dataResponse.uid,
        username: dataResponse.username,
        firstName: dataResponse.firstName,
        lastName: dataResponse.lastName,
        phoneNumber: dataResponse.phoneNumber,
        // dateOfBirth: dataResponse.dateOfBirth,
        referalCode: dataResponse.referalCode,
        token: dataResponse.token,
      );
      return res;
    } on DioError catch (e) {
      if ("${e.response}"
          .contains("account with this phone number already exists")) {
        cache.userData.phoneNumber = data.phoneNumber;
        RegisterResponse? dataResponse = RegisterResponse(
            failed: true,
            token: "account with this phone number already exists");
        return dataResponse;
      } else {
        return null;
      }
    }
  }

  Future<CreateServiceResponse?> registerProvider(
      {required RegisterProviderData data}) async {
    try {
      var body = {
        "company_name": data.companyName,
        "category": data.categoryID,
        "amount": data.amount,
        "skills": data.skill,
        "weekdays": data.weekDays, //a list
        "start_hour": data.startTime,
        "end_hour": data.endTime,
        "description": data.description,
        "country": data.country,
        "state": data.state
      };

      Response response =
          await connect().post("/service/provider/", data: body);

      CreateServiceResponse? dataResponse =
          CreateServiceResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> updateServiceProviderDetails(
      {required ProviderUserResponse data, required String serviceID}) async {
    try {
      var body = data.image == null
          ? {
              "company_name": data.companyName,
              "category": data.category?.uid,
              "amount": data.amount,
              "skills": data.skills,
              "weekdays": data.weekdays, //a list
              "start_hour": data.startHour,
              "end_hour": data.endHour,
              "description": data.description,
              "country": data.country,
              "state": data.state,
              "rating": Ratings.calculateAverageRating(data.ratings),
              "is_online": data.provider?.isOnline,
            }
          : {
              "company_name": data.companyName,
              "category": data.category?.uid,
              "amount": data.amount,
              "skills": data.skills,
              "weekdays": data.weekdays, //a list
              "start_hour": data.startHour,
              "end_hour": data.endHour,
              "description": data.description,
              "country": data.country,
              "state": data.state,
              "rating": Ratings.calculateAverageRating(data.ratings),
              "image": await MultipartFile.fromFile(data.image ?? ""),
              "is_online": data.provider?.isOnline,
            };

      var formBody = FormData();

      if (data.image != null) {
        print("HERE");
        formBody = FormData.fromMap(body);
      }

      Response response = await connect().patch("/service/provider/$serviceID/",
          data: data.image == null ? body : formBody);
      return jsonEncode(response.data);
    } on DioError catch (e) {
      if (kDebugMode) print(e);
      return null;
    }
  }

  Future<String?> updateOnlineOffline(
      {required ProviderUserResponse data, required String serviceID}) async {
    try {
      var body = {
        "is_online": data.provider?.isOnline,
      };
      Response response = await connect()
          .patch("/account/list/${userService.user.uid}/", data: body);
      return jsonEncode(response.data);
    } on DioError catch (e) {
      if (kDebugMode) print(e);
      return null;
    }
  }

  Future<ProviderUserResponse?> getUserServiceID() async {
    try {
      Response response = await connect().get("/service/get_service/");
      ProviderServiceDetailResponse responseData =
          ProviderServiceDetailResponse.fromJson(jsonDecode(response.data));
      return responseData.data?[0];
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<List<BlockListResponse>?> getBlockedUser() async {
    try {
      Response response = await connect().get("/account/blocklist/");
      List<BlockListResponse> responseData =
          getBlockedUserListFromJson(response.data);
      return responseData;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<DefaultResponse?> unblockUser({required String userID}) async {
    try {
      Response response = await connect().post("/account/unblock/", data: {
        "otp_sent": userID,
      });
      DefaultResponse? dataResponse =
          DefaultResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<NewLoginResponse?> login({required UserData data}) async {
    try {
      Response response = await connect().post("/account/login/", data: {
        "username": data.email,
        "password": data.password,
      });
      NewLoginResponse? dataResponse =
          NewLoginResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      throw Exception(e);
      // return null;
    }
  }

  Future<DefaultResponse?> reportUser(
      {required String id,
      required String description,
      required String type}) async {
    try {
      Response response = await connect().post("/account/report/",
          data: {"orderId": id, "description": description, "type": type});
      DefaultResponse? dataResponse =
          DefaultResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<DefaultResponse?> reportChatUser(
      {required String id,
      required String description,
      required String type}) async {
    try {
      Response response = await connect().post("/account/report/",
          data: {"user_id": id, "description": description, "type": type});
      DefaultResponse? dataResponse =
          DefaultResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<DeleteMessageResponse?> deleteMessage({required String id}) async {
    try {
      Response response =
          await connect().post("/chat/delete/", data: {"user2_id": id});
      DeleteMessageResponse? dataResponse =
          DeleteMessageResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<GCMResponse?> sendToken(
      {required String data, required String type}) async {
    try {
      Response response = await connect().post("/notification/device/gcm/",
          data: {"registration_id": data, "type": type});
      GCMResponse? dataResponse =
          GCMResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<User?> getUser() async {
    NewLoginResponse loginResponse = userService.loginResponse;
    try {
      Response response =
          await connect().get("/account/list/${loginResponse.uid}/");
      User? dataResponse = User.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<User?> getPrivateUser() async {
    NewLoginResponse loginResponse = userService.loginResponse;
    try {
      Response response =
          await privateConnect().get("/account/list/${loginResponse.uid}/");
      User? dataResponse = User.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<String?> deleteAccount() async {
    try {
      Response response = await connect().post("/account/delete/");
      return jsonEncode(response.data);
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<User?> updateProfile({required UserData data}) async {
    try {
      var formData = FormData.fromMap({
        "email": data.email,
        "first_name": data.firstName,
        "last_name": data.lastName,
        "profile_image": data.image == null
            ? null
            : await MultipartFile.fromFile(data.image?.path ?? ""),
        "username": data.username,
        "phone_number": userService.user.phoneNumber
      });

      Response response = await connect().patch(
          "/account/list/${userService.loginResponse.uid}/",
          data: formData);
      User? dataResponse = User.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      if (kDebugMode) print(e.response);
      return null;
    }
  }

  Future<DefaultResponse?> resetPassword({required UserData data}) async {
    try {
      Response response =
          await connect().post("/account/forgot-change/", data: {
        "otp_sent": data.otp,
        "phone_number": data.phoneNumber,
        "password": data.password
      });
      DefaultResponse? dataResponse =
          DefaultResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<DefaultResponse?> verifyEmail({required UserData data}) async {
    try {
      Response response = await connect()
          .post("/account/verify-email/", data: {"otp_sent": data.otp});
      DefaultResponse? dataResponse =
          DefaultResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<ChangePasswordResponse?> changePassword(
      {required UserData data}) async {
    try {
      Response response =
          await connect().post("/account/change_password/", data: {
        // "otp_sent": data.otp,
        "old_password": data.oldPassword,
        "new_password": data.password
      });
      ChangePasswordResponse? dataResponse =
          ChangePasswordResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<GetOtpResponse?> verifyPhone({required UserData data}) async {
    try {
      Response response = await connect().post("/account/forgot-otp/", data: {
        "phone_number": data.phoneNumber,
      });
      GetOtpResponse? dataResponse =
          GetOtpResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<VerificationStatus?> userStatus() async {
    try {
      Response response = await connect().post("/wallet/bvn_email/");
      VerificationStatus? dataResponse =
          VerificationStatus.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<GetOtpResponse?> forgetPassword({required UserData data}) async {
    try {
      Response response = await connect().post("/account/forgot-otp/", data: {
        "phone_number": data.phoneNumber,
      });
      GetOtpResponse? dataResponse =
          GetOtpResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<GetOtpResponse?> verifyForgot(
      {required UserData data, required String pinID}) async {
    try {
      Response response =
          await connect().post("/account/verify-forgot/", data: {
        "phone_number": userService.user.phoneNumber,
        "otp_sent": data.otp,
        "pinId": pinID
      });
      GetOtpResponse? dataResponse =
          GetOtpResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<DefaultResponse?> verifyPhoneOtp(
      {required String otp, required String pinID, String? phoneNumber}) async {
    try {
      Response response = await connect().post("/account/verify-otp/", data: {
        "otp_sent": otp,
        "pinId": pinID,
        "phone_number": phoneNumber ?? userService.user.phoneNumber
      });
      DefaultResponse? dataResponse =
          DefaultResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<String?> emailVerify() async {
    try {
      Response response = await connect().post("/account/email-otp/");
      // DefaultResponse? dataResponse =
      //     DefaultResponse.fromJson(jsonDecode(response.data));
      return jsonEncode(response.data);
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<String?> sendNotification(
      {String? token, required String message, required String title}) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    try {
      var data = {
        "click_action": 'FLUTTER_NOTIFICATION_CLICK',
        "id": '1',
        "status": 'done',
        "message": message,
      };

      print(data);
      print(fcmToken);
      var response =
          await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
              headers: <String, String>{
                "Accept": "application/json",
                'Content-Type': 'application/json',
                'Authorization':
                    'key=AAAAe8lY-7E:APA91bHTLyiSTvUnbmat2O24uTQ_w4RLkZL1B1CwfWl26W95SOZLAmGcV20Vd3FXQ-OSJ5HhuJKmE-QAgvn23n_PmztfnJ4mKYFqyKiWA3dOA5RoL-jh9gFRm2K0VfDZXCE6weZIJSXm'
              },
              body: jsonEncode(<String, dynamic>{
                'notification': <String, dynamic>{
                  'title': title,
                  'body': message
                },
                'priority': 'high',
                'data': data,
                'to': token ?? fcmToken
              }));

      print(response.statusCode.toString());
      if (response.statusCode != 200) {
        // print(jsonEncode(response));
        print(jsonDecode(response.body));
      } else {
        // print(jsonEncode(response));
        print(jsonDecode(response.body));
        // showMessage(message: "${response.body}", context: context);
      }
      return response.body;
    } on DioError catch (error) {
      print(error.toString());
      // var news = DefaultResponse.fromJson(error.response?.data);
      // showMessage(message: "${news.data}", context: context);
      print('error: $error');
      handleError(error);
    }
    return null;
  }

  // channge Pin
  Future<DefaultResponse?> changeTransactionPin(
      {required String otp, required String newPin}) async {
    try {
      Response response = await connect()
          .post("/wallet/change_pin/", data: {"otp_sent": otp, "pin": newPin});
      DefaultResponse? dataResponse =
          DefaultResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }
}

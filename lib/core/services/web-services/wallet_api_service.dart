import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:taskitly/constants/constants.dart';
import 'package:taskitly/core/models/bvn_verification_response_model.dart';
import 'package:taskitly/core/services/local-service/storage-service.dart';
import 'package:taskitly/core/services/local-service/user.service.dart';
import 'package:taskitly/core/services/web-services/base-api.dart';
import 'package:taskitly/locator.dart';
import 'package:taskitly/utils/snack_message.dart';

import '../../models/account-verify-response.dart';
import '../../models/bank-list-response.dart';
import '../../models/bvn-response.dart';
import '../../models/default-response.dart';
import '../../models/fund_wallet_response.dart';
import '../../models/kyc_response.dart';
import '../../models/transaction-history-model.dart';

class WalletAPIService {
  StorageService storageService = locator<StorageService>();
  UserService userService = locator<UserService>();

  // bool isLoading = false;

  // Is loading change
  // void isLoadingToggler(bool value) {
  //   isLoading = value;
  //   notifyListeners();
  // }

  // Drivers License
  Future<Response?> verifyDriversLicensekYC({required String idNumber}) async {
    try {
      Response response = await connect().post("/wallet/driver_verify/", data: {
        "data": idNumber,
      });
      print("Drivers License BODY ${response.data}");
      print("STATUS: ${response.statusCode}");
      return response;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  // NIN
  Future<Response?> verifyNINkYC({required String idNumber}) async {
    try {
      Response response = await connect().post("/wallet/nin_verify/", data: {
        "data": idNumber,
      });
      print("NIN BODY ${response.data}");
      print("STATUS: ${response.statusCode}");
      return response;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  //  Future<Response?> ninKycVerification({required String idNumber, required String dob}) async {
  //   try {
  //     Response response = await connect().post("/wallet/nin_verify/", data: {
  //       "data": idNumber,
  //       "dob": dob
  //     });
  //     print("NIN BODY ${response.data}");
  //     print("STATUS: ${response.statusCode}");
  //     return response;
  //   } on DioError catch (e) {
  //     print(e.response);
  //     return null;
  //   }
  // }

  Future<KycResponse?> ninKycVerification(
      {required String idNumber, required String dob}) async {
    try {
      KycResponse response = await connect()
          .post("/wallet/nin_verify/", data: {"data": idNumber, "dob": dob});
      print("NIN BODY ${response.response}");
      print("STATUS: ${response.verificationStatus}");
      return response;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  //:Get list of all transactions://

  Future<TransactionHistoryModel?> getTransactionHistory() async {
    try {
      Response response = await connect().get("/wallet/transactions/?page=1");
      TransactionHistoryModel? transactionHistoryModel =
          TransactionHistoryModel.fromJson(jsonDecode(response.data));
      return transactionHistoryModel;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  // NIN AND BVN
  Future<BVNResponse?> verifyBVNAndKYC(
      {required String idNumber,
      String? dateOfBirth,
      required bool isBvn}) async {
    try {
      Response response = await connect().post("/wallet/nin_verify/",
          data: isBvn
              ? {"type": "BVN", "data": idNumber, "dob": dateOfBirth}
              : {
                  "type": "NIN",
                  "data": idNumber,
                });
      BVNResponse? bankListResponse =
          BVNResponse.fromJson(jsonDecode(response.data));
      return bankListResponse;
    } on DioError catch (e) {
      BVNResponse? bankListResponse =
          BVNResponse.fromJson(jsonDecode(e.response?.data));
      return bankListResponse;
    }
  }

  // Voters Card
  Future<Response?> verifyVotersCardkYC({
    required String idNumber,
    required File? image,
  }) async {
    var payload = FormData.fromMap({
      "data": idNumber,
      "image":
          image == null ? null : await MultipartFile.fromFile(image.path ?? ""),
    });
    try {
      Response response = await connect().post(
        "/wallet/voters_verify/",
        data: payload,
      );

      print("VOTERS CARD BODY ${response.data}");
      print("STATUS: ${response.statusCode}");
      return response;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  // Voters Card
  Future<Response?> verifyPassportkYC({
    required String idNumber,
    required File? image,
  }) async {
    try {
      var payload = FormData.fromMap({
        "data": idNumber,
        "image": image == null
            ? null
            : await MultipartFile.fromFile(image.path ?? ""),
      });
      Response response = await connect().post(
        "/wallet/pass_verify/",
        data: payload,
      );

      print("PASS-PORT BODY ${response.data}");
      print("STATUS: ${response.statusCode}");
      return response;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  // Voters Card
  Future<Response?> initWalletCreation({required String amount}) async {
    try {
      Response response = await connect().post("/wallet/init_transc/", data: {
        "amount": amount,
      });
      print("INIT WALLET BODY ${response.data}");
      print("STATUS: ${response.statusCode}");
      return response;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  //::// Get list of all banks for withdrawal//:://
  Future<BankListResponse?> getBankList({String? page}) async {
    try {
      Response response =
          await connect().get("/wallet/bank_list/?page=${page ?? "1"}");
      var originalJson = jsonDecode(response.data);
      // Map<String, dynamic> transformedJson = transformJson(originalJson);
      BankListResponse? bankListResponse =
          BankListResponse.fromJson(originalJson);
      return bankListResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Map<String, dynamic> transformJson(Map<String, dynamic> originalJson) {
    List<dynamic> result = originalJson['results'];
    List<Map<String, dynamic>> transformedResult = result.map((item) {
      return {'code': item[0], 'name': item[1]};
    }).toList();

    return {
      'count': originalJson['count'],
      'next': originalJson['next'],
      'previous': originalJson['previous'],
      'results': transformedResult
    };
  }

  //::// Bank account look up
  // Future<AccountVerifyResponse> accountLookup({
  //   required String code,
  //   required String accountNumber,
  // }) async {
  //   try {
  //     Response response = await connect().post("/wallet/bank_lookup/", data: {
  //       "code": code,
  //       "account_number": accountNumber,
  //     });
  //     AccountVerifyResponse? dataResponse =
  //         AccountVerifyResponse.fromJson(jsonDecode(response.data));
  //     return dataResponse;
  //   } on DioError catch (e) {
  //     AccountVerifyResponse? dataResponse =
  //         AccountVerifyResponse.fromJson(jsonDecode(e.response?.data));
  //     return dataResponse;
  //     // return e.response;
  //   }
  // }

  Future<AccountVerifyResponse> accountLookup({
  required String bankCode,
  required String accountNumber,
}) async {
  try {
    Response response = await connect().post("/wallet/bank_lookup/", data: {
      "bank_code": bankCode,
      "account_number": accountNumber,
    });
    AccountVerifyResponse dataResponse =
        AccountVerifyResponse.fromJson(jsonDecode(response.data));
    return dataResponse;
  } on DioError catch (e) {
    AccountVerifyResponse dataResponse =
        AccountVerifyResponse.fromJson(jsonDecode(e.response?.data));
    return dataResponse;
  }
}


  //::// Bank account confirm
  Future<DefaultResponse?> confirmAccount({
    required int amount,
    required String naration,
    required String destBankCode,
    required String destAccountNumber,
    required String destAccountName,
    required String pin,
  }) async {
    try {
      Response response =
          // await connect().post("/wallet/transfer_payment/", 
          await connect().post("/wallet/init_transc/", 
          data: {
        "amount": amount,
        "naration": naration,
        "destBankCode": destBankCode,
        "destAccountNumber": destAccountNumber,
        "destAccountName": destAccountName,
        "pin": pin
      });
      DefaultResponse? dataResponse =
          DefaultResponse.fromJson(jsonDecode(response.data));

      if (dataResponse.detail ==
          "You're not allowed to make Withdrawals. Contact Support.") {
        showCustomToast(dataResponse.detail ?? "");
      }

      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      // throw (e);
      return null;
    }
  }

  Future<FundWalletResponse?> fundWallet({required String amount}) async {
    try {
      Response response = await connect().post("/wallet/funding/", data: {
        "amount": amount,
      });
      print("Shege: ${response.data}");
      FundWalletResponse? dataResponse =
          FundWalletResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<String> topUpWallet({required String amount}) async {
    try {
      Response response =
          await connect().post("/wallet/confirm_funding/", data: {
        "amount": amount,
      });

      if (response.statusCode == 200) {
        return 'Success';
      } else {
        return 'Failed';
      }
    } on DioError catch (e) {
      print(e.response);
      return '';
    }
  }

  Future<BvnVerificationResponseModel?> kycVerification({
    required String idNumber,
    required String type,
    String? dateOfBirth,
  }) async {
    try {
      Response response = await connect().post(
        "/wallet/nin_verify/",
        data: {
          "type": type,
          "data": idNumber,
          "dob": dateOfBirth,
        },
      );

      if (response.statusCode == 202) {
        return BvnVerificationResponseModel.fromJson(response.data);
      } else if (response.statusCode == 409) {
        return const BvnVerificationResponseModel(
            status: false, datail: 'Data have been used already');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Error: ${e.message}');
      }
    }
    return null;
  }
}


  // Future<KycResponse?> kycVerification({
  //   required String idNumber,
  //   required String type,
  //   String? dateOfBirth,
  // }) async {
  //   try {
  //     Response response = await connect().post("/wallet/nin_verify/", data: {
  //       "type": type,
  //       "data": idNumber,
  //       "dob": dateOfBirth,
  //     });

  //     if (response.statusCode == 200) {
  //       return KycResponse.fromJson(jsonDecode(response.data));
  //     } else {
  //       throw Exception('Failed to verify ID');
  //     }
  //   } on DioError catch (e) {
  //     if (e.response != null) {
  //       return KycResponse.fromJson(jsonDecode(e.response!.data));
  //     } else {
  //       throw Exception('Failed to verify ID');
  //     }
  //   }
  // }
// }

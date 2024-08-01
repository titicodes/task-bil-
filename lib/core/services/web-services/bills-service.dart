import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:taskitly/core/services/web-services/base-api.dart';
import 'package:taskitly/utils/snack_message.dart';

import '../../../locator.dart';
import '../../models/airtime_response_model.dart';
import '../../models/betting-response-model.dart';
import '../../models/customer-enquiry-response.dart';
import '../../models/default-response.dart';
import '../../models/education_billers_response.dart';
import '../../models/electricity_biller_type_res.dart';
import '../../models/electricity_billers_response.dart';
import '../../models/internet_response_model.dart';
import '../../models/mtn_data_response_model.dart';
import '../../models/name-look-up-response.dart';
import '../../models/tv_bill_Response.dart';
import '../../models/tv_billers_response.dart';
import '../local-service/storage-service.dart';

class BillsService {
  StorageService storageService = locator<StorageService>();

// AIRTIME FLOW
  Future<AirtimeResponseModel?> getAirtimeBillers() async {
    try {
      Response response = await connect().post("/wallet/get_billings/",
          data: {"operationType": "get_processed", "id": "airtime"});
      AirtimeResponseModel? dataResponse =
          AirtimeResponseModel.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<dynamic> payForAirtime(
      {required String productName,
      required String phoneNumber,
      required String amount,
      required String pin}) async {
    try {
      Response response = await connect().post("/wallet/vend_billings/", data: {
        "productName": productName,
        "customerId": phoneNumber,
        "amount": amount,
        "pin": pin,
      });
      DefaultResponse? dataResponse =
          DefaultResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<NameLookUpResponse?> nameCheck({required String phoneNumber}) async {
    try {
      Response response = await connect().post("/account/check/", data: {
        "otp_sent": phoneNumber,
      });
      NameLookUpResponse responseData =
          NameLookUpResponse.fromJson(jsonDecode(response.data));
      return responseData;
    } on DioException catch (e) {
      print(e.response);
      return null;
    }
  }

  payForGifting(
      {required String phoneNumber,
      required String amount,
      required String pin}) async {
    try {
      Response response = await connect().post("/wallet/gifting/", data: {
        "phone_number": phoneNumber,
        "amount": amount,
        "pin": pin,
      });
      DefaultResponse? dataResponse =
          DefaultResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioException catch (e) {
      print(e.response);
      DefaultResponse? dataResponse =
          DefaultResponse.fromJson(jsonDecode(e.response?.data));
      showCustomToast("${dataResponse.data}");
      return null;
    }
  }

// DATA FLOW
  Future<ConvertedDataResponse?> getDataBillers(
      {required String dataBillers}) async {
    try {
      Response response = await connect().post("/wallet/get_billings/",
          data: {"operationType": "get_processed", "id": dataBillers});

      String newData = convertDataStructure(response.data);
      print(newData);
      print(jsonDecode(newData));
      ConvertedDataResponse? dataResponse =
          ConvertedDataResponse.fromJson(jsonDecode(newData));
      return dataResponse;
    } on DioException catch (e) {
      print(e.response);
      return null;
    }
  }

  String convertDataStructure(String originalJson) {
    Map<String, dynamic> originalData = json.decode(originalJson);

    List<Map<String, dynamic>> newData = [];

    originalData['data'].forEach((key, value) {
      newData.add({
        'name': key,
        'object': value,
      });
    });

    Map<String, dynamic> result = {'data': newData};

    return json.encode(result);
  }

  // ELECTRICITY FLOW
  Future<PowerDistributionResponse?> getElectricityBillers() async {
    try {
      Response response = await connect().post("/wallet/get_billings/",
          data: {"operationType": "get_processed", "id": "electricity"});
      PowerDistributionResponse? dataResponse =
          PowerDistributionResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioException catch (e) {
      print(e.response);
      return null;
    }
  }

  // ELECTRICITY TYPE FLOW
  // Future<BillerTypeResponse?> getElectricityBillersType(providerId) async {
  //   try {
  //     Response response = await connect().post("/wallet/get_billings/",
  //         data: {"operationType": "get_package", "id": "$providerId"});
  //     BillerTypeResponse? dataResponse =
  //         BillerTypeResponse.fromJson(jsonDecode(response.data));
  //     return dataResponse;
  //   } on DioException catch (e) {
  //     print(e.response);
  //     return null;
  //   }
  // }

  Future<BillerTypeResponse?> getElectricityBillersType(providerId) async {
    try {
      Response response = await connect().post("/wallet/get_billings/",
          data: {"operationType": "get_biller", "id": "$providerId"});
      BillerTypeResponse? dataResponse =
          BillerTypeResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioException catch (e) {
      print(e.response);
      return null;
    }
  }

  // BETTING FLOW
  Future<BettingResponseModel?> getBetingBillers() async {
    try {
      Response response = await connect().post("/wallet/get_billings/",
          data: {"operationType": "get_processed", "id": "betting"});
      BettingResponseModel? dataResponse =
          BettingResponseModel.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  // TV FLOW
  Future<TvBillerResponse?> getTvBillers() async {
    try {
      Response response = await connect().post("/wallet/get_billings/",
          data: {"operationType": "get_biller", "id": "3"});
      TvBillerResponse? dataResponse =
          TvBillerResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioException catch (e) {
      print(e.response);
      return null;
    }
  }

  // INTERNET FLOW
  Future<InternetResponseModel?> getInternetBillers() async {
    try {
      Response response = await connect().post("/wallet/get_billings/",
          data: {"operationType": "get_processed", "id": "internet"});
      InternetResponseModel? dataResponse =
          InternetResponseModel.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioException catch (e) {
      print(e.response);
      return null;
    }
  }

  // EDUCATION FLOW
  Future<EducationBillersResponse?> getEducationBillers() async {
    try {
      Response response = await connect().post("/wallet/get_billings/",
          data: {"operationType": "get_processed", "id": "education"});
      EducationBillersResponse? dataResponse =
          EducationBillersResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioException catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<CustomerEnquiryResponse?> checkCustomerEnquiry({
    required String meterNumber,
    required String electricitySlug,
    required String elecetricityTypeSlug,
  }) async {
    try {
      Response response =
          await connect().post("/wallet/customer_enquiry/", data: {
        "customerId": meterNumber,
        "billerSlug": electricitySlug,
        "productName": elecetricityTypeSlug,
      });
      CustomerEnquiryResponse? dataResponse =
          CustomerEnquiryResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioException catch (e) {
      print(e.response);
      return null;
    }
  }
}

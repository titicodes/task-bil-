import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskitly/core/models/order_stats_response.dart';
import 'package:taskitly/core/models/submit-review-model.dart';

import '../../../locator.dart';
import '../../models/get-order-response-model.dart';
import '../../models/send-invoice-response.dart';
import '../local-service/storage-service.dart';
import '../local-service/user.service.dart';
import 'base-api.dart';

class ServicesService {
  StorageService storageService = locator<StorageService>();
  UserService userService = locator<UserService>();

  Future<SendInvoiceResponse?> sendInvoice(
      {required String customerID,
      required List<String> skills,
      required String amount,
      required String startDate,
      required String endDate,
      String? additionalText}) async {
    try {
      var data = {
        "customer": customerID,
        "skills": skills,
        "amount": amount,
        "start_date": startDate,
        "end_date": endDate,
        "additional_text": additionalText,
      };

      Response response = await connect().post("/service/order/", data: data);
      SendInvoiceResponse? dataResponse =
          SendInvoiceResponse.fromJson(jsonDecode(response.data));
      return dataResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  // SERVICE ORDER VALIDATOR ENDPOINTS :::/:::

  Future<dynamic> sendOrdersValidator({
    required String orderId,
    required bool valid,
  }) async {
    try {
      var data = {"orderId": orderId, "valid": valid};

      Response response =
          await connect().post("/service/orders/validator/", data: data);
      // GetOrderResponse? orderResponse =
      //     GetOrderResponse.fromJson(jsonDecode(response.data));
      // return orderResponse;
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<dynamic> sendOrdersAction({
    required String orderId,
    required String action,
  }) async {
    try {
      var data = {"orderId": orderId, "action": action};
      Response response =
          await connect().post("/service/orders_action/", data: data);
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<SubmitReviewResponse?> reviewOrder({
    required String orderId,
    required String comment,
    required String rating,
  }) async {
    try {
      var data = {"order": orderId, "rating": rating, "comment": comment};
      Response response = await connect().post("/service/review/", data: data);
      SubmitReviewResponse responseData =
          SubmitReviewResponse.fromJson(jsonDecode(response.data));
      return responseData;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<dynamic> report({
    required String orderId,
    required String description,
  }) async {
    try {
      var data = {"orderId": orderId, "description": description};
      Response response = await connect().post("/service/dispute/", data: data);
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<dynamic> sendLocation({
    required String latitude,
    required String longitude,
  }) async {
    try {
      var data = {"longitude": longitude, "latitude": latitude};
      Response response =
          await connect().post("/service/location/", data: data);
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<GetOrderResponse?> getOrderService({String? page}) async {
    try {
      Response response =
          await privateConnect().get("/service/order/?page=${page ?? "1"}");
      GetOrderResponse? orderResponse =
          GetOrderResponse.fromJson(jsonDecode(response.data));
      return orderResponse;
    } on DioError catch (e) {
      print(e.response);
      return null;
    }
  }

  Future<dynamic?> fetchOrderStats({required String serviceId}) async {
    try {
      var data = {"service_id": serviceId};
      Response response = await connect().get("/service/order_stats/", data:data);
      return response.data;
    } on DioException catch (e) {
      debugPrint(e.response.toString());
      return null;
    }
  }
}

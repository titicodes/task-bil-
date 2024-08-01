import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../core/models/electricity_biller_type_res.dart';
import '../../../../base/base.vm.dart';

class ElectricityProviderTypeViewModel extends BaseViewModel {
  BillerTypeResponse electricityTypeResponseModel = BillerTypeResponse();
  List<ResponseTypeData> providers = [];
  ResponseTypeData? provider;

  String? selectedProvider;

  late BuildContext context;

  init(BuildContext contexts, int providerId) async {
    context = contexts;
    //await getLocalElectricityTypeProvider();
    if (electricityTypeResponseModel.data == null) {
      await fetchElectricityTypeProvider(providerId);
    }
  }

  onChanged(ResponseTypeData? provide) {
    provider = provide;
    notifyListeners();
  }

  void printSelectedValue(String selectedTypeSlug) {
    selectedProvider = selectedTypeSlug;
    print('Selected Provider Type Slug: $selectedTypeSlug');
    print('Selected Provider Type Slug: $selectedProvider');
  }

  getLocalElectricityTypeProvider() async {
    var response = await repository.getLocalElectricityTypeProvider();
    if (response?.data != null) {
      electricityTypeResponseModel = response ?? BillerTypeResponse();
      providers = electricityTypeResponseModel.data!.responseData!;
      // convertToPowerDistributionProviderList(electricityTypeResponseModel);
      print(jsonEncode(providers));
      stopLoader();
      notifyListeners();
    }
  }

  fetchElectricityTypeProvider(int providerId) async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      var response = await repository.getElectricityType(providerId);
      if (response?.data != null) {
        electricityTypeResponseModel = response ?? BillerTypeResponse();
        // print(electricityTypeResponseModel.)
        providers = electricityTypeResponseModel.data!.responseData!;
        //     convertToPowerDistributionProviderList(electricityTypeResponseModel);
        stopLoader();
        notifyListeners();
      }
      stopLoader();
      notifyListeners();
    } on DioException {
      stopLoader();
      notifyListeners();
    }
  }
}

// import 'dart:collection';
// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import '../../../../../core/models/airtime_response_model.dart';
// import '../../../../../core/models/electricity_biller_type_res.dart';
// import '../../../../../core/models/electricity_billers_response.dart';
// import '../../../../../utils/snack_message.dart';
// import '../../../../../utils/string-extensions.dart';
// import '../../../../base/base.vm.dart';
// import '../../../../widgets/bottomSheet.dart';
// import '../../airtime-view/airtime-view-vm.dart';

// class BettingProviderTypeViewModel extends BaseViewModel {
//   BillerTypeResponse bettingTypeResponseModel = BillerTypeResponse();
//   List<ResponseTypeData> providers = [];
//   ResponseTypeData? provider;

//   String? selectedProvider;

//   late BuildContext context;

//   init(BuildContext contexts, int providerId) async {
//     context = contexts;
//     //await getLocalElectricityTypeProvider();
//     if (bettingTypeResponseModel.data == null) {
//       await fetchElectricityTypeProvider(providerId);
//     }
//   }

//   onChanged(ResponseTypeData? provide) {
//     provider = provide;
//     notifyListeners();
//   }

//   void printSelectedValue(String selectedTypeSlug) {
//     selectedProvider = selectedTypeSlug;
//     print('Selected Provider Type Slug: $selectedTypeSlug');
//     print('Selected Provider Type Slug: $selectedProvider');
//   }

//   getLocalElectricityTypeProvider() async {
//     var response = await repository.getLocalElectricityTypeProvider();
//     if (response?.data != null) {
//       bettingTypeResponseModel = response ?? BillerTypeResponse();
//       providers = bettingTypeResponseModel.data!.responseData!;
//       // convertToPowerDistributionProviderList(electricityTypeResponseModel);
//       print(jsonEncode(providers));
//       stopLoader();
//       notifyListeners();
//     }
//   }

//   fetchElectricityTypeProvider(int providerId) async {
//     FocusManager.instance.primaryFocus?.unfocus();
//     startLoader();
//     try {
//       var response = await repository.getElectricityType(providerId);
//       if (response?.data != null) {
//         bettingTypeResponseModel = response ?? BillerTypeResponse();
//         // print(electricityTypeResponseModel.)
//         providers = bettingTypeResponseModel.data!.responseData!;
//         //     convertToPowerDistributionProviderList(electricityTypeResponseModel);
//         stopLoader();
//         notifyListeners();
//       }
//       stopLoader();
//       notifyListeners();
//     } on DioException catch (err) {
//       stopLoader();
//       notifyListeners();
//     }
//   }
// }

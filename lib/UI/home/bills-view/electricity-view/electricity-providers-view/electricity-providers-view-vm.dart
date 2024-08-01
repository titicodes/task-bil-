// import 'dart:collection';
// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import '../../../../../core/models/airtime_response_model.dart';
// import '../../../../../core/models/electricity_billers_response.dart';
// import '../../../../../utils/snack_message.dart';
// import '../../../../../utils/string-extensions.dart';
// import '../../../../base/base.vm.dart';
// import '../../../../widgets/bottomSheet.dart';
// import '../../airtime-view/airtime-view-vm.dart';

// class ElectricityProviderViewModel extends BaseViewModel {
//   PowerDistributionResponse electricityResponseModel =
//       PowerDistributionResponse();
//   List<EnuguDisco> providers = [];
//   EnuguDisco? provider;

//   String? selectedProvider;

//   late BuildContext context;

//   init(BuildContext contexts) async {
//     context = contexts;
//     await getLocalElectricityProvider();
//     if (electricityResponseModel.data == null) {
//       await fetchElectricityProvider();
//     }
//     await onChanged(providers[0]);
//   }

//   onChanged(EnuguDisco? provide) {
//     provider = provide;
//     notifyListeners();
//   }

//   // void selectProvider(String providerSlug) {
//   //   selectedProvider = providerSlug;
//   //   notifyListeners();
//   // }

//   void printSelectedValue(String selectedSlug, int providerId) {
//     selectedProvider = selectedSlug;
//     print('Selected Provider SlugID: $providerId');
//     print('Selected Provider Slug: $selectedProvider');
//   }

//   getLocalElectricityProvider() async {
//     var response = await repository.getLocalElectricityProvider();
//     if (response?.data != null) {
//       electricityResponseModel = response ?? PowerDistributionResponse();
//       providers =
//           convertToPowerDistributionProviderList(electricityResponseModel);
//       // print(jsonEncode(providers));
//       stopLoader();
//       notifyListeners();
//     }
//   }

//   fetchElectricityProvider() async {
//     FocusManager.instance.primaryFocus?.unfocus();
//     startLoader();
//     try {
//       var response = await repository.getElectricity();
//       if (response?.data != null) {
//         electricityResponseModel = response ?? PowerDistributionResponse();
//         providers =
//             convertToPowerDistributionProviderList(electricityResponseModel);
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

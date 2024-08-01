// import 'dart:collection';
// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import '../../../../../core/models/airtime_response_model.dart';
// import '../../../../../core/models/betting-response-model.dart';
// import '../../../../../core/models/electricity_billers_response.dart';
// import '../../../../../utils/snack_message.dart';
// import '../../../../../utils/string-extensions.dart';
// import '../../../../base/base.vm.dart';
// import '../../../../widgets/bottomSheet.dart';
// import '../../airtime-view/airtime-view-vm.dart';

// class BettingProviderViewModel extends BaseViewModel {
//   BettingResponseModel bettingResponseModel = BettingResponseModel();
//   List<Bet9ja> providers = [];
//   Bet9ja? provider;

//   String? selectedProvider;

//   late BuildContext context;

//   init(BuildContext contexts) async {
//     context = contexts;
//     await getLocalBettingProvider();
//     if (bettingResponseModel.data == null) {
//       await fetchBettingProvider();
//     }
//     await onChanged(providers[0]);
//   }

//   onChanged(Bet9ja? provide) {
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

//   getLocalBettingProvider() async {
//     var response = await repository.getLocalBettingProvider();
//     if (response?.data != null) {
//       bettingResponseModel = response ?? BettingResponseModel();
//       providers = convertToBettingProviderList(bettingResponseModel);
//       // print(jsonEncode(providers));
//       stopLoader();
//       notifyListeners();
//     }
//   }

//   fetchBettingProvider() async {
//     FocusManager.instance.primaryFocus?.unfocus();
//     startLoader();
//     try {
//       var response = await repository.getBetting();
//       if (response?.data != null) {
//         bettingResponseModel = response ?? BettingResponseModel();
//         providers = convertToBettingProviderList(bettingResponseModel);
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
